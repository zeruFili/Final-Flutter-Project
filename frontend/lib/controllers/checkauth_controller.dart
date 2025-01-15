import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_endpoints.dart';

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

// Check authentication function
Future<bool> checkAuth() async {
  final String? token = await getToken();

  if (token == null) {
    print('No token found. User is not authenticated.');
    return false;
  }

  final response = await http.get(
    Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.checkAuth}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    print('User authenticated: ${response.body}');
    return true;
  } else {
    print('Failed to authenticate: ${response.body} $token');
    return false;
  }
}
