import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warsim/src/service/login_service.dart';

void main() {
  group('LoginService', () {
    late LoginService sut;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({});
      sut = LoginService();
    });

    group('logout', () {
      test('should remove internal token', () async {
        sut.token = '....';
        await sut.logout();

        expect(sut.token, equals(''));
      });
    });
  });
}
