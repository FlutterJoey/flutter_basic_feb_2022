import 'package:flutter/material.dart';
import 'package:warsim/src/backend/backend.dart';
import 'package:warsim/src/event_card.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({
    required this.invader,
    required this.defender,
    Key? key,
  }) : super(key: key);

  final Country invader;
  final Country defender;

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  late WarSimulator simulator;

  List<SimulatorEvent> events = [];

  @override
  void initState() {
    super.initState();
    simulator = WarSimulator(widget.invader, widget.defender);
    simulator.listen((event) {
      setState(() {
        events.add(event);
      });
    });
    simulator.start();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.invader.name,
                    style: textTheme.displayMedium,
                  ),
                  Text(
                    'VS',
                    style: textTheme.displaySmall,
                  ),
                  Text(
                    widget.defender.name,
                    style: textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blueGrey,
              child: ListView(
                children: List.generate(
                  events.length,
                  (int index) {
                    return EventCard(event: events.reversed.toList()[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
