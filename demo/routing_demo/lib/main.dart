import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
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
              var value = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailScreen(screenIndex: index),
                ),
              );

              print(value);
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
