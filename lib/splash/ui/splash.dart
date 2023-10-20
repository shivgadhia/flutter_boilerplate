import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/navigation/navigation.dart';
import '../../common/navigation/screen.dart';
import '../../common/ui/widgets/error.dart';
import '../../common/ui/widgets/loading.dart';
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
  late Future<SplashState> _uiState;

  @override
  void initState() {
    SplashViewModel vm = SplashViewModel();
    _uiState = vm.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _uiState,
        builder: (context, AsyncSnapshot<SplashState> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Loading(),
            );
          } else if (snapshot.hasData) {
            return _buildContent(snapshot.data!);
          }

          return const Scaffold(
            body: ErrorOccurred(),
          );
        });
  }

  Widget _buildContent(SplashState splashState) {
    Future.microtask(() {
      switch (splashState.runtimeType) {
        case LoggedIn:
          {
            widget._navigation.navigateTo(context, Screen.home);
          }
          break;
        case NotLoggedIn:
          {
            //TODO: widget._navigation.navigateTo(context, Screen.login);
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
