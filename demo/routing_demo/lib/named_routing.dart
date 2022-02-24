import 'dart:js';

import 'package:flutter/material.dart';
import 'package:routing_demo/main.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
        '/detail': (context) => DetailScreen(screenIndex: 0),
      },
      initialRoute: '/',
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: List.generate(
          10,
          (index) => ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pushNamed('/detail');
            },
            child: const Text('Next screen'),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    required this.screenIndex,
    Key? key,
  }) : super(key: key);

  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail $screenIndex'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop('Clicked screenIndex $screenIndex');
          },
          child: const Text('Pop'),
        ),
      ),
    );
  }
}
