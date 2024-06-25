import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey;
  final String apiUrl;

  ChatService({required this.apiKey, required this.apiUrl});

  Future<String> sendMessage(String message, String conversationId) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Host': 'api.coze.com',
        'Connection': 'keep-alive', 
      },
      body: jsonEncode({
        'conversation_id': conversationId,
        'bot_id': '7383620054593863687',
        'user': '123333333', 
        'query': message,
        'stream': false,
      }),
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['messages'] != null && data['messages'].isNotEmpty) {
          final firstContent = data['messages'].first['content'];
          return _cleanContent(firstContent);
        } else {
          return 'No response from AI';
        }
      } catch (e) {
        throw Exception('Failed to parse response from API: ${e.toString()}');
      }
    } else {
      throw Exception('Failed to get response from API: ${response.body}');
    }
  }
  String _cleanContent(String content) {
    final decodedContent = jsonDecode(content);
    final innerContent = decodedContent['data'];
    final cleanedContent = jsonDecode(innerContent);
    final result = cleanedContent['chunks'].first['slice'];
    return _removeSpecialCharacters(result);
  }

  String _removeSpecialCharacters(String input) {
    return input.replaceAll(RegExp(r'\\n|\\\\'), '\n');
  }
}
