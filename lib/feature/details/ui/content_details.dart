import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/navigation/screen_arguments.dart';
import 'package:flutter_boilerplate/core/ui/base_viewmodel_scaffold.dart';
import 'package:flutter_boilerplate/core/ui/widgets/error.dart';
import 'package:flutter_boilerplate/core/ui/widgets/loading.dart';
import 'package:flutter_boilerplate/feature/details/data/datasource/local_json_file_content_details_datasource.dart';
import 'package:flutter_boilerplate/feature/details/data/repository/real_content_details_repository.dart';
import 'package:flutter_boilerplate/feature/details/ui/content_details_viewmodel.dart';

class ContentDetails extends StatefulWidget {
  final Navigation _navigation;

  const ContentDetails({Key? key, required Navigation navigation})
      : _navigation = navigation,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  late ContentDetailsViewModel _vm;

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = widget._navigation.getArgs(context);
    _vm = ContentDetailsViewModel(
        id: args.get(ScreenArguments.keyContentId),
        repo: RealContentDetailsRepository(
            dataSource: LocalJsonFileContentDetailsDataSource()));

    _vm.viewEvents.listen((event) {
      if (event is ShowSnackbarMessage) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message)));
      }
    });

    return BaseViewModelScaffold.defaultScaffold(
      createViewModel: (_) => _vm,
      contentView: (context, viewState) =>
          _buildContent(viewState, onButtonClick: () {
        _vm.doSomething();
      }, onButton2Click: () {
        _vm.doSomethingElse();
      }),
    );
  }

  Widget _buildContent(DetailsUiState uiState,
      {required Function() onButtonClick, required Function() onButton2Click}) {
    return Scaffold(
      appBar: AppBar(title: Text(uiState.screenTitle)),
      body: _buildUiState(uiState, onButtonClick, onButton2Click),
    );
  }

  Widget _buildUiState(DetailsUiState uiState, Function() onButtonClick,
      Function() onButton2Click) {
    switch (uiState.runtimeType) {
      case InitialDetailsViewState:
        {
          return Center(
            child: Column(
              children: [
                Text((uiState as InitialDetailsViewState).details),
                ElevatedButton(
                  child: Text(uiState.ctaText),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    elevation: 0,
                  ),
                  onPressed: onButtonClick,
                ),
                ElevatedButton(
                  child: Text(uiState.cta2Text),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    elevation: 0,
                  ),
                  onPressed: onButton2Click,
                ),
              ],
            ),
          );
        }
      case SecondDetailsViewState:
        {
          return Center(
            child: Column(
              children: [
                Text((uiState as SecondDetailsViewState).details),
              ],
            ),
          );
        }

      case ErrorViewState:
        {
          return const ErrorOccurred();
        }

      case LoadingViewState:
        {
          return const Loading();
        }
      default:
        return Row();
    }
  }
}
