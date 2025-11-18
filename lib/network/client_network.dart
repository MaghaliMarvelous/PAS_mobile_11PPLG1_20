import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientNetwork {
  static const String baseUrl = "https://mediadwi.com/api/latihan";

  static Future<Map<String, dynamic>> registerUser({
    required String username,
    required String password,
    required String fullName,
    required String email,
  }) async {
    final url = Uri.parse("$baseUrl/register-user");

    final response = await http.post(
      url,
      body: {
        "username": username,
        "password": password,
        "full_name": fullName,
        "email": email,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to register: ${response.statusCode}");
    }
  }
}
