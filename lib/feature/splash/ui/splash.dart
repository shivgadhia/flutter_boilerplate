import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/navigation/screen.dart';
import 'package:flutter_boilerplate/core/ui/base_viewmodel_scaffold.dart';

import 'splash_viewmodel.dart';

class Splash extends StatefulWidget {
  final Navigation _navigation;

  const Splash({Key? key, required Navigation navigation})
      : _navigation = navigation,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return BaseViewModelScaffold.defaultScaffold(
        createViewModel: (_) => SplashViewModel(),
        contentView: (context, viewState) => _buildContent(viewState)
    );
  }

  Widget _buildContent(SplashState splashState) {
    Future.microtask(() {
      switch (splashState.runtimeType) {
        case LoggedIn:
          {
            widget._navigation
                .navigateTo(context, Screen.home, popCurrent: true);
          }
          break;
        case NotLoggedIn:
          {
            //TODO: widget._navigation.navigateTo(context, Screen.login, popCurrent: true);
          }
          break;
        default:
          {}
      }
    });

    return Scaffold(
      body: Row(),
    ); // Should not reach here!
  }
}
