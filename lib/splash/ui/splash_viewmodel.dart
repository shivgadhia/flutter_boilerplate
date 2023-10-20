class SplashViewModel {
  SplashViewModel();

  Future<SplashState> start() async {
    await Future.delayed(const Duration(seconds: 2));
    return LoggedIn();
  }
}

class SplashState {
  SplashState._();
}

class LoggedIn extends SplashState {
  LoggedIn() : super._();
}

class NotLoggedIn extends SplashState {
  NotLoggedIn() : super._();
}
