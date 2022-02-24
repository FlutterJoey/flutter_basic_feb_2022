import 'package:flutter/material.dart';
import 'package:warsim/src/backend/backend.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.event,
    Key? key,
  }) : super(key: key);

  final SimulatorEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.redAccent.shade400,
            Colors.redAccent.shade700,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        '${event.troup?.name} from ${event.country.name} did ${event.type} at ${event.hour}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
