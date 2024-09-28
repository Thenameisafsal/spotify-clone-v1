import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/auth/signup'),
      // convert to json so that the backend understands it
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          'name': name,
          'email': email,
          'password': password,
        },
      ),
    );
    print(response.body);
    print(response.statusCode);
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
  }
}
