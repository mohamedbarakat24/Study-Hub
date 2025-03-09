import 'dart:convert';
import 'package:http/http.dart' as http;

class SummarizeService {
  // API
  static const String baseUrl = 'http://192.168.1.6:5000';
  static const String endpoint = '/text/summeariz';

  Future<SummarizeResponse> summarizeText(String text) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final request = SummarizeRequest(text: text);

    // Print the request URL and body
    print('Sending request to: $url');
    print('Request body: ${jsonEncode(request.toJson())}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    // Print the response status code and body
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the response body
      final responseBody = jsonDecode(response.body);
      return SummarizeResponse.fromJson(responseBody);
    } else {
      throw Exception('Failed to summarize text: ${response.statusCode}');
    }
  }
}

class SummarizeRequest {
  final String text;

  SummarizeRequest({required this.text});

  Map<String, dynamic> toJson() {
    return {'text': text};
  }
}

class SummarizeResponse {
  final String summary;

  SummarizeResponse({required this.summary});

  factory SummarizeResponse.fromJson(Map<String, dynamic> json) {
    return SummarizeResponse(summary: json['summary']);
  }
}
