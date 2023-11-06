import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class BaseViewModel<T extends ViewState> extends ChangeNotifier {
  late Future<T> _viewState;

  BaseViewModel() {
    _init();
  }

  Future<T> startLoading();

  void _init() async {
    _viewState = startLoading();
  }

  void setState(T state) async {
    _viewState = Future.value(state);
    notifyListeners();
  }

  Future<T> get viewState => _viewState;
}

abstract class ViewState {}
