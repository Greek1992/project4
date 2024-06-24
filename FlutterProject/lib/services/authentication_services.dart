import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project4summamove/services/base_url.dart';

class AuthenticationServices {
  static String _bearerToken = '';
  static String _userId = '';

  static String getUserId(){
    return _userId;
  }

  static void setUserId(String userId){
    _userId = userId;
  }

  static String getBearerToken(){
    return _bearerToken;
  }

  static void setBearerToken(String bearerToken){
    _bearerToken = bearerToken;
  }

  // api/register/
  static Future<bool> register (String email, String password, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation' : password
      }),
    );

    return response.statusCode == 200;
  }

  // api/login/
  static Future<bool> login (String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password
      }),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      _bearerToken = result['access_token'];
    }

    return response.statusCode == 200;
  }

  // api/logout/
  static Future<bool> logout () async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Bearer $_bearerToken'
      },
    );
    return response.statusCode == 200;
  }

  // api/GetUserId/
  Future<String> userId () async {
    final response = await http.get(
      Uri.parse('$baseUrl/userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Bearer $_bearerToken'
      },
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      _userId = result.toString();
    }
    return _userId;
  }


}
