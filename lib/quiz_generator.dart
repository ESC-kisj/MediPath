import 'dart:math';
import 'api_service.dart';
import 'globals.dart' as globals;
import 'vocab_data.dart';

class QuizGenerator {
  static const int defaultQuestionCount = 10;
  static const int mcqOptionsCount = 4;

  /// Generate quiz questions using local vocabulary data.
  ///
  /// [difficulty] controls which vocab is used:
  ///   1 (Beginner)     – Level 1 vocab only, definition-based hints
  ///   2 (Intermediate) – Level 1+2 vocab, bidirectional questions
  ///   3 (Advanced)     – All vocab + scenario-based questions
  static Future<List<dynamic>> generateQuiz(
    globals.QuizType type, {
    int questionCount = defaultQuestionCount,
    String? selectedCategory,
    int difficulty = 1,
  }) async {
    String languageCode = LanguageHelper.getLanguageCode(globals.selectedIndex);
    String languageName = LanguageHelper.getLanguageName(globals.selectedIndex);

    // Determine max vocab level from difficulty
    int maxLevel = difficulty >= 2 ? 2 : 1;

    // Get vocab entries that have translations for selected language
    List<VocabEntry> vocabEntries = VocabData.getEntriesForLanguage(
      languageCode: languageCode,
      category: selectedCategory == 'ALL' ? null : selectedCategory,
      maxLevel: maxLevel,
    );

    if (vocabEntries.isEmpty) {
      // Fallback: try English entries if selected language has no translations
      vocabEntries = VocabData.getEntries(
        category: selectedCategory == 'ALL' ? null : selectedCategory,
        maxLevel: maxLevel,
      );
    }

    if (vocabEntries.isEmpty) {
      return _getFallbackQuestions(type, questionCount);
    }

    List<dynamic> questions = [];

    switch (type) {
      case globals.QuizType.mcq:
        questions = _generateMCQQuestions(
          vocabEntries, languageCode, languageName, questionCount, difficulty,
        );
        break;
      case globals.QuizType.typing:
        questions = _generateTypingQuestions(
          vocabEntries, languageCode, languageName, questionCount, difficulty,
        );
        break;
      case globals.QuizType.matching:
        questions = _generateMatchingQuestions(
          vocabEntries, languageCode, languageName, questionCount, difficulty,
        );
        break;
      case globals.QuizType.mixed:
        int mcqCount = (questionCount * 0.4).ceil();
        int typingCount = (questionCount * 0.3).floor();
        int matchingCount = questionCount - mcqCount - typingCount;

        // For advanced difficulty, replace some MCQ with scenario questions
        int scenarioCount = 0;
        if (difficulty >= 3) {
          scenarioCount = (mcqCount * 0.5).floor().clamp(0, VocabData.scenarios.length);
          mcqCount -= scenarioCount;
        }

        List<dynamic> mcqQuestions = _generateMCQQuestions(
          vocabEntries, languageCode, languageName, mcqCount, difficulty,
        );
        List<dynamic> typingQuestions = _generateTypingQuestions(
          vocabEntries, languageCode, languageName, typingCount, difficulty,
        );
        List<dynamic> matchingQuestions = _generateMatchingQuestions(
          vocabEntries, languageCode, languageName, matchingCount, difficulty,
        );
        List<dynamic> scenarioQuestions = [];
        if (scenarioCount > 0) {
          scenarioQuestions = _generateScenarioQuestions(scenarioCount);
        }

        questions = [
          ...mcqQuestions,
          ...typingQuestions,
          ...matchingQuestions,
          ...scenarioQuestions,
        ];
        questions.shuffle();
        break;
      case globals.QuizType.roleplay:
        questions = _generateRolePlayQuestions(
          questionCount, difficulty, languageCode, languageName,
        );
        break;
    }

    return questions.take(questionCount).toList();
  }

  // ─── MCQ Generation ───

  static List<globals.MCQQuestion> _generateMCQQuestions(
    List<VocabEntry> vocabEntries,
    String languageCode,
    String languageName,
    int count,
    int difficulty,
  ) {
    List<globals.MCQQuestion> questions = [];
    Random random = Random();
    List<VocabEntry> available = List.from(vocabEntries)..shuffle(random);

    for (int i = 0; i < count && available.isNotEmpty; i++) {
      VocabEntry correct = available.removeAt(0);
      String? translatedWord = correct.getTranslation(languageCode);
      if (translatedWord == null) continue;

      // Determine question direction based on difficulty
      bool koreanToLanguage;
      if (difficulty == 1) {
        // Beginner: always Korean → selected language (easier direction)
        koreanToLanguage = true;
      } else {
        // Intermediate/Advanced: bidirectional
        koreanToLanguage = random.nextBool();
      }

      String question;
      String correctAnswer;
      List<String> wrongAnswers = [];

      if (difficulty == 1 && random.nextBool()) {
        // Beginner bonus: definition-based questions
        question = "Which word matches this definition?\n\"${correct.definition}\"";
        correctAnswer = translatedWord;

        // Get wrong answers from same category
        List<VocabEntry> sameCategory = vocabEntries
            .where((e) => e.english != correct.english && e.getTranslation(languageCode) != null)
            .toList()..shuffle(random);
        for (var other in sameCategory) {
          if (wrongAnswers.length >= mcqOptionsCount - 1) break;
          String? otherTranslation = other.getTranslation(languageCode);
          if (otherTranslation != null && otherTranslation != correctAnswer && !wrongAnswers.contains(otherTranslation)) {
            wrongAnswers.add(otherTranslation);
          }
        }
      } else if (koreanToLanguage) {
        question = "What does '${correct.korean}' mean in $languageName?";
        correctAnswer = translatedWord;

        List<VocabEntry> others = vocabEntries
            .where((e) => e.english != correct.english && e.getTranslation(languageCode) != null)
            .toList()..shuffle(random);
        for (var other in others) {
          if (wrongAnswers.length >= mcqOptionsCount - 1) break;
          String? otherTranslation = other.getTranslation(languageCode);
          if (otherTranslation != null && otherTranslation != correctAnswer && !wrongAnswers.contains(otherTranslation)) {
            wrongAnswers.add(otherTranslation);
          }
        }
      } else {
        question = "What does '$translatedWord' mean in Korean?";
        correctAnswer = correct.korean;

        List<VocabEntry> others = vocabEntries
            .where((e) => e.korean != correct.korean)
            .toList()..shuffle(random);
        for (var other in others) {
          if (wrongAnswers.length >= mcqOptionsCount - 1) break;
          if (other.korean != correctAnswer && !wrongAnswers.contains(other.korean)) {
            wrongAnswers.add(other.korean);
          }
        }
      }

      // Pad with generic options if needed
      while (wrongAnswers.length < mcqOptionsCount - 1) {
        List<String> generics = koreanToLanguage
            ? _getGenericOptions(languageCode, correctAnswer)
            : _getGenericKoreanOptions(correctAnswer);
        for (String g in generics) {
          if (wrongAnswers.length >= mcqOptionsCount - 1) break;
          if (!wrongAnswers.contains(g) && g != correctAnswer) wrongAnswers.add(g);
        }
        break;
      }

      List<String> options = [correctAnswer, ...wrongAnswers];
      while (options.length < mcqOptionsCount) {
        options.add("Option ${options.length + 1}");
      }
      options = options.take(mcqOptionsCount).toList();
      options.shuffle(random);
      int correctIndex = options.indexOf(correctAnswer);

      String explanation = _generateExplanation(correct, translatedWord, languageName, koreanToLanguage);

      questions.add(globals.MCQQuestion(
        question: question,
        options: options,
        correctIndex: correctIndex,
        explanation: explanation,
      ));
    }

    return questions;
  }

  // ─── Typing Generation ───

  static List<globals.TypingQuestion> _generateTypingQuestions(
    List<VocabEntry> vocabEntries,
    String languageCode,
    String languageName,
    int count,
    int difficulty,
  ) {
    List<globals.TypingQuestion> questions = [];
    Random random = Random();
    List<VocabEntry> available = List.from(vocabEntries)..shuffle(random);

    for (int i = 0; i < count && available.isNotEmpty; i++) {
      VocabEntry vocab = available.removeAt(0);
      String? translatedWord = vocab.getTranslation(languageCode);
      if (translatedWord == null) continue;

      bool koreanToLanguage;
      if (difficulty == 1) {
        koreanToLanguage = true;
      } else {
        koreanToLanguage = random.nextBool();
      }

      String question;
      List<String> acceptedAnswers;

      if (koreanToLanguage) {
        question = "Type the $languageName translation of '${vocab.korean}':";
        acceptedAnswers = [translatedWord, translatedWord.toLowerCase()];
        if (translatedWord.contains(' ')) {
          acceptedAnswers.add(translatedWord.replaceAll(' ', ''));
          acceptedAnswers.add(translatedWord.toLowerCase().replaceAll(' ', ''));
        }
      } else {
        question = "Type the Korean translation of '$translatedWord':";
        acceptedAnswers = [vocab.korean];
      }

      String explanation = _generateExplanation(vocab, translatedWord, languageName, koreanToLanguage);

      questions.add(globals.TypingQuestion(
        question: question,
        acceptedAnswers: acceptedAnswers,
        explanation: explanation,
      ));
    }

    return questions;
  }

  // ─── Matching Generation ───

  static List<globals.MatchingQuestion> _generateMatchingQuestions(
    List<VocabEntry> vocabEntries,
    String languageCode,
    String languageName,
    int count,
    int difficulty,
  ) {
    List<globals.MatchingQuestion> questions = [];
    Random random = Random();
    int pairsPerQuestion = difficulty >= 3 ? 5 : 4;

    List<VocabEntry> pool = List.from(vocabEntries)..shuffle(random);

    for (int i = 0; i < count; i++) {
      Map<String, String> pairs = {};

      for (int j = 0; j < pairsPerQuestion && pool.isNotEmpty; j++) {
        VocabEntry vocab = pool.removeAt(0);
        String? translatedWord = vocab.getTranslation(languageCode);
        if (translatedWord != null && !pairs.containsKey(vocab.korean) && !pairs.containsValue(translatedWord)) {
          pairs[vocab.korean] = translatedWord;
        }
      }

      if (pairs.length >= 3) {
        String title = "Match Korean medical terms with their $languageName translations";
        String explanation = "These are medical vocabulary terms used in healthcare settings.";

        questions.add(globals.MatchingQuestion(
          title: title,
          pairs: pairs,
          explanation: explanation,
        ));
      }
    }

    return questions;
  }

  // ─── Scenario Questions (Advanced) ───

  static List<globals.MCQQuestion> _generateScenarioQuestions(int count) {
    Random random = Random();
    List<ScenarioEntry> available = List.from(VocabData.scenarios)..shuffle(random);
    List<globals.MCQQuestion> questions = [];

    for (int i = 0; i < count && i < available.length; i++) {
      ScenarioEntry scenario = available[i];

      // Question 1: scenario response
      List<String> options1 = [scenario.correctAnswer, ...scenario.wrongAnswers];
      options1.shuffle(random);
      questions.add(globals.MCQQuestion(
        question: 'Scenario: ${scenario.scenarioEnglish}\n\nThe doctor asks: "What brings you in today?"\nChoose the correct response:',
        options: options1,
        correctIndex: options1.indexOf(scenario.correctAnswer),
        explanation: 'In this scenario, the patient should describe their actual symptom. The Korean context: ${scenario.scenarioKorean}',
      ));

      // Question 2: follow-up response
      if (questions.length < count) {
        List<String> options2 = [scenario.correctFollowUp, ...scenario.wrongFollowUps];
        options2.shuffle(random);
        questions.add(globals.MCQQuestion(
          question: 'The doctor asks in Korean: "${scenario.doctorQuestionKorean}"\n(${scenario.doctorQuestionEnglish})\n\nChoose the correct response:',
          options: options2,
          correctIndex: options2.indexOf(scenario.correctFollowUp),
          explanation: 'The correct response directly addresses the doctor\'s question about the patient\'s condition.',
        ));
      }
    }

    return questions.take(count).toList();
  }

  // ─── Role Play Generation ───

  static List<globals.RolePlayQuestion> _generateRolePlayQuestions(
    int count,
    int difficulty,
    String languageCode,
    String languageName,
  ) {
    Random random = Random();

    // Select scenarios based on difficulty level
    List<RolePlayScenario> availableScenarios;
    if (difficulty == 1) {
      // Beginner: only level-1 scenarios (basic medical situations)
      availableScenarios = VocabData.rolePlayScenarios
          .where((s) => s.level <= 1)
          .toList();
    } else if (difficulty == 2) {
      // Intermediate: level 1 + 2 scenarios
      availableScenarios = VocabData.rolePlayScenarios
          .where((s) => s.level <= 2)
          .toList();
    } else {
      // Advanced: all scenarios
      availableScenarios = List.from(VocabData.rolePlayScenarios);
    }
    availableScenarios.shuffle(random);

    List<globals.RolePlayQuestion> questions = [];
    int scenariosNeeded = (count / 2).ceil(); // 2 questions per scenario

    for (int i = 0; i < scenariosNeeded && i < availableScenarios.length; i++) {
      RolePlayScenario scenario = availableScenarios[i];

      // Build scenario text based on difficulty
      String scenarioText;
      if (difficulty == 1) {
        // Beginner: show in English with Korean
        scenarioText = '${scenario.scenarioEnglish}\n${scenario.scenarioKorean}';
      } else if (difficulty == 2) {
        // Intermediate: show in user's language with Korean
        String translated = scenario.getScenarioTranslation(languageCode);
        scenarioText = '$translated\n${scenario.scenarioKorean}';
      } else {
        // Advanced: Korean only
        scenarioText = scenario.scenarioKorean;
      }

      // Build initial doctor question
      String initialDoctorQ;
      if (difficulty <= 2) {
        initialDoctorQ = '"오늘 어떻게 오셨어요?"\n(What brings you in today?)';
      } else {
        initialDoctorQ = '"오늘 어떻게 오셨어요?"';
      }

      // Get answer options in appropriate language
      String correctText;
      List<String> wrongTexts;
      if (difficulty == 1) {
        // Beginner: options in English
        correctText = scenario.correctAnswer.english;
        wrongTexts = scenario.wrongAnswers.map((w) => w.english).toList();
      } else {
        // Intermediate/Advanced: options in user's language
        correctText = scenario.correctAnswer.getTranslation(languageCode);
        wrongTexts = scenario.wrongAnswers
            .map((w) => w.getTranslation(languageCode))
            .toList();
      }

      List<String> options = [correctText, ...wrongTexts];
      options.shuffle(random);

      questions.add(globals.RolePlayQuestion(
        title: scenario.title,
        scenarioText: scenarioText,
        doctorQuestion: initialDoctorQ,
        options: options,
        correctIndex: options.indexOf(correctText),
        explanation:
            'The correct response describes the patient\'s actual symptom: "${scenario.correctAnswer.english}"',
        isFollowUp: false,
      ));

      if (questions.length >= count) break;

      // Build follow-up doctor question
      String followUpDoctorQ;
      if (difficulty == 1) {
        followUpDoctorQ =
            '"${scenario.doctorQuestionKorean}"\n(${scenario.doctorQuestionEnglish})';
      } else if (difficulty == 2) {
        followUpDoctorQ =
            '"${scenario.doctorQuestionKorean}"\n(${scenario.doctorQuestionEnglish})';
      } else {
        followUpDoctorQ = '"${scenario.doctorQuestionKorean}"';
      }

      // Get follow-up options
      String correctFollowUpText;
      List<String> wrongFollowUpTexts;
      if (difficulty == 1) {
        correctFollowUpText = scenario.correctFollowUp.english;
        wrongFollowUpTexts =
            scenario.wrongFollowUps.map((w) => w.english).toList();
      } else {
        correctFollowUpText =
            scenario.correctFollowUp.getTranslation(languageCode);
        wrongFollowUpTexts = scenario.wrongFollowUps
            .map((w) => w.getTranslation(languageCode))
            .toList();
      }

      List<String> followUpOptions = [
        correctFollowUpText,
        ...wrongFollowUpTexts,
      ];
      followUpOptions.shuffle(random);

      questions.add(globals.RolePlayQuestion(
        title: scenario.title,
        scenarioText: scenarioText,
        doctorQuestion: followUpDoctorQ,
        options: followUpOptions,
        correctIndex: followUpOptions.indexOf(correctFollowUpText),
        explanation:
            'The correct response directly answers the doctor\'s question: "${scenario.correctFollowUp.english}"',
        isFollowUp: true,
        previousAnswer: correctText,
      ));

      if (questions.length >= count) break;
    }

    return questions.take(count).toList();
  }

  // ─── Helpers ───

  static String _generateExplanation(
    VocabEntry vocab, String translation, String languageName, bool koreanToLanguage,
  ) {
    String categoryName = _getCategoryDisplayName(vocab.category);
    if (koreanToLanguage) {
      return "'${vocab.korean}' means '$translation' in $languageName. This is a $categoryName term. Definition: ${vocab.definition}";
    } else {
      return "'$translation' means '${vocab.korean}' in Korean. This is a $categoryName term. Definition: ${vocab.definition}";
    }
  }

  static String _getCategoryDisplayName(String category) {
    Map<String, String> categoryNames = {
      'body_parts': 'body parts',
      'illnesses_and_symptoms': 'illness and symptom',
      'hygiene_and_safety': 'hygiene and safety',
      'nutrition_and_food': 'nutrition and food',
      'emotions_and_feelings': 'emotional and mental health',
      'doctor_instructions': 'medical instruction',
    };
    return categoryNames[category] ?? 'medical';
  }

  static List<String> _getGenericOptions(String languageCode, String correctAnswer) {
    Map<String, List<String>> genericByLanguage = {
      'ENG': ['medicine', 'doctor', 'hospital', 'treatment', 'patient', 'clinic', 'therapy', 'surgery'],
      'VNM': ['thuốc', 'bác sĩ', 'bệnh viện', 'điều trị', 'bệnh nhân', 'phòng khám', 'liệu pháp', 'phẫu thuật'],
      'ESP': ['medicina', 'doctor', 'hospital', 'tratamiento', 'paciente', 'clínica', 'terapia', 'cirugía'],
      'CHN': ['医生', '医院', '治疗', '病人', '药物', '诊所', '手术', '疗法'],
      'PHL': ['gamot', 'doktor', 'ospital', 'paggamot', 'pasyente', 'klinika', 'therapy', 'operasyon'],
    };
    List<String> options = genericByLanguage[languageCode] ?? genericByLanguage['ENG']!;
    return options.where((o) => o != correctAnswer).toList();
  }

  static List<String> _getGenericKoreanOptions(String correctAnswer) {
    List<String> genericKorean = [
      '의사', '병원', '치료', '환자', '약물', '진료소', '수술', '요법',
      '머리', '심장', '폐', '간', '위', '눈', '귀', '코', '입',
      '감기', '열', '기침', '두통', '복통', '어지러움', '피로',
    ];
    return genericKorean.where((o) => o != correctAnswer).toList();
  }

  static List<dynamic> _getFallbackQuestions(globals.QuizType type, int count) {
    switch (type) {
      case globals.QuizType.mcq:
        return globals.sampleMCQQuestions.take(count).toList();
      case globals.QuizType.typing:
        return globals.sampleTypingQuestions.take(count).toList();
      case globals.QuizType.matching:
        return globals.sampleMatchingQuestions.take(count).toList();
      case globals.QuizType.mixed:
        List<dynamic> mixed = [
          ...globals.sampleMCQQuestions.take(count ~/ 3),
          ...globals.sampleTypingQuestions.take(count ~/ 3),
          ...globals.sampleMatchingQuestions.take(count - (2 * (count ~/ 3))),
        ];
        mixed.shuffle();
        return mixed;
      case globals.QuizType.roleplay:
        // Roleplay always uses its own data, generate with English defaults
        return _generateRolePlayQuestions(count, 1, 'ENG', 'English');
    }
  }
}
