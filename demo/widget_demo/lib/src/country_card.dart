import 'package:flutter/material.dart';
import 'package:widget_demo/src/backend_provider.dart';

class CountryCard extends StatefulWidget {
  const CountryCard({Key? key}) : super(key: key);

  @override
  State<CountryCard> createState() => CountryCardState();
}

class CountryCardState extends State<CountryCard> {
  bool _isSelected = false;

  void select() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    if (_isSelected) {
      color = Colors.red;
    } else {
      color = Colors.white;
    }
    return BackendProvider(
      backend: MyBackend(),
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              BackendProvider.of(context).test();
            },
            child: SizedBox(
              height: 200,
              width: 400,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: const [
                      Expanded(
                        child: FlutterLogo(
                          size: 40,
                        ),
                      ),
                      Expanded(
                        child: Center(child: Text('Nederland')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
