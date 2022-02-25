import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:warsim/src/login_screen.dart';
import 'package:warsim/src/select_country.dart';
import 'package:warsim/src/service/login_service.dart';
import 'package:warsim/src/splash.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginService>(
      create: (context) => LoginService(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
