import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  final envFile = File('.env');
  if (!envFile.existsSync()) {
    print('Error: .env file not found');
    exit(1);
  }

  String? apiKey;
  for (final line in envFile.readAsLinesSync()) {
    if (line.startsWith('GEMINI_API_KEY=')) {
      apiKey = line.substring('GEMINI_API_KEY='.length).trim();
    }
  }

  if (apiKey == null || apiKey.isEmpty) {
    print('Error: GEMINI_API_KEY is empty in .env');
    exit(1);
  }

  final url = 'https://generativelanguage.googleapis.com/v1beta/models?key=$apiKey';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    print('Error ${response.statusCode}: ${response.body}');
    exit(1);
  }

  final data = jsonDecode(response.body);
  final models = data['models'] as List;

  print('Available Gemini models (${models.length}):\n');
  for (final model in models) {
    final name = model['name'];
    final displayName = model['displayName'] ?? '';
    final desc = model['description'] ?? '';
    print('  $name');
    print('    $displayName - $desc\n');
  }
}
