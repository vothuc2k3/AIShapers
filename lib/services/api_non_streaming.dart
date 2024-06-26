import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiNonStreaming {
  final String apiKey;
  final String apiUrl;

  ApiNonStreaming({required this.apiKey, required this.apiUrl});

  Future<Map<String, dynamic>> sendMessage(String message, String conversationId) async {
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
        return data;
      } catch (e) {
        throw Exception('Failed to parse response from API: ${e.toString()}');
      }
    } else {
      throw Exception('Failed to get response from API: ${response.body}');
    }
  }
}
