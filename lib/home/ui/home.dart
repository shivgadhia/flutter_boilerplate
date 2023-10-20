import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/home/data/repository/real_content_repository.dart';
import 'package:flutter_boilerplate/home/domain/model/content.dart';
import 'package:flutter_boilerplate/home/ui/home_viewmodel.dart';

import '../../common/widgets/error.dart';
import '../../common/widgets/loading.dart';
import '../data/datasource/local_json_file_content_datasource.dart';
import 'content_rail_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<HomeUiState> _uiState;

  @override
  void initState() {
    HomeViewModel vm = HomeViewModel(
        repo: RealContentRepository(
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
            return const Loading();
          } else if (snapshot.hasData) {
            return _buildContent(snapshot.data!);
          }

          return const ErrorOccurred();
        });

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("widget.title"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(),
      ),
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
            throw UnimplementedError();
          }),
    );
  }
}
