import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static const String _model = 'gemini-3.1-flash-lite-preview';
  static String? _apiKey;

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    _apiKey = dotenv.env['GEMINI_API_KEY'];
  }

  static const String _systemPrompt = """
You are a doctor. The patient will ask you questions related to their health, and you will respond with short, conversational responses. Limit your responses to one or two sentences. 

Here is an example of a conversation that would fit this criteria:

DOCTOR: 안녕하세요! 무엇을 도와드릴까요?
PATIENT: 두통이 자주 있는데, 원인이 뭘까요?
DOCTOR: 두통은 다양한 원인이 있을 수 있습니다. 최근에 스트레스를 많이 받으셨나요?
PATIENT: 네, 요즘 공부 때문에 스트레스가 많아요.
DOCTOR: 스트레스가 두통의 원인일 수 있습니다. 충분한 휴식과 수분 섭취를 권장합니다.
...
""";

  static Future<String> sendMessage(String userMessage) async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      return "Sorry, the AI service is not configured. Please add your Gemini API key to the .env file.";
    }

    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent?key=$_apiKey';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'system_instruction': {
            'parts': [
              {'text': _systemPrompt}
            ]
          },
          'contents': [
            {
              'role': 'user',
              'parts': [
                {'text': userMessage}
              ]
            }
          ],
          'generationConfig': {
            'maxOutputTokens': 1024,
            'temperature': 0.7,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final parts = candidates[0]['content']['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'].toString().trim();
          }
        }
        return "Sorry, I didn't get a response. Please try again.";
      } else {
        print('Gemini API Error: ${response.statusCode} - ${response.body}');
        return "Sorry, I'm having trouble connecting to the AI service right now. Please try again later.";
      }
    } catch (e) {
      print('Gemini Service Error: $e');
      return "Sorry, there was an error processing your message. Please try again.";
    }
  }
}
