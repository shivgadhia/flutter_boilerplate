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
  @override
  Widget build(BuildContext context) {
    final args = widget._navigation.getArgs(context);
    var viewModel = ContentDetailsViewModel(
        id: args.get(ScreenArguments.keyContentId),
        repo: RealContentDetailsRepository(
            dataSource: LocalJsonFileContentDetailsDataSource()));
    return BaseViewModelScaffold.defaultScaffold(
      createViewModel: (_) => viewModel,
      contentView: (context, viewState) =>
          _buildContent(viewState, onButtonClick: () {
        viewModel.doSomething();
      }),
    );
  }

  Widget _buildContent(DetailsUiState uiState,
      {required Function() onButtonClick}) {
    return Scaffold(
      appBar: AppBar(title: Text(uiState.screenTitle)),
      body: _buildUiState(uiState, onButtonClick),
    );
  }

  Widget _buildUiState(DetailsUiState uiState, Function() onButtonClick) {
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
