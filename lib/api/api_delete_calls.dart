import 'dart:convert';

import 'package:http/http.dart' as http;

import '../sharePreference/sharePreference_getToken.dart';

class ApiDeleteCalls {
  ApiDeleteCalls();

  static deleteApiResponse(String apiUrl) async {
    final String? bearerToken = await getToken();
    print(apiUrl);
    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      print('Response data: ${response.body}');

      return response;

    } catch (e) {
      print('Request failed with error: $e');
    }
  }
}
