import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  String latestError = '';
  String token = '';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<bool> login(String username, String password) async {
    var client = Client();
    try {
      var response = await client.post(
        Uri.parse('http://127.0.0.1:8081/login'),
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        _saveToken(json['token']);
        return true;
      } else {
        latestError = response.body;
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  static const tokenKey = 'token';

  Future<bool> doLoginCheck() async {
    var prefs = await _prefs;
    var token = prefs.getString(tokenKey);
    if (token != null) {
      this.token = token;
      return true;
    } else {
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    var prefs = await _prefs;
    this.token = token;
    prefs.setString(tokenKey, token);
  }

  Future<void> logout() async {
    token = '';
    var prefs = await _prefs;
    prefs.remove(tokenKey);
  }
}
