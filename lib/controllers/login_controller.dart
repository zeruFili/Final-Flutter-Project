import 'package:shared_preferences/shared_preferences.dart';
import '../apis/login_api.dart';

Future<bool> loginUser(String email, String password) async {
  final loginApi = LoginApis();

  // Prepare the data to be sent
  var data = {
    'email': email,
    'password': password,
  };

  try {
    // Call the login method from LoginApis
    final response = await loginApi.login(data);

    if (response.statusCode == 200) {
      // Login successful, handle the response
      print('User logged in: ${response.data}');

      // Parse the response to extract the token
      final String token = response.data['token'];

      // Store the token in SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('Token stored successfully: $token');

      return true; // Indicate success
    } else {
      // Handle error
      print('Failed to login: ${response.data}');
      return false; // Indicate failure
    }
  } catch (e) {
    // Handle exceptions
    print('Error during login: $e');
    return false; // Indicate failure
  }
}
