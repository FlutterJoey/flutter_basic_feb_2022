import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('boven'),
                  Expanded(child: Text('Onder'),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
