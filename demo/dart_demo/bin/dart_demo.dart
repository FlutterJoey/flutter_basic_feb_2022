import '../src/test.dart';

export '../src/test.dart' hide test;

void main(List<String> arguments) {
  int age = 27;
  String message = 'Hi, How are you. I am $age years old.';

  String multiLine = '''
asdas
asdf
asdf
''';

  String otherMulti = 'a\n'
      r'b\n'
      'c\n'
      'd';
  bool isAlive = true;

  String? name;

  name ??= '';

  const list = <String, dynamic>{};

  Map<String, Map<String, dynamic>> myMap = {
    'a': {'b': 'value'},
  };

  print(myMap['a']?['b']);

  list[''] = isAlive;

  if (isAlive == true && age < 30) {}

  print(message);

  void Function(String?) myFunc = printString;

  test();

  var instance = MyClass()
    ..printB() // 0
    ..age = 27
    ..name = 'Joey'
    ..printB(); // 27


  instance
    ..printA()
    ..printB();
}

void printString(String? value) {
  print(value);
}
