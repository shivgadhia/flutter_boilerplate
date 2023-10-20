import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/core/navigation/screen_arguments.dart';

import 'screen.dart';

abstract class Navigation {
  navigateTo(BuildContext context, Screen screen, {ScreenArguments? args, bool popCurrent});

  goBack(BuildContext context);

  ScreenArguments getArgs(BuildContext context);
}
