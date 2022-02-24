import 'dart:async';
import 'dart:math';

class Country {
  final String name;
  final List<Troup> troups = [];

  Country(this.name);

  void addTroup(Troup troup) {
    troup._country = name;
    troups.add(troup);
  }

  bool isAlive() {
    return troups.any((element) => element.hp > 0);
  }

  Troup getRandomTroup() {
    var alive = troups.where((element) => element.hp > 0);
    return troups.toList()[Random().nextInt(alive.length)];
  }
}

enum TroupType {
  navy,
  army,
  airforce,
}

extension on TroupType {
  int getPowerBonus(TroupType other) {
    if (other == this) {
      return 0;
    } else if (other == TroupType.airforce && this == TroupType.navy ||
        other == TroupType.navy && this == TroupType.army ||
        other == TroupType.army && this == TroupType.navy) {
      return 2;
    }
    return -1;
  }
}

class Troup {
  final int power;
  int hp;
  final int accuracy;
  final TroupType type;
  final String name;

  late final String _country;

  String get country => _country;

  Troup({
    required this.type,
    required this.power,
    required this.hp,
    required this.accuracy,
    this.name = 'Trouper',
  });
}

class WarSimulator {
  Country a;
  Country b;
  double speed;

  void Function(SimulatorEvent event)? eventListener;

  WarSimulator(this.a, this.b, {this.speed = 1.0});

  Timer? timer;

  bool _isRunning = false;

  int _hour = 0;

  bool get isRunning => _isRunning;

  void start() {
    timer =
        Timer.periodic(Duration(milliseconds: 500 ~/ speed), (_) => _tick());
    _isRunning = true;
  }

  void retreat(Country country) {
    timer?.cancel();

    late Country winner;
    late Country loser;
    if (country == a) {
      winner = b;
      loser = a;
    } else {
      winner = a;
      loser = b;
    }
    eventListener?.call(SimulatorEvent(winner, null, _hour, EventType.win, 0));
    eventListener?.call(SimulatorEvent(loser, null, _hour, EventType.lose, 0));
  }

  void pause() {
    timer?.cancel();
    _isRunning = false;
  }

  void unpause() {
    start();
    _isRunning = true;
  }

  void listen(void Function(SimulatorEvent) onEvent) {
    eventListener = onEvent;
  }

  void _tick() {
    _hour++;
    if (a.isAlive() && b.isAlive()) {
      var troupA = a.getRandomTroup();
      var troupB = b.getRandomTroup();
      if (Random().nextBool()) {
        executeAttack(troupB, troupA, b, a);
      } else {
        executeAttack(troupA, troupB, a, b);
      }
    } else if (!a.isAlive()) {
      eventListener?.call(SimulatorEvent(b, null, _hour, EventType.win, 0));
      eventListener?.call(SimulatorEvent(a, null, _hour, EventType.lose, 0));
      pause();
    } else {
      eventListener?.call(SimulatorEvent(a, null, _hour, EventType.win, 0));
      eventListener?.call(SimulatorEvent(b, null, _hour, EventType.lose, 0));
      pause();
    }
  }

  void executeAttack(
    Troup defender,
    Troup attacker,
    Country defendingCountry,
    Country attackingCountry,
  ) {
    if (Random().nextInt(100) < attacker.accuracy) {
      eventListener?.call(
        SimulatorEvent(attackingCountry, attacker, _hour, EventType.attack,
            attacker.power),
      );
      var damage = attacker.power + attacker.type.getPowerBonus(defender.type);
      defender.hp -= damage;
      if (defender.hp <= 0) {
        eventListener?.call(
          SimulatorEvent(
              defendingCountry, defender, _hour, EventType.kill, damage),
        );
      } else {
        eventListener?.call(SimulatorEvent(
            defendingCountry, defender, _hour, EventType.hurt, damage));
      }
    } else {
      eventListener?.call(
        SimulatorEvent(attackingCountry, attacker, _hour, EventType.miss, 0),
      );
    }
  }
}

class SimulatorEvent {
  final Country country;
  final Troup? troup;
  final int hour;
  final int? damage;
  final EventType type;

  SimulatorEvent(this.country, this.troup, this.hour, this.type, this.damage);
}

enum EventType {
  win,
  lose,
  attack,
  kill,
  hurt,
  miss,
}
