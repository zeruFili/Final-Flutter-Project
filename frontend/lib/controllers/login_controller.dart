import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_endpoints.dart';
import 'dart:convert';

Future<void> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.loginEmail}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Login successful, handle the response
    print('User logged in: ${response.body}');

    // Parse the response to extract the token
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String token = responseData['token'];

    // Store the token in SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    print('Token stored successfully: $token');
  } else {
    // Handle error
    print('Failed to login: ${response.body}');
  }
}
