import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main(List<String> arguments) async {
  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(login);

  var shelf = await shelf_io.serve(handler, '127.0.0.1', 8081);

  shelf.autoCompress = true;

  print('Server started on http://127.0.0.1:8081');
}

Future<Response> login(Request request) async {
  if (request.method == 'POST' && request.url.path == '/login') {
    var body = await request.readAsString();
    try {
      var json = jsonDecode(body);
      String username = json['username'];
      String password = json['password'];

      if (username == 'test' && password == 'test') {
        return Response.ok({
          'token': 'some token you can save',
        });
      } else {
        return Response.forbidden('Invalid username or password');
      }
    } catch (e) {
      print(e);
      return Response(HttpStatus.badRequest, body: 'bad request');
    }
  } else {
    return Response.notFound('this method is not found');
  }
}
