import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/common/navigation/navigation.dart';
import 'package:flutter_boilerplate/common/navigation/screen.dart';

import 'common/navigation/screen_arguments.dart';
import 'details/ui/content_details.dart';
import 'home/ui/home.dart';
import 'splash/ui/splash.dart';

// Named routes are no longer recommended. Use a router instead?
// https://docs.flutter.dev/ui/navigation
// https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade
class MainNavigator extends Navigation {
  @override
  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  navigateTo(BuildContext context, Screen screen, {ScreenArguments? args}) {
    Navigator.pushNamed(context, screen.route, arguments: args);
  }

  @override
  ScreenArguments getArgs(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments as ScreenArguments? ??
        ScreenArguments({});
  }
}

extension MainNavigatorRoutes on MainNavigator {
  Map<String, WidgetBuilder> routes() => {
        Screen.splash.route: (context) => Splash(navigation: this),
        Screen.home.route: (context) => Home(navigation: this),
        Screen.details.route: (context) => ContentDetails(navigation: this),
      };

  String initialRoute() => Screen.splash.route;
}
