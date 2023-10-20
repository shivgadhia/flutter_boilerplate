import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/navigation/screen.dart';
import 'package:flutter_boilerplate/home/data/repository/real_content_repository.dart';
import 'package:flutter_boilerplate/home/domain/model/content.dart';
import 'package:flutter_boilerplate/home/ui/home_viewmodel.dart';

import '../../common/navigation/navigation.dart';
import '../../common/navigation/screen_arguments.dart';
import '../../common/ui/widgets/error.dart';
import '../../common/ui/widgets/loading.dart';
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
  late Future<HomeUiState> _uiState;

  @override
  void initState() {
    HomeViewModel vm = HomeViewModel(
        repo: RealHomeContentRepository(
            dataSource: LocalJsonFileContentDataSource()));
    _uiState = vm.getHomeContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _uiState,
        builder: (context, AsyncSnapshot<HomeUiState> snapshot) {
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
