import 'package:flutter/material.dart';

class InheritedProvider extends InheritedWidget {
  const InheritedProvider({
    required Widget child,
    required _BackendProviderState state,
    Key? key,
  })  : _state = state,
        super(
          child: child,
          key: key,
        );

  final _BackendProviderState _state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class BackendProvider extends StatefulWidget {
  const BackendProvider({required this.backend, required this.child, Key? key})
      : super(key: key);

  final MyBackend backend;
  final Widget child;

  static MyBackend of(BuildContext context) {
    var backend = context
        .dependOnInheritedWidgetOfExactType<InheritedProvider>()
        ?._state
        .backend;
    return backend!;
    if (backend != null) {
      return backend;
    }
    throw FlutterError(
      'Can\'t find widget of type BackendProvider because no '
      'BackendProvider was found in the context',
    );
  }

  @override
  _BackendProviderState createState() => _BackendProviderState();
}

class _BackendProviderState extends State<BackendProvider> {
  MyBackend get backend => widget.backend;

  @override
  Widget build(BuildContext context) {
    return InheritedProvider(
      child: widget.child,
      state: this,
    );
  }
}

class MyBackend {
  void test() {
    print('test');
  }
}
