class Screen {
  String route;

  Screen({required this.route});

  static Screen splash = _SplashScreen();
  static Screen home = _HomeScreen();
  static Screen details = _ContentDetailsScreen();
}

class _SplashScreen extends Screen {
  _SplashScreen() : super(route: "/");
}

class _HomeScreen extends Screen {
  _HomeScreen() : super(route: "/home");
}

class _ContentDetailsScreen extends Screen {
  _ContentDetailsScreen() : super(route: "/content_details");
}
