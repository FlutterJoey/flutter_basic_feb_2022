import 'dart:math';

import 'package:flutter/material.dart';
import 'package:warsim/src/counting.dart';
import 'package:warsim/src/simulation_screen.dart';

import 'backend/backend.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SimulationScreen(
      //   defender: createCountry('Nederland'),
      //   invader: createCountry('Duitsland'),
      // ),
      home: Counter(),
    );
  }

  Country createCountry(String name) {
    var country = Country(name);

    var rand = Random();

    List.generate(
      2,
      (index) => Troup(
        type: TroupType.values[rand.nextInt(3)],
        power: rand.nextInt(10) + 5,
        hp: rand.nextInt(100) + 30,
        accuracy: rand.nextInt(60) + 40,
        name: 'Troup $index',
      ),
    ).forEach(country.addTroup);
    return country;
  }
}
