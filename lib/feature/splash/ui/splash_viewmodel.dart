import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/core/ui/base_viewmodel.dart';

class SplashViewModel extends BaseViewModel<SplashState> {
  SplashViewModel();

  @override
  Future<SplashState> startLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    return LoggedIn();
  }
}

class SplashState extends ViewState with EquatableMixin {
  SplashState._();

  @override
  List<Object?> get props => [];
}

class LoggedIn extends SplashState {
  LoggedIn() : super._();
}

class NotLoggedIn extends SplashState {
  NotLoggedIn() : super._();
}
