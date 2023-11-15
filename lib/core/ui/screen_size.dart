import 'package:flutter/widgets.dart';

enum ScreenSize { small, normal, large, extraLarge }

extension ScreenSizes on BuildContext {
  ScreenSize getScreenSize() {
    double deviceWidth = MediaQuery.of(this).size.shortestSide;
    if (deviceWidth > 900) return ScreenSize.extraLarge;
    if (deviceWidth > 600) return ScreenSize.large;
    if (deviceWidth > 300) return ScreenSize.normal;
    return ScreenSize.small;
  }
}
