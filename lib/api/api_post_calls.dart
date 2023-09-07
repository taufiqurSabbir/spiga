
import 'dart:convert';

import '../sharePreference/sharePreference_getToken.dart';
import 'package:http/http.dart' as http;

class ApiPostCalls{
  ApiPostCalls();

  static postApiResponse(String apiUrl, var map) async {
    final String? bearerToken = await getToken();
    print(apiUrl);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(map)
      );

      print('Response data: ${response.body}');

      return response;

    } catch (e) {
      print('Request failed with error: $e');


    }
  }
}