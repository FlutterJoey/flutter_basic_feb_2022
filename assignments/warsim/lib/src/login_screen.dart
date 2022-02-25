import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsim/src/select_country.dart';
import 'package:warsim/src/service/login_service.dart';

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
        title: const Text('login'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (error != null) ...[
                Text(error!),
              ],
              TextFormField(
                decoration: const InputDecoration(
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    var form = _formKey.currentState;
                    if (form != null && form.validate()) {
                      form.save();
                      if (await context
                          .read<LoginService>()
                          .login(username, password)) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SelectCountryScreen(),
                          ),
                        );
                      } else {
                        setState(() {
                          error = context.read<LoginService>().latestError;
                          if (error?.isEmpty ?? true) {
                            error = null;
                          }
                        });
                      }
                    }
                  },
                  child: Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
