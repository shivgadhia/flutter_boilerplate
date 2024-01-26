import 'dart:async';

abstract class BaseViewModel<T extends ViewState> {
  final _stateController = StreamController<T>();

  Stream<T> get viewState => _stateController.stream;

  T? currentState;

  BaseViewModel() {
    _init();
  }

  Future<T> initialState();

  void _init() async {
    T state = await initialState();
    _stateController.add(state);
    currentState = state;
  }

  void setState(T state) async {
    if (!_stateController.isClosed) {
      _stateController.add(state);
      currentState = state;
    }
  }

  void dispose() {
    _stateController.close();
  }
}

abstract class ViewState {}
