import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:korea_food/config.dart';

class AuthService {
  Future login(String username, String password) async {
    try {
      final url = Uri.http(Url, "/api/users/login");
      final response = await http.post(
        url,
        body: json.encode({
          'username': username,
          'password': password,
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {}
      return responseJson;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
  
}
