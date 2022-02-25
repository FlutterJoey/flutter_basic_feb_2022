import 'dart:math';

import 'package:flutter/material.dart';
import 'package:warsim/src/simulation_screen.dart';

import 'backend/backend.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  String? countryA;
  int aTroups = 0;

  String? countryB;
  int bTroups = 0;

  final PageController countryAController = PageController();
  final PageController countryBController = PageController();

  List<String> countryNames = [
    'Nederland',
    'Duitsland',
    'Belgie',
    'Verenigde Staten',
    'Rusland',
    'China',
  ];

  @override
  void dispose() {
    super.dispose();
    countryAController.dispose();
    countryBController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CountrySelector(
                countries: countryNames
                    .where((element) => element != countryB)
                    .toList(),
                onSelect: (selected) {
                  setState(() {
                    countryA = selected;
                  });
                },
                onSetTroups: (troups) {
                  setState(() {
                    aTroups = troups;
                  });
                },
                troups: aTroups,
                selected: countryA,
                pageController: countryAController,
              ),
            ),
            Expanded(
              flex: 4,
              child: CountrySelector(
                countries: countryNames
                    .where((element) => element != countryA)
                    .toList(),
                onSelect: (selected) {
                  setState(() {
                    countryB = selected;
                  });
                },
                onSetTroups: (troups) {
                  setState(() {
                    bTroups = troups;
                  });
                },
                troups: bTroups,
                selected: countryB,
                pageController: countryBController,
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  var invaderName = countryA;
                  var defenderName = countryB;
                  if (invaderName != null && defenderName != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SimulationScreen(
                          invader: createCountry(invaderName, aTroups),
                          defender: createCountry(defenderName, bTroups),
                        ),
                      ),
                    );
                  }
                },
                child: Text('Start'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Country createCountry(String name, int troupCount) {
    var country = Country(name);

    var rand = Random();

    List.generate(
      troupCount,
      (index) => Troup(
        type: TroupType.values[rand.nextInt(3)],
        power: rand.nextInt(10) + 5,
        hp: rand.nextInt(20) + 10,
        accuracy: 90,
        name: 'Troup $index',
      ),
    ).forEach(country.addTroup);
    return country;
  }
}

class CountrySelector extends StatelessWidget {
  const CountrySelector({
    required this.countries,
    required this.onSelect,
    required this.onSetTroups,
    required this.troups,
    required this.selected,
    required this.pageController,
    Key? key,
  }) : super(key: key);

  final List<String> countries;

  final void Function(String) onSelect;
  final void Function(int) onSetTroups;

  final String? selected;
  final int troups;

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            children: countries
                .map(
                  (country) => CountryPage(
                    onSelect: onSelect,
                    country: country,
                    selected: selected == country,
                  ),
                )
                .toList(),
          ),
        ),
        if (selected != null) ...[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(32),
            ),
          ),
        ] else
          ...[]
      ],
    );
  }
}

class CountryPage extends StatelessWidget {
  const CountryPage({
    required this.onSelect,
    required this.country,
    required this.selected,
    Key? key,
  }) : super(key: key);

  final void Function(String) onSelect;

  final String country;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            country,
            style: textTheme.displaySmall,
          ),
          if (!selected) ...[
            ElevatedButton(
              onPressed: () {
                onSelect.call(country);
              },
              child: Text('Select'),
            ),
          ],
        ],
      ),
    );
  }
}
