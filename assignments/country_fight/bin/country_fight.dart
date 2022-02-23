import 'dart:math';

void main(List<String> arguments) {
  // Create a small program in main() where 2 countries with each 2 troups fight each other.
  Country a = Country(
    name: 'russia',
    troups: [
      Troup(attack: 5, defense: 3, hp: 10, type: TroupType.army, accuracy: 100),
      Troup(
          attack: 8,
          defense: 6,
          hp: 20,
          type: TroupType.airforce,
          accuracy: 100),
    ],
  );
  Country b = Country(
    name: 'america',
    troups: [
      Troup(attack: 5, defense: 2, hp: 13, type: TroupType.navy, accuracy: 50),
      Troup(attack: 10, defense: 1, hp: 16, type: TroupType.army, accuracy: 70),
    ],
  );

  var troupA = a.getRandomTroup();
  var troupB = b.getRandomTroup();
  if (troupA != null && troupB != null) {
    troupA.fight(troupB);
  }
  print(a);
  print(b);
}

// Create a class for a country

class Country {
// Add a list of troups to a country;
  List<Troup> troups;
  final String name;

  Country({required this.troups, required this.name});

// Add the function getRandomTroup to country
  Troup? getRandomTroup() {
    var aliveTroups = troups.where((troup) => troup.isAlive());
    if (aliveTroups.isNotEmpty) {
      var troup = aliveTroups.toList()[Random().nextInt(aliveTroups.length)];
      return troup;
    }
    return null;
  }

  @override
  String toString() {
    return "Country: $name \n ${troups.toString()}";
  }
}

// Create a class for a Troup
class Troup {
  // Add the following properties to a troup:
  // - attack: immutable
  // - defense: immutable
  // - hp: mutable
  // - type: enum, immutable
  // - accuracy: immutable

  final int attack;
  final int defense;
  int hp;
  final int accuracy;
  final TroupType type;

  Troup({
    required this.attack,
    required this.defense,
    required this.hp,
    required this.type,
    required this.accuracy,
  });

  // Add the function isAlive to troup
  bool isAlive() {
    return hp > 0;
  }

  // Add the function fight to troup, taking another troup as named parameter
  void fight(Troup other) {
    if (other.defense < attack && Random().nextInt(100) < accuracy) {
      other.hp = other.hp - (attack - other.defense);
    }
  }

  @override
  String toString() {
    return '''
  - attack: $attack
  - defense: $defense
  - hp: $hp
  - type: ${type.toString()}
  - accuracy: $accuracy
''';
  }
}

enum TroupType { army, navy, airforce }

// Bonus: Add the function lost to country, checking if all troups are dead

// Bonus: Look up extensions, and add an extension to TroupType to compare the 2 and return a bonus