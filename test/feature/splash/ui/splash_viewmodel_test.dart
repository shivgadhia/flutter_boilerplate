import 'package:flutter_boilerplate/feature/splash/ui/splash_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SplashViewModel _sut;

  setUp(() {
    _sut = SplashViewModel();
  });

  test('startLoading SHOULD return LoggedIn state', () async {
    await _sut.startLoading();
    expect(await _sut.viewState, LoggedIn());
  });
}
