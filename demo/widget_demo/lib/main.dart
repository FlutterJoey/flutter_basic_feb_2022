import 'package:flutter/material.dart';
import 'package:widget_demo/src/country_card.dart';

void main() async {
  runApp(MyApp(
    color: Colors.blueGrey.shade200,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20,
        ),
        child: Container(
          color: widget.color,
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              if (isVisible) ...[
                const Center(
                  child: CountryCard(),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Text('Klik hier!'),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
