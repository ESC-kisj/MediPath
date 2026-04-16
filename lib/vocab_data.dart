// Local vocabulary data parsed from DatabaseWords_ENGLISH.txt,
// DatabaseWords_KOREAN.txt, and TranslatedWords.txt.
//
// Each entry has a difficulty level:
//   Level 1 = Basic/Beginner terms (the numbered base terms)
//   Level 2 = Advanced terms (student-contributed additions)

class VocabEntry {
  final String english;
  final String korean;
  final String definition;
  final String category; // matches CategoryHelper codes
  final int level; // 1 or 2
  final String? tagalog;
  final String? vietnamese;
  final String? chinese;
  final String? spanish;

  const VocabEntry({
    required this.english,
    required this.korean,
    required this.definition,
    required this.category,
    required this.level,
    this.tagalog,
    this.vietnamese,
    this.chinese,
    this.spanish,
  });

  /// Get translation for a language code (ENG, VNM, ESP, CHN, PHL)
  String? getTranslation(String langCode) {
    switch (langCode.toUpperCase()) {
      case 'ENG':
        return english;
      case 'PHL':
        return tagalog;
      case 'VNM':
        return vietnamese;
      case 'CHN':
        return chinese;
      case 'ESP':
        return spanish;
      default:
        return null;
    }
  }
}

/// A single answer option with multilingual translations.
class RolePlayOption {
  final String english;
  final String? tagalog;
  final String? vietnamese;
  final String? chinese;
  final String? spanish;

  const RolePlayOption({
    required this.english,
    this.tagalog,
    this.vietnamese,
    this.chinese,
    this.spanish,
  });

  String getTranslation(String langCode) {
    switch (langCode.toUpperCase()) {
      case 'PHL': return tagalog ?? english;
      case 'VNM': return vietnamese ?? english;
      case 'CHN': return chinese ?? english;
      case 'ESP': return spanish ?? english;
      default: return english;
    }
  }
}

/// Full role-play scenario with multilingual support (from RolePlayCenter.txt).
class RolePlayScenario {
  final String title;
  final String scenarioKorean;
  final String scenarioEnglish;
  final String? scenarioTagalog;
  final String? scenarioVietnamese;
  final String? scenarioChinese;
  final String? scenarioSpanish;
  final RolePlayOption correctAnswer;
  final List<RolePlayOption> wrongAnswers;
  final String doctorQuestionKorean;
  final String doctorQuestionEnglish;
  final RolePlayOption correctFollowUp;
  final List<RolePlayOption> wrongFollowUps;
  final int level; // 1=Beginner, 2=Intermediate, 3=Advanced

  const RolePlayScenario({
    required this.title,
    required this.scenarioKorean,
    required this.scenarioEnglish,
    this.scenarioTagalog,
    this.scenarioVietnamese,
    this.scenarioChinese,
    this.scenarioSpanish,
    required this.correctAnswer,
    required this.wrongAnswers,
    required this.doctorQuestionKorean,
    required this.doctorQuestionEnglish,
    required this.correctFollowUp,
    required this.wrongFollowUps,
    this.level = 1,
  });

  String getScenarioTranslation(String langCode) {
    switch (langCode.toUpperCase()) {
      case 'ENG': return scenarioEnglish;
      case 'PHL': return scenarioTagalog ?? scenarioEnglish;
      case 'VNM': return scenarioVietnamese ?? scenarioEnglish;
      case 'CHN': return scenarioChinese ?? scenarioEnglish;
      case 'ESP': return scenarioSpanish ?? scenarioEnglish;
      default: return scenarioEnglish;
    }
  }
}

/// Scenario-based question from RolePlayCenter.txt (English-only, legacy).
class ScenarioEntry {
  final String scenarioKorean;
  final String scenarioEnglish;
  final String doctorQuestionKorean;
  final String doctorQuestionEnglish;
  final String correctAnswer;
  final List<String> wrongAnswers;
  final String correctFollowUp;
  final List<String> wrongFollowUps;

  const ScenarioEntry({
    required this.scenarioKorean,
    required this.scenarioEnglish,
    required this.doctorQuestionKorean,
    required this.doctorQuestionEnglish,
    required this.correctAnswer,
    required this.wrongAnswers,
    required this.correctFollowUp,
    required this.wrongFollowUps,
  });
}

class VocabData {
  // ─── CATEGORY 1: Body Parts ───

  static const List<VocabEntry> _bodyParts = [
    // Level 1 — base terms
    VocabEntry(
      english: 'Head', korean: '머리',
      definition: 'The top part of your body where your brain, eyes, nose, and mouth are',
      category: 'body_parts', level: 1,
      tagalog: 'Ulo', vietnamese: 'Đầu', chinese: '头', spanish: 'Cabeza',
    ),
    VocabEntry(
      english: 'Hair', korean: '머리카락',
      definition: 'The strands growing from your head',
      category: 'body_parts', level: 1,
      tagalog: 'Buhok', vietnamese: 'Tóc', chinese: '头发', spanish: 'Cabello',
    ),
    VocabEntry(
      english: 'Face', korean: '얼굴',
      definition: 'The front of your head with your eyes, nose, and mouth',
      category: 'body_parts', level: 1,
      tagalog: 'Mukha', vietnamese: 'Mặt', chinese: '脸', spanish: 'Cara',
    ),
    VocabEntry(
      english: 'Eye', korean: '눈',
      definition: 'The part of your body you use to see',
      category: 'body_parts', level: 1,
      tagalog: 'Mata', vietnamese: 'Mắt', chinese: '眼睛', spanish: 'Ojo',
    ),
    VocabEntry(
      english: 'Ear', korean: '귀',
      definition: 'The part of your body you use to hear',
      category: 'body_parts', level: 1,
      tagalog: 'Tainga', vietnamese: 'Tai', chinese: '耳朵', spanish: 'Oreja',
    ),
    VocabEntry(
      english: 'Nose', korean: '코',
      definition: 'The part you use to smell and breathe',
      category: 'body_parts', level: 1,
      tagalog: 'Ilong', vietnamese: 'Mũi', chinese: '鼻子', spanish: 'Nariz',
    ),
    VocabEntry(
      english: 'Mouth', korean: '입',
      definition: 'The opening where you eat and speak',
      category: 'body_parts', level: 1,
      tagalog: 'Bibig', vietnamese: 'Miệng', chinese: '嘴', spanish: 'Boca',
    ),
    VocabEntry(
      english: 'Teeth', korean: '이',
      definition: 'The hard parts in your mouth used to chew',
      category: 'body_parts', level: 1,
      tagalog: 'Ngipin', vietnamese: 'Răng', chinese: '牙齿', spanish: 'Dientes',
    ),
    VocabEntry(
      english: 'Neck', korean: '목',
      definition: 'Connects your head to your body',
      category: 'body_parts', level: 1,
      tagalog: 'Leeg', vietnamese: 'Cổ', chinese: '脖子', spanish: 'Cuello',
    ),
    VocabEntry(
      english: 'Shoulder', korean: '어깨',
      definition: 'The top part of your arm that connects to your body',
      category: 'body_parts', level: 1,
      tagalog: 'Balikat', vietnamese: 'Vai', chinese: '肩膀', spanish: 'Hombro',
    ),
    VocabEntry(
      english: 'Arm', korean: '팔',
      definition: 'The upper limb from shoulder to hand',
      category: 'body_parts', level: 1,
      tagalog: 'Braso', vietnamese: 'Cánh tay', chinese: '手臂', spanish: 'Brazo',
    ),
    VocabEntry(
      english: 'Elbow', korean: '팔꿈치',
      definition: 'The joint in the middle of your arm',
      category: 'body_parts', level: 1,
      tagalog: 'Siko', vietnamese: 'Khuỷu tay', chinese: '肘', spanish: 'Codo',
    ),
    VocabEntry(
      english: 'Hand', korean: '손',
      definition: 'The part with fingers that you use to hold things',
      category: 'body_parts', level: 1,
      tagalog: 'Kamay', vietnamese: 'Bàn tay', chinese: '手', spanish: 'Mano',
    ),
    VocabEntry(
      english: 'Finger', korean: '손가락',
      definition: 'The small parts on your hand used to touch and grab',
      category: 'body_parts', level: 1,
      tagalog: 'Daliri', vietnamese: 'Ngón tay', chinese: '手指', spanish: 'Dedo',
    ),
    VocabEntry(
      english: 'Chest', korean: '가슴',
      definition: 'The upper front part of your body near the heart and lungs',
      category: 'body_parts', level: 1,
      tagalog: 'Dibdib', vietnamese: 'Ngực', chinese: '胸', spanish: 'Pecho',
    ),
    VocabEntry(
      english: 'Stomach', korean: '배',
      definition: 'The area where your food goes after eating',
      category: 'body_parts', level: 1,
      tagalog: 'Tiyan', vietnamese: 'Bụng', chinese: '肚子', spanish: 'Estómago',
    ),
    VocabEntry(
      english: 'Back', korean: '등',
      definition: 'The rear part of your upper body',
      category: 'body_parts', level: 1,
      tagalog: 'Likod', vietnamese: 'Lưng', chinese: '背', spanish: 'Espalda',
    ),
    VocabEntry(
      english: 'Leg', korean: '다리',
      definition: 'The limb you use for walking',
      category: 'body_parts', level: 1,
      tagalog: 'Binti', vietnamese: 'Chân', chinese: '腿', spanish: 'Pierna',
    ),
    VocabEntry(
      english: 'Knee', korean: '무릎',
      definition: 'The joint in the middle of your leg',
      category: 'body_parts', level: 1,
      tagalog: 'Tuhod', vietnamese: 'Đầu gối', chinese: '膝盖', spanish: 'Rodilla',
    ),
    VocabEntry(
      english: 'Foot', korean: '발',
      definition: 'The part you stand on',
      category: 'body_parts', level: 1,
      tagalog: 'Paa', vietnamese: 'Bàn chân', chinese: '脚', spanish: 'Pie',
    ),
    VocabEntry(
      english: 'Toe', korean: '발가락',
      definition: 'The small parts at the end of your foot',
      category: 'body_parts', level: 1,
      tagalog: 'Daliri sa paa', vietnamese: 'Ngón chân', chinese: '脚趾', spanish: 'Dedo del pie',
    ),
    // Level 2 — advanced terms
    VocabEntry(
      english: 'Throat', korean: '목구멍',
      definition: 'The tube inside your neck that helps you swallow and talk',
      category: 'body_parts', level: 2,
      tagalog: 'Lalamunan', vietnamese: 'Họng', chinese: '喉咙', spanish: 'Garganta',
    ),
    VocabEntry(
      english: 'Eardrum', korean: '고막',
      definition: 'The membrane of the middle ear that vibrates in response to sound waves',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Forehead', korean: '이마',
      definition: 'The part of the face above the eyebrows',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Fingernail', korean: '손톱',
      definition: 'Hard keratin-based structure on the tip of fingers',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Tongue', korean: '혀',
      definition: 'Muscular organ inside the mouth essential for digestion, taste, and speech',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Spine', korean: '척추',
      definition: 'Bones on your back that support your body',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Ankle', korean: '발목',
      definition: 'The joint connecting your foot and leg',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Thumb', korean: '엄지',
      definition: 'The short, thick finger on your hand',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Waist', korean: '허리',
      definition: 'The part of the body below the ribs and above the hips',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Ribs', korean: '갈비뼈',
      definition: 'Long, curved bones covering your chest',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Joint', korean: '관절',
      definition: 'The part of your body where two or more bones meet',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Thigh', korean: '허벅지',
      definition: 'Part of the leg between the hip and the knee',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Nape', korean: '목덜미',
      definition: 'The back of your neck, right under the hairline',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Knuckles', korean: '손마디',
      definition: 'The bony bumps where your fingers bend',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Toe nails', korean: '발톱',
      definition: 'Hard coverings that protect the end of the toes',
      category: 'body_parts', level: 2,
    ),
    VocabEntry(
      english: 'Occipital', korean: '후두부',
      definition: 'Lower part of the back of your head',
      category: 'body_parts', level: 2,
    ),
  ];

  // ─── CATEGORY 2: Illnesses & Symptoms ───

  static const List<VocabEntry> _illnesses = [
    // Level 1 — base terms
    VocabEntry(
      english: 'Fever', korean: '열',
      definition: 'High body temperature',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Lagnat', vietnamese: 'Sốt', chinese: '发烧', spanish: 'Fiebre',
    ),
    VocabEntry(
      english: 'Cough', korean: '기침',
      definition: 'A sudden sound from your throat when sick',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Ubo', vietnamese: 'Ho', chinese: '咳嗽', spanish: 'Tos',
    ),
    VocabEntry(
      english: 'Sore throat', korean: '목 아픔',
      definition: 'Pain or scratchiness in your throat',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Masakit na lalamunan', vietnamese: 'Đau họng', chinese: '喉咙痛', spanish: 'Dolor de garganta',
    ),
    VocabEntry(
      english: 'Runny nose', korean: '콧물',
      definition: 'Liquid coming out of your nose',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Sipon', vietnamese: 'Chảy mũi', chinese: '流鼻涕', spanish: 'Nariz moqueante',
    ),
    VocabEntry(
      english: 'Stuffy nose', korean: '코막힘',
      definition: 'Hard to breathe through your nose',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Baradong ilong', vietnamese: 'Nghẹt mũi', chinese: '鼻塞', spanish: 'Nariz tapada',
    ),
    VocabEntry(
      english: 'Headache', korean: '두통',
      definition: 'Pain in your head',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Sakit ng ulo', vietnamese: 'Đau đầu', chinese: '头痛', spanish: 'Dolor de cabeza',
    ),
    VocabEntry(
      english: 'Stomachache', korean: '복통',
      definition: 'Pain in your belly',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Sakit ng tiyan', vietnamese: 'Đau bụng', chinese: '胃痛', spanish: 'Dolor de estómago',
    ),
    VocabEntry(
      english: 'Nausea', korean: '메스꺼움',
      definition: 'Feeling like you want to throw up',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pagduduwal', vietnamese: 'Buồn nôn', chinese: '恶心', spanish: 'Náuseas',
    ),
    VocabEntry(
      english: 'Vomiting', korean: '구토',
      definition: 'Throwing up food from your stomach',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pagsusuka', vietnamese: 'Nôn mửa', chinese: '呕吐', spanish: 'Vómitos',
    ),
    VocabEntry(
      english: 'Diarrhea', korean: '설사',
      definition: 'Going to the bathroom too often with watery stool',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pagtatae', vietnamese: 'Tiêu chảy', chinese: '腹泻', spanish: 'Diarrea',
    ),
    VocabEntry(
      english: 'Rash', korean: '발진',
      definition: 'Red, itchy skin',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pantal', vietnamese: 'Phát ban', chinese: '皮疹', spanish: 'Sarpullido',
    ),
    VocabEntry(
      english: 'Dizziness', korean: '어지러움',
      definition: 'Feeling like the room is spinning',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Nahihilo', vietnamese: 'Chóng mặt', chinese: '眩晕', spanish: 'Mareos',
    ),
    VocabEntry(
      english: 'Fatigue', korean: '피로',
      definition: 'Feeling very tired',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Matinding pagod', vietnamese: 'Mệt mỏi', chinese: '疲劳', spanish: 'Fatiga',
    ),
    VocabEntry(
      english: 'Chills', korean: '오한',
      definition: 'Feeling cold even if it is warm',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Panginginig', vietnamese: 'Ớn lạnh', chinese: '发冷', spanish: 'Escalofríos',
    ),
    VocabEntry(
      english: 'Infection', korean: '감염',
      definition: 'When germs make part of your body sick',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Impeksiyon', vietnamese: 'Nhiễm trùng', chinese: '感染', spanish: 'Infección',
    ),
    VocabEntry(
      english: 'Pain', korean: '통증',
      definition: 'A hurting feeling anywhere in the body',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Sakit', vietnamese: 'Đau', chinese: '疼痛', spanish: 'Dolor',
    ),
    VocabEntry(
      english: 'Burn', korean: '화상',
      definition: 'Skin damage from heat or fire',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Paso', vietnamese: 'Bỏng', chinese: '烫伤', spanish: 'Quemadura',
    ),
    VocabEntry(
      english: 'Bruise', korean: '멍',
      definition: 'Blue or purple mark on skin from an injury',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pasa', vietnamese: 'Bầm tím', chinese: '淤青', spanish: 'Moretón',
    ),
    VocabEntry(
      english: 'Swelling', korean: '부기',
      definition: 'When part of your body becomes bigger than usual',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pamamaga', vietnamese: 'Sưng', chinese: '肿胀', spanish: 'Hinchazón',
    ),
    VocabEntry(
      english: 'Bleeding', korean: '출혈',
      definition: 'When blood comes out of your body',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pagdurugo', vietnamese: 'Chảy máu', chinese: '出血', spanish: 'Sangrado',
    ),
    VocabEntry(
      english: 'Broken bone', korean: '골절',
      definition: 'A bone that is cracked or split',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Baling buto', vietnamese: 'Gãy xương', chinese: '骨折', spanish: 'Hueso roto',
    ),
    VocabEntry(
      english: 'Toothache', korean: '치통',
      definition: 'Pain in or around a tooth',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Sakit ng ngipin', vietnamese: 'Đau răng', chinese: '牙痛', spanish: 'Dolor de dientes',
    ),
    VocabEntry(
      english: 'Earache', korean: '귀 통증',
      definition: 'Pain inside your ear',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Sakit ng tainga', vietnamese: 'Đau tai', chinese: '耳痛', spanish: 'Dolor de oído',
    ),
    VocabEntry(
      english: 'Itchy', korean: '가려움',
      definition: 'Feeling like scratching your skin',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Makati', vietnamese: 'Ngứa', chinese: '痒', spanish: 'Picor',
    ),
    VocabEntry(
      english: 'Cramp', korean: '쥐/경련',
      definition: 'Sharp pain in a muscle',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pulikat', vietnamese: 'Chuột rút', chinese: '抽筋', spanish: 'Calambre',
    ),
    VocabEntry(
      english: 'Constipation', korean: '변비',
      definition: 'Trouble going to the bathroom',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Pagtitibi', vietnamese: 'Táo bón', chinese: '便秘', spanish: 'Estreñimiento',
    ),
    VocabEntry(
      english: 'Allergy', korean: '알레르기',
      definition: 'A reaction to food, dust, animals, etc.',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Alerhiya', vietnamese: 'Dị ứng', chinese: '过敏', spanish: 'Alergia',
    ),
    VocabEntry(
      english: 'Shortness of breath', korean: '호흡곤란',
      definition: 'Hard to breathe normally',
      category: 'illnesses_and_symptoms', level: 1,
      tagalog: 'Hirap sa paghinga', vietnamese: 'Khó thở', chinese: '呼吸困难', spanish: 'Falta de aire',
    ),
    // Level 2 — advanced terms
    VocabEntry(
      english: 'Fainting', korean: '실신',
      definition: 'Losing consciousness for a short time',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Sunstroke', korean: '일사병',
      definition: 'Feeling very sick from too much sun and heat',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Joint pain', korean: '관절통',
      definition: 'Pain in the connecting parts between bones that fit together',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Numbness', korean: '저림',
      definition: 'A loss of feeling in a part of the body',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Dehydration', korean: '탈수',
      definition: 'A condition where the body loses more fluids than it takes in',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Sneezing', korean: '재채기',
      definition: 'Sudden air comes out of your nose and mouth',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Sprain', korean: '염좌',
      definition: 'A stretching or tearing of ligaments',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Cardiac arrest', korean: '심정지',
      definition: 'Abrupt loss of heart function',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Phlegm', korean: '가래',
      definition: 'Thick mucus from your throat or lungs',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Flu', korean: '독감',
      definition: 'Illness that causes fever, chills, runny nose, etc.',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Chicken pox', korean: '수두',
      definition: 'Illness characterized by itchy rash',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Cold', korean: '감기',
      definition: 'Illness that causes sore throat, coughs, runny nose, and low-grade fever',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Abdominal pain', korean: '복부 통증',
      definition: 'Aching, stabbing, burning, or cramping of your stomach',
      category: 'illnesses_and_symptoms', level: 2,
    ),
    VocabEntry(
      english: 'Overbreathing', korean: '과호흡',
      definition: 'Rapid or deep breathing, usually caused by anxiety or panic',
      category: 'illnesses_and_symptoms', level: 2,
    ),
  ];

  // ─── CATEGORY 3: Hygiene & Safety ───

  static const List<VocabEntry> _hygiene = [
    // Level 1 — base terms
    VocabEntry(
      english: 'Wash hands', korean: '손 씻기',
      definition: 'Clean your hands with soap and water',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Maghugas ng kamay', vietnamese: 'Rửa tay', chinese: '洗手', spanish: 'Lavar las manos',
    ),
    VocabEntry(
      english: 'Sanitize', korean: '손 소독',
      definition: 'Use gel to kill germs on your hands',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Mag-sanitize', vietnamese: 'Khử trùng', chinese: '消毒', spanish: 'Desinfectar',
    ),
    VocabEntry(
      english: 'Mask', korean: '마스크',
      definition: 'Something you wear on your face to stop spreading germs',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Maskara', vietnamese: 'Khẩu trang', chinese: '口罩', spanish: 'Mascarilla',
    ),
    VocabEntry(
      english: 'Vaccine', korean: '백신',
      definition: 'A shot that helps prevent diseases',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Bakuna', vietnamese: 'Vắc-xin', chinese: '疫苗', spanish: 'Vacuna',
    ),
    VocabEntry(
      english: 'Bandage', korean: '붕대',
      definition: 'Something used to cover a cut or wound',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Benda', vietnamese: 'Băng gạc', chinese: '绷带', spanish: 'Vendaje',
    ),
    VocabEntry(
      english: 'Clean', korean: '청결한',
      definition: 'Not dirty',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Malinis', vietnamese: 'Sạch', chinese: '干净', spanish: 'Limpio',
    ),
    VocabEntry(
      english: 'Dirty', korean: '더러운',
      definition: 'Not clean',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Marumi', vietnamese: 'Bẩn', chinese: '脏', spanish: 'Sucio',
    ),
    VocabEntry(
      english: 'Germs', korean: '세균',
      definition: 'Tiny things that can make you sick',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Mikrobyo', vietnamese: 'Vi trùng', chinese: '细菌', spanish: 'Gérmenes',
    ),
    VocabEntry(
      english: 'Soap', korean: '비누',
      definition: 'Used with water to clean hands or body',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Sabon', vietnamese: 'Xà phòng', chinese: '肥皂', spanish: 'Jabón',
    ),
    VocabEntry(
      english: 'First aid', korean: '응급처치',
      definition: 'Quick help given when someone is hurt',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Unang lunas', vietnamese: 'Sơ cứu', chinese: '急救', spanish: 'Primeros auxilios',
    ),
    VocabEntry(
      english: 'Safe', korean: '안전한',
      definition: 'Not dangerous',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Ligtas', vietnamese: 'An toàn', chinese: '安全', spanish: 'Seguro',
    ),
    VocabEntry(
      english: 'Dangerous', korean: '위험한',
      definition: 'Not safe',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Delikado', vietnamese: 'Nguy hiểm', chinese: '危险', spanish: 'Peligroso',
    ),
    VocabEntry(
      english: 'Fall', korean: '넘어짐',
      definition: 'Drop to the ground suddenly',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Matumba', vietnamese: 'Ngã', chinese: '跌倒', spanish: 'Caída',
    ),
    VocabEntry(
      english: 'Slip', korean: '미끄러짐',
      definition: 'Fall because the floor is wet or smooth',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Madulas', vietnamese: 'Trượt', chinese: '滑倒', spanish: 'Resbalón',
    ),
    VocabEntry(
      english: 'Spill', korean: '쏟음',
      definition: 'When liquid falls out of a container',
      category: 'hygiene_and_safety', level: 1,
      tagalog: 'Matapon', vietnamese: 'Đổ tràn', chinese: '洒出', spanish: 'Derrame',
    ),
    // Level 2 — advanced terms
    VocabEntry(
      english: 'Gloves', korean: '장갑',
      definition: 'Clothing you wear on your hands for safety or cleanliness',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Disinfect', korean: '소독하다',
      definition: 'To kill germs on surfaces or tools',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Prevent', korean: '예방하다',
      definition: 'Take action to stop something from happening',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Apron', korean: '앞치마',
      definition: 'Cloth that is worn during work to protect clothing',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Brush teeth', korean: '양치하다',
      definition: 'To clean your teeth with toothpaste',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Helmet', korean: '헬멧',
      definition: 'Hard hat you wear to protect your head',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Knee pads', korean: '무릎 보호대',
      definition: 'Something that protects your knee',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Toothbrush', korean: '칫솔',
      definition: 'Brush used to clean your teeth',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Hand sanitizer', korean: '손 소독제',
      definition: 'Item used to disinfect hands without water',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Goggles', korean: '보안경',
      definition: 'Protective eyewear that fits closely around your eyes',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Safety vest', korean: '안전 조끼',
      definition: 'A brightly colored vest worn to keep a person visible and safe',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Equipment', korean: '장비',
      definition: 'A tool used for safety or work',
      category: 'hygiene_and_safety', level: 2,
    ),
    VocabEntry(
      english: 'Fire extinguisher', korean: '소화기',
      definition: 'A tool used to put out fires',
      category: 'hygiene_and_safety', level: 2,
    ),
  ];

  // ─── CATEGORY 4: Nutrition & Food ───

  static const List<VocabEntry> _nutrition = [
    // Level 1 — base terms
    VocabEntry(
      english: 'Water', korean: '물',
      definition: 'Clear liquid you drink',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Tubig', vietnamese: 'Nước', chinese: '水', spanish: 'Agua',
    ),
    VocabEntry(
      english: 'Milk', korean: '우유',
      definition: 'White liquid from cows',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Gatas', vietnamese: 'Sữa', chinese: '牛奶', spanish: 'Leche',
    ),
    VocabEntry(
      english: 'Juice', korean: '주스',
      definition: 'Drink made from fruits or vegetables',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Dyus', vietnamese: 'Nước ép', chinese: '果汁', spanish: 'Jugo',
    ),
    VocabEntry(
      english: 'Fruit', korean: '과일',
      definition: 'Sweet food from trees like apples or bananas',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Prutas', vietnamese: 'Trái cây', chinese: '水果', spanish: 'Fruta',
    ),
    VocabEntry(
      english: 'Vegetable', korean: '채소',
      definition: 'Healthy food like carrots or broccoli',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Gulay', vietnamese: 'Rau', chinese: '蔬菜', spanish: 'Verdura',
    ),
    VocabEntry(
      english: 'Bread', korean: '빵',
      definition: 'Baked food made from flour',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Tinapay', vietnamese: 'Bánh mì', chinese: '面包', spanish: 'Pan',
    ),
    VocabEntry(
      english: 'Rice', korean: '쌀',
      definition: 'Small white or brown grains we eat',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Kanin', vietnamese: 'Cơm', chinese: '米饭', spanish: 'Arroz',
    ),
    VocabEntry(
      english: 'Meat', korean: '고기',
      definition: 'Food from animals like beef or chicken',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Karne', vietnamese: 'Thịt', chinese: '肉', spanish: 'Carne',
    ),
    VocabEntry(
      english: 'Sugar', korean: '설탕',
      definition: 'Sweet white or brown crystals',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Asukal', vietnamese: 'Đường', chinese: '糖', spanish: 'Azúcar',
    ),
    VocabEntry(
      english: 'Salt', korean: '소금',
      definition: 'White crystals added to food for flavor',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Asin', vietnamese: 'Muối', chinese: '盐', spanish: 'Sal',
    ),
    VocabEntry(
      english: 'Snack', korean: '간식',
      definition: 'Small food between meals',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Meryenda', vietnamese: 'Bữa ăn nhẹ', chinese: '零食', spanish: 'Aperitivo',
    ),
    VocabEntry(
      english: 'Meal', korean: '식사',
      definition: 'Breakfast, lunch, or dinner',
      category: 'nutrition_and_food', level: 1,
      tagalog: 'Pagkain', vietnamese: 'Bữa ăn', chinese: '餐', spanish: 'Comida',
    ),
    // Level 2 — advanced terms
    VocabEntry(
      english: 'Protein', korean: '단백질',
      definition: 'Nutrient from meat, eggs, beans that builds muscles',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Vitamin', korean: '비타민',
      definition: 'Natural substance needed for health (like vitamin C)',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Cheese', korean: '치즈',
      definition: 'A food made from pressed curds of milk',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Oil', korean: '기름',
      definition: 'Fatty liquid used for cooking',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Calcium', korean: '칼슘',
      definition: 'Mineral your body needs to build strong bones and teeth',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Egg', korean: '달걀',
      definition: 'Oval food from birds like chickens',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Carbohydrate', korean: '탄수화물',
      definition: 'A nutrient found in food that your body uses for energy',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Fish', korean: '생선',
      definition: 'Animal from water you can eat',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Shrimp', korean: '새우',
      definition: 'Small animal from water you can eat',
      category: 'nutrition_and_food', level: 2,
    ),
    VocabEntry(
      english: 'Dairy', korean: '유제품',
      definition: 'Foods made from milk products',
      category: 'nutrition_and_food', level: 2,
    ),
  ];

  // ─── CATEGORY 5: Emotions / Feelings ───

  static const List<VocabEntry> _emotions = [
    // Level 1 — base terms
    VocabEntry(
      english: 'Happy', korean: '행복한',
      definition: 'Feeling good or pleased',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Masaya', vietnamese: 'Vui', chinese: '开心', spanish: 'Feliz',
    ),
    VocabEntry(
      english: 'Sad', korean: '슬픈',
      definition: 'Feeling bad or unhappy',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Malungkot', vietnamese: 'Buồn', chinese: '难过', spanish: 'Triste',
    ),
    VocabEntry(
      english: 'Tired', korean: '피곤한',
      definition: 'Wanting to rest or sleep',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Pagod', vietnamese: 'Mệt', chinese: '疲倦', spanish: 'Cansado',
    ),
    VocabEntry(
      english: 'Nervous', korean: '긴장한',
      definition: 'Feeling worried or scared',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Kabado', vietnamese: 'Lo lắng', chinese: '紧张', spanish: 'Nervioso',
    ),
    VocabEntry(
      english: 'Angry', korean: '화난',
      definition: 'Feeling mad',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Galit', vietnamese: 'Giận', chinese: '生气', spanish: 'Enfadado',
    ),
    VocabEntry(
      english: 'Scared', korean: '무서운',
      definition: 'Feeling afraid',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Natatakot', vietnamese: 'Sợ hãi', chinese: '害怕', spanish: 'Asustado',
    ),
    VocabEntry(
      english: 'Calm', korean: '차분한',
      definition: 'Feeling relaxed and okay',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Kalma', vietnamese: 'Bình tĩnh', chinese: '平静', spanish: 'Calmado',
    ),
    VocabEntry(
      english: 'Sick', korean: '아픈',
      definition: 'Not feeling well',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'May sakit', vietnamese: 'Ốm', chinese: '生病', spanish: 'Enfermo',
    ),
    VocabEntry(
      english: 'Okay', korean: '괜찮은',
      definition: 'Not great, but not bad',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Ayos', vietnamese: 'Ổn', chinese: '还好', spanish: 'Bien',
    ),
    VocabEntry(
      english: 'Hurt', korean: '다친',
      definition: 'When something causes you pain or injury',
      category: 'emotions_and_feelings', level: 1,
      tagalog: 'Nasaktan', vietnamese: 'Đau', chinese: '受伤', spanish: 'Dolorido',
    ),
    // Level 2 — advanced terms
    VocabEntry(
      english: 'Surprise', korean: '놀란',
      definition: 'Feeling sudden shock',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Stress', korean: '스트레스',
      definition: 'Mental or physical tension',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Depression', korean: '우울증',
      definition: 'Long-lasting sadness and loss of interest',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Bored', korean: '지루한',
      definition: 'Feeling tired and uninterested',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Bitter', korean: '씁쓸한',
      definition: 'Feeling accumulated anger or resentment',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Excited', korean: '신난',
      definition: 'Feeling very happy and full of energy',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Anxiety', korean: '불안',
      definition: 'A feeling of worry or unease about something uncertain',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Disgusted', korean: '역겨운',
      definition: 'Feeling strong revulsion',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Lonely', korean: '외로운',
      definition: 'Feeling sad because you are alone',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Overwhelmed', korean: '압도된',
      definition: 'Feeling like you have too much to manage',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Relief', korean: '안도',
      definition: 'A calm, good feeling after stress or danger goes away',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Hope', korean: '희망',
      definition: 'Optimism and expectation of positive outcomes',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Envy', korean: '질투',
      definition: 'A feeling of wanting what others possess',
      category: 'emotions_and_feelings', level: 2,
    ),
    VocabEntry(
      english: 'Fear', korean: '공포',
      definition: 'Feeling caused by threat of danger, pain, or harm',
      category: 'emotions_and_feelings', level: 2,
    ),
  ];

  // ─── CATEGORY 6: Doctor's Instructions ───

  static const List<VocabEntry> _doctorInstructions = [
    // Level 1 — base terms
    VocabEntry(
      english: 'Take this medicine', korean: '이 약을 드세요',
      definition: 'Swallow or use the medicine',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Inumin ang gamot na ito', vietnamese: 'Uống thuốc này', chinese: '服用此药', spanish: 'Tome este medicamento',
    ),
    VocabEntry(
      english: 'Twice a day', korean: '하루 두 번',
      definition: 'Two times every day',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Dalawang beses sa isang araw', vietnamese: 'Hai lần mỗi ngày', chinese: '一天两次', spanish: 'Dos veces al día',
    ),
    VocabEntry(
      english: 'Before meals', korean: '식사 전에 드세요',
      definition: 'Take it before eating',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Bago kumain', vietnamese: 'Trước bữa ăn', chinese: '饭前服用', spanish: 'Antes de comer',
    ),
    VocabEntry(
      english: 'After meals', korean: '식사 후에 드세요',
      definition: 'Take it after eating',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Pagkatapos kumain', vietnamese: 'Sau bữa ăn', chinese: '饭后服用', spanish: 'Después de comer',
    ),
    VocabEntry(
      english: "Don't eat this", korean: '이것은 먹지 마세요',
      definition: 'You must not eat it',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Huwag kainin ito', vietnamese: 'Không ăn món này', chinese: '不要吃这个', spanish: 'No coma esto',
    ),
    VocabEntry(
      english: 'Drink lots of water', korean: '물을 많이 마시세요',
      definition: 'Have many glasses of water',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Uminom ng maraming tubig', vietnamese: 'Uống nhiều nước', chinese: '多喝水', spanish: 'Beba mucha agua',
    ),
    VocabEntry(
      english: 'Get rest', korean: '쉬세요',
      definition: 'Sleep or relax your body',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Magpahinga', vietnamese: 'Nghỉ ngơi', chinese: '休息', spanish: 'Descanse',
    ),
    VocabEntry(
      english: 'Go to the hospital', korean: '병원에 가세요',
      definition: 'Visit the doctor or emergency room',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Pumunta sa ospital', vietnamese: 'Đến bệnh viện', chinese: '去医院', spanish: 'Vaya al hospital',
    ),
    VocabEntry(
      english: 'Come back next week', korean: '다음 주에 다시 오세요',
      definition: 'Return after 7 days',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Bumalik sa susunod na linggo', vietnamese: 'Quay lại tuần sau', chinese: '下周复诊', spanish: 'Vuelva la próxima semana',
    ),
    VocabEntry(
      english: 'Take your temperature', korean: '체온을 재세요',
      definition: 'Use a thermometer to measure body heat',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Sukatin ang temperatura', vietnamese: 'Đo nhiệt độ', chinese: '量体温', spanish: 'Tómese la temperatura',
    ),
    VocabEntry(
      english: 'Follow instructions', korean: '지시를 따르세요',
      definition: 'Do what the doctor says',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Sundin ang mga tagubilin', vietnamese: 'Làm theo hướng dẫn', chinese: '遵医嘱', spanish: 'Siga las instrucciones',
    ),
    VocabEntry(
      english: "Don't touch the wound", korean: '상처를 만지지 마세요',
      definition: 'Keep your hands off the injury',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Huwag hawakan ang sugat', vietnamese: 'Đừng chạm vết thương', chinese: '别碰伤口', spanish: 'No toque la herida',
    ),
    VocabEntry(
      english: 'Avoid salty food', korean: '짜게 먹지 마세요',
      definition: "Don't eat too much salt",
      category: 'doctor_instructions', level: 1,
      tagalog: 'Iwasan ang maalat na pagkain', vietnamese: 'Hạn chế muối', chinese: '少盐饮食', spanish: 'Evite la sal excesiva',
    ),
    VocabEntry(
      english: 'Check your blood pressure', korean: '혈압을 재세요',
      definition: 'Measure the pressure of your blood',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Sukatin ang presyon ng dugo', vietnamese: 'Đo huyết áp', chinese: '测血压', spanish: 'Revise su presión arterial',
    ),
    VocabEntry(
      english: 'Use the cream', korean: '연고를 바르세요',
      definition: 'Put the medicine on your skin',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Ipahid ang krema', vietnamese: 'Bôi kem', chinese: '涂药膏', spanish: 'Use la crema',
    ),
    VocabEntry(
      english: 'Cover your mouth', korean: '입을 가리세요',
      definition: 'Put hand or mask over mouth when coughing',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Takpan ang bibig', vietnamese: 'Che miệng', chinese: '捂住嘴', spanish: 'Cúbrase la boca',
    ),
    VocabEntry(
      english: 'Stay home', korean: '집에 계세요',
      definition: "Don't go out",
      category: 'doctor_instructions', level: 1,
      tagalog: 'Manatili sa bahay', vietnamese: 'Ở nhà', chinese: '待在家', spanish: 'Quédese en casa',
    ),
    VocabEntry(
      english: 'Wear a mask', korean: '마스크를 착용하세요',
      definition: 'Put on a mask to protect others',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Magsuot ng mask', vietnamese: 'Đeo khẩu trang', chinese: '戴口罩', spanish: 'Use mascarilla',
    ),
    VocabEntry(
      english: 'Take deep breaths', korean: '깊게 숨 쉬세요',
      definition: 'Breathe slowly and deeply',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Huminga nang malalim', vietnamese: 'Thở sâu', chinese: '深呼吸', spanish: 'Respire profundo',
    ),
    VocabEntry(
      english: "Don't scratch", korean: '긁지 마세요',
      definition: 'Do not use your nails on your skin',
      category: 'doctor_instructions', level: 1,
      tagalog: 'Huwag kumamot', vietnamese: 'Đừng gãi', chinese: '不要抓', spanish: 'No se rasque',
    ),
    // Level 2 — advanced terms
    VocabEntry(
      english: "Don't worry", korean: '걱정하지 마세요',
      definition: 'Everything is okay',
      category: 'doctor_instructions', level: 2,
      tagalog: 'Huwag mag-alala', vietnamese: 'Đừng lo', chinese: '别担心', spanish: 'No se preocupe',
    ),
    VocabEntry(
      english: 'Take your pulse', korean: '맥박을 재세요',
      definition: 'Measure how fast your heart is beating',
      category: 'doctor_instructions', level: 2,
    ),
    VocabEntry(
      english: 'Monitor symptoms', korean: '증상을 관찰하세요',
      definition: 'Watch carefully for changes in your health',
      category: 'doctor_instructions', level: 2,
    ),
    VocabEntry(
      english: 'Rest for a week', korean: '일주일간 쉬세요',
      definition: 'Take it easy and not work for the week',
      category: 'doctor_instructions', level: 2,
    ),
    VocabEntry(
      english: 'Avoid junk food', korean: '정크 푸드를 피하세요',
      definition: "Don't eat unhealthy food",
      category: 'doctor_instructions', level: 2,
    ),
    VocabEntry(
      english: 'Breathe slowly', korean: '천천히 숨 쉬세요',
      definition: 'Take calm, gentle breaths',
      category: 'doctor_instructions', level: 2,
    ),
    VocabEntry(
      english: 'Avoid alcohol', korean: '술을 피하세요',
      definition: "Don't drink anything with alcohol",
      category: 'doctor_instructions', level: 2,
    ),
    VocabEntry(
      english: "Don't smoke", korean: '담배를 피우지 마세요',
      definition: "Don't smoke for your lung health",
      category: 'doctor_instructions', level: 2,
    ),
    VocabEntry(
      english: 'Stay calm', korean: '진정하세요',
      definition: 'Keep your mind and body relaxed',
      category: 'doctor_instructions', level: 2,
    ),
  ];

  // ─── Scenario questions (from RolePlayCenter.txt) ───

  static const List<ScenarioEntry> scenarios = [
    ScenarioEntry(
      scenarioKorean: '아나는 열이 나고 오한이 있습니다.',
      scenarioEnglish: 'Ana has a fever and chills.',
      doctorQuestionKorean: '언제부터 열이 있었어요?',
      doctorQuestionEnglish: 'Since when have you had a fever?',
      correctAnswer: 'I have a fever.',
      wrongAnswers: ['I have a toothache.', 'I am happy.'],
      correctFollowUp: 'Since yesterday.',
      wrongFollowUps: ['I like soup.', 'My foot is itchy.'],
    ),
    ScenarioEntry(
      scenarioKorean: '카일은 예방접종을 받으러 병원에 왔습니다.',
      scenarioEnglish: 'Kyle came to the clinic for a vaccine.',
      doctorQuestionKorean: '조금 따끔할 거예요. 괜찮으세요?',
      doctorQuestionEnglish: 'It will sting a little. Are you okay?',
      correctAnswer: "I'm here for a vaccine.",
      wrongAnswers: ['I want ice cream.', 'My shoes are wet.'],
      correctFollowUp: "Yes, I'm ready.",
      wrongFollowUps: ['No, I want to go home.', 'My mom is cooking.'],
    ),
    ScenarioEntry(
      scenarioKorean: '리나는 배가 아파서 병원에 왔습니다.',
      scenarioEnglish: 'Rina came to the hospital because her stomach hurts.',
      doctorQuestionKorean: '무엇을 먹었는지 기억나세요?',
      doctorQuestionEnglish: 'Do you remember what you ate?',
      correctAnswer: 'My stomach hurts.',
      wrongAnswers: ['My eyes are blue.', 'It is snowing.'],
      correctFollowUp: 'I ate spicy food.',
      wrongFollowUps: ['I went swimming.', 'I saw a cat.'],
    ),
    ScenarioEntry(
      scenarioKorean: '미겔은 어제부터 설사를 하고 있습니다.',
      scenarioEnglish: 'Miguel has had diarrhea since yesterday.',
      doctorQuestionKorean: '언제부터 그랬어요?',
      doctorQuestionEnglish: 'Since when has it been happening?',
      correctAnswer: 'I have diarrhea.',
      wrongAnswers: ['I like bananas.', 'I want to dance.'],
      correctFollowUp: 'Since last night.',
      wrongFollowUps: ['I like ice cream.', 'My ears are ringing.'],
    ),
    ScenarioEntry(
      scenarioKorean: '사라는 밤에 잠을 잘 수 없습니다.',
      scenarioEnglish: 'Sara cannot sleep at night.',
      doctorQuestionKorean: '스트레스를 많이 받으세요?',
      doctorQuestionEnglish: 'Are you feeling stressed?',
      correctAnswer: "I can't sleep at night.",
      wrongAnswers: ['I need new shoes.', 'My friend is tall.'],
      correctFollowUp: 'Yes, I feel stressed.',
      wrongFollowUps: ['I ate pizza.', 'I like music.'],
    ),
    ScenarioEntry(
      scenarioKorean: '진수는 치통이 있어서 치과에 왔습니다.',
      scenarioEnglish: 'Jinsoo has a toothache and went to the dentist.',
      doctorQuestionKorean: '얼마나 오래 아팠어요?',
      doctorQuestionEnglish: 'How long has it been hurting?',
      correctAnswer: 'My tooth hurts.',
      wrongAnswers: ['I washed my hands.', "It's raining today."],
      correctFollowUp: 'For three days.',
      wrongFollowUps: ['I want lunch.', 'My dog is loud.'],
    ),
    ScenarioEntry(
      scenarioKorean: '엘라는 눈이 가렵다고 말합니다.',
      scenarioEnglish: 'Ella says her eyes are itchy.',
      doctorQuestionKorean: '꽃가루 알레르기가 있나요?',
      doctorQuestionEnglish: 'Do you have a pollen allergy?',
      correctAnswer: 'My eyes are itchy.',
      wrongAnswers: ['I went running.', 'I saw a movie.'],
      correctFollowUp: 'Yes, I have pollen allergy.',
      wrongFollowUps: ['I drank coffee.', 'I like spring.'],
    ),
    ScenarioEntry(
      scenarioKorean: '다니엘은 피곤하고 기운이 없습니다.',
      scenarioEnglish: 'Daniel feels tired and weak.',
      doctorQuestionKorean: '수면은 잘 취하고 있나요?',
      doctorQuestionEnglish: 'Are you sleeping well?',
      correctAnswer: 'I feel tired.',
      wrongAnswers: ['I have a cat.', 'I watched TV.'],
      correctFollowUp: 'No, I sleep late.',
      wrongFollowUps: ['I bought candy.', 'My hands are cold.'],
    ),
    ScenarioEntry(
      scenarioKorean: '윤호는 감정적으로 매우 슬퍼 보입니다.',
      scenarioEnglish: 'Yoonho looks very sad emotionally.',
      doctorQuestionKorean: '최근에 스트레스를 받는 일이 있었나요?',
      doctorQuestionEnglish: 'Have you been stressed recently?',
      correctAnswer: 'I feel sad.',
      wrongAnswers: ['I play video games.', 'I like blue.'],
      correctFollowUp: 'Yes, at school.',
      wrongFollowUps: ['My dog barks.', 'I ate cake.'],
    ),
    ScenarioEntry(
      scenarioKorean: '해리는 손가락을 베였습니다.',
      scenarioEnglish: 'Harry cut his finger.',
      doctorQuestionKorean: '상처가 깊은가요?',
      doctorQuestionEnglish: 'Is the cut deep?',
      correctAnswer: 'I cut my finger.',
      wrongAnswers: ['I see a bird.', 'I drank milk.'],
      correctFollowUp: "Yes, it's bleeding.",
      wrongFollowUps: ['I love painting.', 'The sun is hot.'],
    ),
  ];

  // ─── Role Play Scenarios (from RolePlayCenter.txt) ───

  static const List<RolePlayScenario> rolePlayScenarios = [
    // Level 1 — Basic medical situations
    RolePlayScenario(
      title: 'Fever & Chills',
      level: 1,
      scenarioKorean: '아나는 열이 나고 오한이 있습니다.',
      scenarioEnglish: 'Ana has a fever and chills.',
      scenarioTagalog: 'May lagnat si Ana at nilalamig siya.',
      scenarioVietnamese: 'Ana bị sốt và ớn lạnh.',
      scenarioChinese: '安娜发烧并感到发冷。',
      scenarioSpanish: 'Ana tiene fiebre y escalofríos.',
      correctAnswer: RolePlayOption(
        english: 'I have a fever.',
        tagalog: 'May lagnat ako.',
        vietnamese: 'Tôi bị sốt.',
        chinese: '我发烧了。',
        spanish: 'Tengo fiebre.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I have a toothache.',
          tagalog: 'Masakit ang ngipin ko.',
          vietnamese: 'Tôi đau răng.',
          chinese: '我牙疼。',
          spanish: 'Me duele una muela.',
        ),
        RolePlayOption(
          english: 'I am happy.',
          tagalog: 'Masaya ako.',
          vietnamese: 'Tôi vui.',
          chinese: '我很开心。',
          spanish: 'Estoy feliz.',
        ),
      ],
      doctorQuestionKorean: '언제부터 열이 있었어요?',
      doctorQuestionEnglish: 'Since when have you had a fever?',
      correctFollowUp: RolePlayOption(
        english: 'Since yesterday.',
        tagalog: 'Simula kahapon.',
        vietnamese: 'Từ hôm qua.',
        chinese: '从昨天开始。',
        spanish: 'Desde ayer.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'I like soup.',
          tagalog: 'Gusto ko ng sabaw.',
          vietnamese: 'Tôi thích súp.',
          chinese: '我喜欢汤。',
          spanish: 'Me gusta la sopa.',
        ),
        RolePlayOption(
          english: 'My foot is itchy.',
          tagalog: 'Makati ang paa ko.',
          vietnamese: 'Chân tôi bị ngứa.',
          chinese: '我的脚很痒。',
          spanish: 'Me pica el pie.',
        ),
      ],
    ),
    RolePlayScenario(
      title: 'Vaccine Appointment',
      level: 1,
      scenarioKorean: '카일은 예방접종을 받으러 병원에 왔습니다.',
      scenarioEnglish: 'Kyle came to the clinic for a vaccine.',
      scenarioTagalog: 'Pumunta si Kyle sa klinika para magpabakuna.',
      scenarioVietnamese: 'Kyle đến phòng khám để tiêm phòng.',
      scenarioChinese: '凯尔去诊所打疫苗。',
      scenarioSpanish: 'Kyle fue a la clínica para vacunarse.',
      correctAnswer: RolePlayOption(
        english: "I'm here for a vaccine.",
        tagalog: 'Nandito ako para sa bakuna.',
        vietnamese: 'Tôi đến để tiêm vắc xin.',
        chinese: '我是来打疫苗的。',
        spanish: 'Vine a vacunarme.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I want ice cream.',
          tagalog: 'Gusto ko ng sorbetes.',
          vietnamese: 'Tôi muốn kem.',
          chinese: '我想吃冰淇淋。',
          spanish: 'Quiero helado.',
        ),
        RolePlayOption(
          english: 'My shoes are wet.',
          tagalog: 'Basa ang sapatos ko.',
          vietnamese: 'Giày tôi bị ướt.',
          chinese: '我的鞋子湿了。',
          spanish: 'Mis zapatos están mojados.',
        ),
      ],
      doctorQuestionKorean: '조금 따끔할 거예요. 괜찮으세요?',
      doctorQuestionEnglish: 'It will sting a little. Are you okay?',
      correctFollowUp: RolePlayOption(
        english: "Yes, I'm ready.",
        tagalog: 'Oo, handa na ako.',
        vietnamese: 'Vâng, tôi sẵn sàng.',
        chinese: '是的，我准备好了。',
        spanish: 'Sí, estoy listo.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'No, I want to go home.',
          tagalog: 'Hindi, gusto kong umuwi.',
          vietnamese: 'Không, tôi muốn về nhà.',
          chinese: '不，我想回家。',
          spanish: 'No, quiero irme a casa.',
        ),
        RolePlayOption(
          english: 'My mom is cooking.',
          tagalog: 'Nagluluto ang nanay ko.',
          vietnamese: 'Mẹ tôi đang nấu ăn.',
          chinese: '我妈妈在做饭。',
          spanish: 'Mi mamá está cocinando.',
        ),
      ],
    ),
    RolePlayScenario(
      title: 'Stomachache',
      level: 1,
      scenarioKorean: '리나는 배가 아파서 병원에 왔습니다.',
      scenarioEnglish: 'Rina came to the hospital because her stomach hurts.',
      scenarioTagalog: 'Masakit ang tiyan ni Rina.',
      scenarioVietnamese: 'Rina bị đau bụng.',
      scenarioChinese: '莉娜肚子痛。',
      scenarioSpanish: 'Rina tiene dolor de estómago.',
      correctAnswer: RolePlayOption(
        english: 'My stomach hurts.',
        tagalog: 'Masakit ang tiyan ko.',
        vietnamese: 'Tôi bị đau bụng.',
        chinese: '我肚子疼。',
        spanish: 'Me duele el estómago.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'My eyes are blue.',
          tagalog: 'Asul ang mga mata ko.',
          vietnamese: 'Mắt tôi màu xanh.',
          chinese: '我有蓝眼睛。',
          spanish: 'Tengo ojos azules.',
        ),
        RolePlayOption(
          english: 'It is snowing.',
          tagalog: 'Umuulan ng niyebe.',
          vietnamese: 'Trời đang tuyết.',
          chinese: '下雪了。',
          spanish: 'Está nevando.',
        ),
      ],
      doctorQuestionKorean: '무엇을 먹었는지 기억나세요?',
      doctorQuestionEnglish: 'Do you remember what you ate?',
      correctFollowUp: RolePlayOption(
        english: 'I ate spicy food.',
        tagalog: 'Kumain ako ng maanghang.',
        vietnamese: 'Tôi ăn đồ cay.',
        chinese: '我吃了辣的食物。',
        spanish: 'Comí comida picante.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'I went swimming.',
          tagalog: 'Lumangoy ako.',
          vietnamese: 'Tôi đã bơi.',
          chinese: '我去游泳了。',
          spanish: 'Fui a nadar.',
        ),
        RolePlayOption(
          english: 'I saw a cat.',
          tagalog: 'Nakakita ako ng pusa.',
          vietnamese: 'Tôi thấy một con mèo.',
          chinese: '我看到一只猫。',
          spanish: 'Vi un gato.',
        ),
      ],
    ),
    RolePlayScenario(
      title: 'Diarrhea',
      level: 1,
      scenarioKorean: '미겔은 어제부터 설사를 하고 있습니다.',
      scenarioEnglish: 'Miguel has had diarrhea since yesterday.',
      scenarioTagalog: 'May diarrhea si Miguel simula kahapon.',
      scenarioVietnamese: 'Miguel bị tiêu chảy từ hôm qua.',
      scenarioChinese: '米格尔从昨天开始拉肚子。',
      scenarioSpanish: 'Miguel tiene diarrea desde ayer.',
      correctAnswer: RolePlayOption(
        english: 'I have diarrhea.',
        tagalog: 'May diarrhea ako.',
        vietnamese: 'Tôi bị tiêu chảy.',
        chinese: '我拉肚子了。',
        spanish: 'Tengo diarrea.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I like bananas.',
          tagalog: 'Gusto ko ng saging.',
          vietnamese: 'Tôi thích chuối.',
          chinese: '我喜欢香蕉。',
          spanish: 'Me gustan los plátanos.',
        ),
        RolePlayOption(
          english: 'I want to dance.',
          tagalog: 'Gusto kong sumayaw.',
          vietnamese: 'Tôi muốn nhảy.',
          chinese: '我想跳舞。',
          spanish: 'Quiero bailar.',
        ),
      ],
      doctorQuestionKorean: '언제부터 그랬어요?',
      doctorQuestionEnglish: 'Since when has it been happening?',
      correctFollowUp: RolePlayOption(
        english: 'Since last night.',
        tagalog: 'Simula kagabi.',
        vietnamese: 'Từ tối qua.',
        chinese: '从昨晚开始。',
        spanish: 'Desde anoche.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'I like ice cream.',
          tagalog: 'Gusto ko ng sorbetes.',
          vietnamese: 'Tôi thích kem.',
          chinese: '我喜欢冰淇淋。',
          spanish: 'Me gusta el helado.',
        ),
        RolePlayOption(
          english: 'My ears are ringing.',
          tagalog: 'Umiingay ang tenga ko.',
          vietnamese: 'Tai tôi đang ù.',
          chinese: '我耳鸣。',
          spanish: 'Me zumban los oídos.',
        ),
      ],
    ),
    // Level 2 — Intermediate medical situations
    RolePlayScenario(
      title: 'Insomnia',
      level: 2,
      scenarioKorean: '사라는 밤에 잠을 잘 수 없습니다.',
      scenarioEnglish: 'Sara cannot sleep at night.',
      scenarioTagalog: 'Hindi makatulog si Sara tuwing gabi.',
      scenarioVietnamese: 'Sara không thể ngủ vào ban đêm.',
      scenarioChinese: '萨拉晚上睡不着觉。',
      scenarioSpanish: 'Sara no puede dormir por las noches.',
      correctAnswer: RolePlayOption(
        english: "I can't sleep at night.",
        tagalog: 'Hindi ako makatulog sa gabi.',
        vietnamese: 'Tôi không ngủ được vào ban đêm.',
        chinese: '我晚上睡不着。',
        spanish: 'No puedo dormir por las noches.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I need new shoes.',
          tagalog: 'Kailangan ko ng bagong sapatos.',
          vietnamese: 'Tôi cần đôi giày mới.',
          chinese: '我需要新鞋。',
          spanish: 'Necesito zapatos nuevos.',
        ),
        RolePlayOption(
          english: 'My friend is tall.',
          tagalog: 'Matangkad ang kaibigan ko.',
          vietnamese: 'Bạn tôi cao.',
          chinese: '我朋友很高。',
          spanish: 'Mi amigo es alto.',
        ),
      ],
      doctorQuestionKorean: '스트레스를 많이 받으세요?',
      doctorQuestionEnglish: 'Are you feeling stressed?',
      correctFollowUp: RolePlayOption(
        english: 'Yes, I feel stressed.',
        tagalog: 'Oo, stress ako.',
        vietnamese: 'Vâng, tôi căng thẳng.',
        chinese: '是的，我很有压力。',
        spanish: 'Sí, me siento estresado.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'I ate pizza.',
          tagalog: 'Kumain ako ng pizza.',
          vietnamese: 'Tôi đã ăn pizza.',
          chinese: '我吃了披萨。',
          spanish: 'Comí pizza.',
        ),
        RolePlayOption(
          english: 'I like music.',
          tagalog: 'Gusto ko ng musika.',
          vietnamese: 'Tôi thích âm nhạc.',
          chinese: '我喜欢音乐。',
          spanish: 'Me gusta la música.',
        ),
      ],
    ),
    RolePlayScenario(
      title: 'Toothache',
      level: 2,
      scenarioKorean: '진수는 치통이 있어서 치과에 왔습니다.',
      scenarioEnglish: 'Jinsoo has a toothache and went to the dentist.',
      scenarioTagalog: 'Masakit ang ngipin ni Jinsoo kaya pumunta siya sa dentista.',
      scenarioVietnamese: 'Jinsoo bị đau răng nên đã đến nha sĩ.',
      scenarioChinese: '珍秀牙疼，所以去了牙医诊所。',
      scenarioSpanish: 'Jinsoo tiene dolor de muelas y fue al dentista.',
      correctAnswer: RolePlayOption(
        english: 'My tooth hurts.',
        tagalog: 'Masakit ang ngipin ko.',
        vietnamese: 'Tôi bị đau răng.',
        chinese: '我牙疼。',
        spanish: 'Me duele una muela.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I washed my hands.',
          tagalog: 'Naghugas ako ng kamay.',
          vietnamese: 'Tôi đã rửa tay.',
          chinese: '我洗了手。',
          spanish: 'Me lavé las manos.',
        ),
        RolePlayOption(
          english: "It's raining today.",
          tagalog: 'Umuulan ngayon.',
          vietnamese: 'Hôm nay trời mưa.',
          chinese: '今天在下雨。',
          spanish: 'Hoy está lloviendo.',
        ),
      ],
      doctorQuestionKorean: '얼마나 오래 아팠어요?',
      doctorQuestionEnglish: 'How long has it been hurting?',
      correctFollowUp: RolePlayOption(
        english: 'For three days.',
        tagalog: 'Tatlong araw na.',
        vietnamese: 'Ba ngày rồi.',
        chinese: '三天了。',
        spanish: 'Desde hace tres días.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'I want lunch.',
          tagalog: 'Gusto ko ng tanghalian.',
          vietnamese: 'Tôi muốn ăn trưa.',
          chinese: '我想吃午饭。',
          spanish: 'Quiero almorzar.',
        ),
        RolePlayOption(
          english: 'My dog is loud.',
          tagalog: 'Maingay ang aso ko.',
          vietnamese: 'Chó tôi ồn ào.',
          chinese: '我家的狗很吵。',
          spanish: 'Mi perro es ruidoso.',
        ),
      ],
    ),
    RolePlayScenario(
      title: 'Itchy Eyes',
      level: 2,
      scenarioKorean: '엘라는 눈이 가렵다고 말합니다.',
      scenarioEnglish: 'Ella says her eyes are itchy.',
      scenarioTagalog: 'Makating-makati ang mga mata ni Ella.',
      scenarioVietnamese: 'Mắt của Ella bị ngứa.',
      scenarioChinese: '艾拉觉得眼睛很痒。',
      scenarioSpanish: 'A Ella le pican los ojos.',
      correctAnswer: RolePlayOption(
        english: 'My eyes are itchy.',
        tagalog: 'Makati ang mga mata ko.',
        vietnamese: 'Mắt tôi bị ngứa.',
        chinese: '我眼睛很痒。',
        spanish: 'Me pican los ojos.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I went running.',
          tagalog: 'Nag-jogging ako.',
          vietnamese: 'Tôi đã chạy bộ.',
          chinese: '我去跑步了。',
          spanish: 'Fui a correr.',
        ),
        RolePlayOption(
          english: 'I saw a movie.',
          tagalog: 'Nanood ako ng pelikula.',
          vietnamese: 'Tôi đã xem phim.',
          chinese: '我看了一部电影。',
          spanish: 'Vi una película.',
        ),
      ],
      doctorQuestionKorean: '꽃가루 알레르기가 있나요?',
      doctorQuestionEnglish: 'Do you have a pollen allergy?',
      correctFollowUp: RolePlayOption(
        english: 'Yes, I have pollen allergy.',
        tagalog: 'Oo, may allergy ako sa pollen.',
        vietnamese: 'Vâng, tôi bị dị ứng phấn hoa.',
        chinese: '是的，我对花粉过敏。',
        spanish: 'Sí, tengo alergia al polen.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'I drank coffee.',
          tagalog: 'Uminom ako ng kape.',
          vietnamese: 'Tôi đã uống cà phê.',
          chinese: '我喝了咖啡。',
          spanish: 'Tomé café.',
        ),
        RolePlayOption(
          english: 'I like spring.',
          tagalog: 'Gusto ko ang tagsibol.',
          vietnamese: 'Tôi thích mùa xuân.',
          chinese: '我喜欢春天。',
          spanish: 'Me gusta la primavera.',
        ),
      ],
    ),
    RolePlayScenario(
      title: 'Fatigue',
      level: 2,
      scenarioKorean: '다니엘은 피곤하고 기운이 없습니다.',
      scenarioEnglish: 'Daniel feels tired and weak.',
      scenarioTagalog: 'Pagod at matamlay si Daniel.',
      scenarioVietnamese: 'Daniel cảm thấy mệt mỏi và yếu.',
      scenarioChinese: '丹尼尔感到疲惫和虚弱。',
      scenarioSpanish: 'Daniel está cansado y sin energía.',
      correctAnswer: RolePlayOption(
        english: 'I feel tired.',
        tagalog: 'Pagod ako.',
        vietnamese: 'Tôi cảm thấy mệt.',
        chinese: '我很累。',
        spanish: 'Estoy cansado.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I have a cat.',
          tagalog: 'May pusa ako.',
          vietnamese: 'Tôi có một con mèo.',
          chinese: '我有一只猫。',
          spanish: 'Tengo un gato.',
        ),
        RolePlayOption(
          english: 'I watched TV.',
          tagalog: 'Nanood ako ng TV.',
          vietnamese: 'Tôi đã xem TV.',
          chinese: '我看了电视。',
          spanish: 'Vi televisión.',
        ),
      ],
      doctorQuestionKorean: '수면은 잘 취하고 있나요?',
      doctorQuestionEnglish: 'Are you sleeping well?',
      correctFollowUp: RolePlayOption(
        english: 'No, I sleep late.',
        tagalog: 'Hindi, late na ako natutulog.',
        vietnamese: 'Không, tôi ngủ muộn.',
        chinese: '不，我很晚睡。',
        spanish: 'No, duermo tarde.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'I bought candy.',
          tagalog: 'Bumili ako ng kendi.',
          vietnamese: 'Tôi đã mua kẹo.',
          chinese: '我买了糖。',
          spanish: 'Compré dulces.',
        ),
        RolePlayOption(
          english: 'My hands are cold.',
          tagalog: 'Malamig ang mga kamay ko.',
          vietnamese: 'Tay tôi lạnh.',
          chinese: '我手很冷。',
          spanish: 'Mis manos están frías.',
        ),
      ],
    ),
    // Level 3 — Advanced situations (emotional/trauma)
    RolePlayScenario(
      title: 'Sadness / Emotional Health',
      level: 3,
      scenarioKorean: '윤호는 감정적으로 매우 슬퍼 보입니다.',
      scenarioEnglish: 'Yoonho looks very sad emotionally.',
      scenarioTagalog: 'Mukhang malungkot si Yoonho.',
      scenarioVietnamese: 'Yoonho trông rất buồn.',
      scenarioChinese: '允浩看起来很伤心。',
      scenarioSpanish: 'Yoonho parece muy triste.',
      correctAnswer: RolePlayOption(
        english: 'I feel sad.',
        tagalog: 'Malungkot ako.',
        vietnamese: 'Tôi buồn.',
        chinese: '我很难过。',
        spanish: 'Estoy triste.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I play video games.',
          tagalog: 'Naglalaro ako ng video game.',
          vietnamese: 'Tôi chơi trò chơi điện tử.',
          chinese: '我玩电子游戏。',
          spanish: 'Juego videojuegos.',
        ),
        RolePlayOption(
          english: 'I like blue.',
          tagalog: 'Gusto ko ang kulay asul.',
          vietnamese: 'Tôi thích màu xanh.',
          chinese: '我喜欢蓝色。',
          spanish: 'Me gusta el azul.',
        ),
      ],
      doctorQuestionKorean: '최근에 스트레스를 받는 일이 있었나요?',
      doctorQuestionEnglish: 'Have you been stressed recently?',
      correctFollowUp: RolePlayOption(
        english: 'Yes, at school.',
        tagalog: 'Oo, sa school.',
        vietnamese: 'Vâng, ở trường.',
        chinese: '是的，在学校。',
        spanish: 'Sí, en la escuela.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'My dog barks.',
          tagalog: 'Tumatahol ang aso ko.',
          vietnamese: 'Chó của tôi sủa.',
          chinese: '我家的狗在叫。',
          spanish: 'Mi perro ladra.',
        ),
        RolePlayOption(
          english: 'I ate cake.',
          tagalog: 'Kumain ako ng cake.',
          vietnamese: 'Tôi đã ăn bánh.',
          chinese: '我吃了蛋糕。',
          spanish: 'Comí pastel.',
        ),
      ],
    ),
    RolePlayScenario(
      title: 'Cut Finger',
      level: 3,
      scenarioKorean: '해리는 손가락을 베였습니다.',
      scenarioEnglish: 'Harry cut his finger.',
      scenarioTagalog: 'Naputol ni Harry ang kanyang daliri.',
      scenarioVietnamese: 'Harry bị đứt tay.',
      scenarioChinese: '哈利割伤了手指。',
      scenarioSpanish: 'Harry se cortó el dedo.',
      correctAnswer: RolePlayOption(
        english: 'I cut my finger.',
        tagalog: 'Naputol ko ang daliri ko.',
        vietnamese: 'Tôi bị đứt tay.',
        chinese: '我割伤了手指。',
        spanish: 'Me corté el dedo.',
      ),
      wrongAnswers: [
        RolePlayOption(
          english: 'I see a bird.',
          tagalog: 'Nakakita ako ng ibon.',
          vietnamese: 'Tôi thấy một con chim.',
          chinese: '我看到一只鸟。',
          spanish: 'Veo un pájaro.',
        ),
        RolePlayOption(
          english: 'I drank milk.',
          tagalog: 'Uminom ako ng gatas.',
          vietnamese: 'Tôi đã uống sữa.',
          chinese: '我喝了牛奶。',
          spanish: 'Bebí leche.',
        ),
      ],
      doctorQuestionKorean: '상처가 깊은가요?',
      doctorQuestionEnglish: 'Is the cut deep?',
      correctFollowUp: RolePlayOption(
        english: "Yes, it's bleeding.",
        tagalog: 'Oo, dumudugo ito.',
        vietnamese: 'Vâng, nó đang chảy máu.',
        chinese: '是的，它在流血。',
        spanish: 'Sí, está sangrando.',
      ),
      wrongFollowUps: [
        RolePlayOption(
          english: 'I love painting.',
          tagalog: 'Mahilig ako sa pagpipinta.',
          vietnamese: 'Tôi thích vẽ tranh.',
          chinese: '我喜欢画画。',
          spanish: 'Me encanta pintar.',
        ),
        RolePlayOption(
          english: 'The sun is hot.',
          tagalog: 'Mainit ang araw.',
          vietnamese: 'Trời nắng.',
          chinese: '太阳很晒。',
          spanish: 'Hace sol.',
        ),
      ],
    ),
  ];

  // ─── Aggregate access ───

  static List<VocabEntry> get allEntries => [
    ..._bodyParts,
    ..._illnesses,
    ..._hygiene,
    ..._nutrition,
    ..._emotions,
    ..._doctorInstructions,
  ];

  /// Get entries filtered by category (null = all) and max level (1 or 2).
  static List<VocabEntry> getEntries({
    String? category,
    int maxLevel = 2,
  }) {
    List<VocabEntry> entries = allEntries;

    if (category != null && category != 'ALL') {
      entries = entries.where((e) => e.category == category).toList();
    }

    entries = entries.where((e) => e.level <= maxLevel).toList();

    return entries;
  }

  /// Get entries that have a translation for the given language code.
  static List<VocabEntry> getEntriesForLanguage({
    required String languageCode,
    String? category,
    int maxLevel = 2,
  }) {
    return getEntries(category: category, maxLevel: maxLevel)
        .where((e) => e.getTranslation(languageCode) != null)
        .toList();
  }

  /// Total number of entries available.
  static int get totalEntries => allEntries.length;

  /// Categories with their entry counts.
  static Map<String, int> get categoryCounts {
    Map<String, int> counts = {};
    for (var entry in allEntries) {
      counts[entry.category] = (counts[entry.category] ?? 0) + 1;
    }
    return counts;
  }
}
