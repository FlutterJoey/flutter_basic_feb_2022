void test() {
  _privateTest();
}

void _privateTest() {
  print('test');

  var instance = MyClass();

  instance.getName();

  instance.getName(name: 'Test');
}

class MyClass {
  String name = '';
  int age = 0;

  String getName({
    String name = 'some waarde',
  }) {
    return name;
  }

  void printA() {
    print('test A');
  }

  void printB() {
    print('test ${age}');
  }
}
