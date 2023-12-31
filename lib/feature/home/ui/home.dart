import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/navigation/screen.dart';
import 'package:flutter_boilerplate/core/navigation/screen_arguments.dart';
import 'package:flutter_boilerplate/core/ui/base_viewmodel_scaffold.dart';
import 'package:flutter_boilerplate/feature/home/data/repository/real_home_content_repository.dart';
import 'package:flutter_boilerplate/feature/home/domain/model/content.dart';
import 'package:flutter_boilerplate/feature/home/ui/home_viewmodel.dart';

import '../data/datasource/local_json_file_content_datasource.dart';
import 'content_rail_view.dart';

class Home extends StatefulWidget {
  final Navigation _navigation;

  const Home({Key? key, required Navigation navigation})
      : _navigation = navigation,
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    HomeViewModel vm = HomeViewModel(
        repo: RealHomeContentRepository(
            dataSource: LocalJsonFileContentDataSource()));
    return BaseViewModelScaffold.defaultScaffold(
      createViewModel: (_) => vm,
      contentView: (context, viewState) => _buildContent(viewState),
    );
  }

  Widget _buildContent(HomeUiState uiState) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uiState.screenTitle),
      ),
      body: ListView.builder(
        itemCount: uiState.content.length,
        itemBuilder: (content, index) {
          return _buildListItem(uiState.content[index]);
        },
      ),
    );
  }

  Widget _buildListItem(Content item) {
    if (item is ContentRailSection) {
      return _buildHorizontalRail(item);
    } else {
      return const Text("Unknown Item");
    }
  }

  Widget _buildHorizontalRail(ContentRailSection item) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: ContentRailView(
          uiModel: item,
          onRailItemClick: (item) async {
            switch (item.runtimeType) {
              case ContentCard:
                _navigateToDetails((item as ContentCard).id);
            }
          }),
    );
  }

  void _navigateToDetails(String id) {
    widget._navigation.navigateTo(context, Screen.details,
        args: ScreenArguments({ScreenArguments.keyContentId: id}));
  }
}
