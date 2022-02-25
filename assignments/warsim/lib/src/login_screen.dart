import 'package:flutter/material.dart';
import 'package:warsim/src/select_country.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? error;

  String username = '';
  String password = '';

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            if (error != null) ...[
              Text(error!),
            ],
            TextFormField(
              decoration: InputDecoration(
                label: Text('username'),
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'You need to enter a username';
                }
                return null;
              },
              onSaved: (String? value) {
                if (value != null) {
                  username = value;
                }
              },
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'You need to enter a password';
                }
                return null;
              },
              onSaved: (String? value) {
                if (value != null) {
                  password = value;
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                var form = _formKey.currentState;
                if (form != null && form.validate()) {
                  _formKey.currentState?.save();
                  if (username == 'test' && password == 'test') {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SelectCountryScreen(),
                      ),
                    );
                  } else {
                    setState(() {
                      error = 'Invalid username or password';
                    });
                  }
                }
              },
              child: Text('Login'),
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.abc_sharp))
          ],
        ),
      ),
    );
  }
}
