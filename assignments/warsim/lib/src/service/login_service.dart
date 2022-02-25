import 'dart:convert';

import 'package:http/http.dart';

class LoginService {
  String latestError = '';

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
        print(json['token']);
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
}
