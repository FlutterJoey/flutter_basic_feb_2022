import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsim/src/login_screen.dart';
import 'package:warsim/src/select_country.dart';
import 'package:warsim/src/service/login_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      bool success = await context.read<LoginService>().doLoginCheck();

      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            if (success) {
              return const SelectCountryScreen();
            } else {
              return const LoginScreen();
            }
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
