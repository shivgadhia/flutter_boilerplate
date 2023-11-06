import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/base_viewmodel.dart';
import 'package:flutter_boilerplate/core/ui/widgets/error.dart';
import 'package:flutter_boilerplate/core/ui/widgets/loading.dart';
import 'package:provider/provider.dart';

class BaseViewModelScaffold<T extends BaseViewModel> extends StatelessWidget {
  final CreateViewModel _createViewModel;
  final ContentView _contentView;
  final LoadingView _loadingView;
  final ErrorView _errorView;

  const BaseViewModelScaffold(
      {Key? key,
      required CreateViewModel createViewModel,
      required ContentView contentView,
      required LoadingView loadingView,
      required ErrorView errorView})
      : _createViewModel = createViewModel,
        _contentView = contentView,
        _loadingView = loadingView,
        _errorView = errorView,
        super(key: key);

  factory BaseViewModelScaffold.defaultScaffold(
      {required CreateViewModel createViewModel, required ContentView contentView}) {
    return BaseViewModelScaffold(
        createViewModel: createViewModel,
        contentView: contentView,
        loadingView: (context) => const Scaffold(
              body: Loading(),
            ),
        errorView: (context) => const Scaffold(
              body: ErrorOccurred(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: _createViewModel,
      builder: (context, child) {
        var vm = context.watch<T>();
        return FutureBuilder(
            future: vm.viewState,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _loadingView(context);
              } else if (snapshot.hasData) {
                return _contentView(context, snapshot.data);
              }
              return _errorView(context);
            });
      },
    );
  }
}

typedef CreateViewModel<T extends BaseViewModel> = T Function(
    BuildContext context);

typedef ContentView<T extends Widget> = T Function(
    BuildContext context, dynamic viewState);

typedef LoadingView = Widget Function(BuildContext context);
typedef ErrorView = Widget Function(BuildContext context);
