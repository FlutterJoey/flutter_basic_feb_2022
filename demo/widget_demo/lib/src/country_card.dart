import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 400,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [
              Expanded(
                child: FlutterLogo(size: 40,),
              ),
              Expanded(
                child: Center(child: Text('Nederland')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
