import 'dart:async';

abstract class BaseViewModel<T extends ViewState, E extends ViewEvent> {
  final _stateController = StreamController<T>();
  final _eventsController = StreamController<E>.broadcast();

  Stream<T> get viewState => _stateController.stream;

  Stream<E> get viewEvents => _eventsController.stream;

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

  void sendViewEvent(E event) async {
    if (!_eventsController.isClosed) {
      _eventsController.add(event);
    }
  }

  void dispose() {
    viewEvents.listen((_) {}).cancel(); // Ensure proper unsubscription to avoid memory leaks
    _stateController.close();
    _eventsController.close();
  }
}

abstract class ViewState {}

abstract class ViewEvent {}
