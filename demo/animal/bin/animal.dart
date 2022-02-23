void main(List<String> arguments) {
  var dog = Dog.stray(name: 'Binky');
  print(dog.getSound());
}

abstract class Animal {
  Animal() {
    print('animal is being constructed');
  }

  String getSound();
}

class Dog extends Animal {
  String name;
  List<String> owners;
  int value = 1;

  Dog({
    this.name = 'asd',
    required this.owners,
  })  : value = 2,
        super() {
    print('dog is being constructed');
  }

  Dog.stray({required this.name}) : owners = const [];

  factory Dog.nameless() {
    return Dog(owners: [], name: '');
  }

  static Dog nameles() {
    return Dog(owners: [], name: '');
  }

  @override
  String getSound() {
    return 'woof';
  }
}

class Cat extends Animal {
  @override
  String getSound() {
    return 'miauw';
  }
}
