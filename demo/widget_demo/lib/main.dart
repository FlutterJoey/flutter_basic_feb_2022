import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_demo/src/country_card.dart';

void main() async {
  runApp(const MyApp(
    color: Colors.blue,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    required this.color,
    Key? key,
  }) : super(key: key);

  final Color color;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isVisible = true;

  late Color stateColor;

  late GlobalKey<CountryCardState> cardKey;

  @override
  void initState() {
    super.initState();
    cardKey = GlobalKey();
    stateColor = widget.color;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20,
        ),
        child: Container(
          color: stateColor,
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              if (isVisible) ...[
                Center(
                  child: CountryCard(key: cardKey,),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
              ElevatedButton(
                onPressed: () {
                  cardKey.currentState?.select();
                },
                child: const Text('Klik hier!'),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
