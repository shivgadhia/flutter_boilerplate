import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/navigation/navigation.dart';
import 'package:flutter_boilerplate/details/ui/content_details_viewmodel.dart';

import '../../common/navigation/screen_arguments.dart';
import '../../common/ui/widgets/error.dart';
import '../../common/ui/widgets/loading.dart';

class ContentDetails extends StatefulWidget {
  final Navigation _navigation;

  const ContentDetails({Key? key, required Navigation navigation})
      : _navigation = navigation,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  late Future<DetailsUiState> _uiState;

  // initialising in didChangeDependencies instead of initState,
  // so that we can reference Navigation from Widget.
  @override
  void didChangeDependencies() {
    final args = widget._navigation.getArgs(context);
    ContentDetailsViewModel vm = ContentDetailsViewModel();
    _uiState = vm.getDetails(args.get(ScreenArguments.keyContentId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _uiState,
        builder: (context, AsyncSnapshot snapshot) {
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

  Widget _buildContent(DetailsUiState uiState) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uiState.screenTitle),
      ),
      body: Center(
        child: Text(uiState.details),
      ),
    );
  }
}
