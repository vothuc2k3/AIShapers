import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiStreaming {
  final String apiKey;
  final String apiUrl;

  ApiStreaming({required this.apiKey, required this.apiUrl});

  Stream<Map<String, dynamic>> sendMessage(
    String message,
    String conversationId,
  ) async* {
    final request = http.Request('POST', Uri.parse(apiUrl))
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..headers['Content-Type'] = 'application/json'
      ..headers['Accept'] = '*/*'
      ..headers['Host'] = 'api.coze.com'
      ..headers['Connection'] = 'keep-alive'
      ..body = jsonEncode({
        'conversation_id': conversationId,
        'bot_id': '7383620054593863687',
        'user': '123333333',
        'query': message,
        'stream': true,
      });

    final response = await request.send();

    if (response.statusCode == 200) {
      // Sử dụng một StringBuffer để lưu trữ các phần dữ liệu JSON
      StringBuffer buffer = StringBuffer();

      await for (String data in response.stream.transform(utf8.decoder)) {
        // In ra dữ liệu nhận được để kiểm tra
        print('Received data: $data');
        buffer.write(data);

        // Cố gắng phân tích cú pháp JSON từ buffer
        try {
          // Tách buffer thành các đối tượng JSON riêng lẻ
          String completeData = buffer.toString().trim();

          // Tìm tất cả các đối tượng JSON hoàn chỉnh trong buffer
          int startIndex = completeData.indexOf('{');
          int endIndex = completeData.lastIndexOf('}');

          while (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
            String validJson = completeData.substring(startIndex, endIndex + 1);
            buffer = StringBuffer(completeData.substring(endIndex + 1));

            final jsonData = jsonDecode(validJson) as Map<String, dynamic>;
            print(jsonData);
            yield jsonData;

            completeData = buffer.toString().trim();
            startIndex = completeData.indexOf('{');
            endIndex = completeData.lastIndexOf('}');
          }
        } catch (e) {
          // In ra lỗi nếu có
          print('Failed to decode JSON: $e');
        }
      }
    } else {
      throw Exception(
          'Failed to get response from API: ${response.reasonPhrase}');
    }
  }
}
