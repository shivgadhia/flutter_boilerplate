import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/common/navigation/screen_arguments.dart';

import 'screen.dart';

abstract class Navigation {
  navigateTo(BuildContext context, Screen screen, {ScreenArguments? args});

  goBack(BuildContext context);

  ScreenArguments getArgs(BuildContext context);
}
