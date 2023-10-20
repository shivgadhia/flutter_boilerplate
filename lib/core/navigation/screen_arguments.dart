class ScreenArguments {
  final Map arguments;

  ScreenArguments(this.arguments);

  static const String keyContentId = "content-id";

  T? get<T>(String key) => arguments[key];
}
