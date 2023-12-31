

import 'package:flutter_boilerplate/feature/home/data/datasource/content_datasource.dart';
import 'package:flutter_boilerplate/feature/home/domain/model/content.dart';
import 'package:flutter_boilerplate/feature/home/domain/repository/home_content_repository.dart';

class RealHomeContentRepository extends HomeContentRepository {
  final ContentDataSource _contentDataSource;
  Map? _data;

  RealHomeContentRepository({required ContentDataSource dataSource})
      : _contentDataSource = dataSource;

  // This creates a simple caching layer
  Future<Map> _fetchData() async =>
      _data ??= (await _contentDataSource.fetchContent());

  @override
  Future<List<Content>> getContent() async {
    List<Content> homeContent = [];

    var sections = (await _fetchData())["sections"];

    for (var section in sections) {
      switch (section["type"]) {
        case "content-rail":
          {
            homeContent.add(await _getContentRail(section["id"]));
            break;
          }
      }
    }

    return homeContent;
  }

  Future<List<RailItem>> _getAllContentCards() async {
    List<RailItem> result = [];

    var itemCards = (await _fetchData())["item-cards"];

    for (var item in itemCards) {
      result.add(RailItem.contentCard(
        item["id"],
        item["title"],
        item["description"],
        item["background"],
        item["link"],
      ));
    }
    return result;
  }

  Future<Content> _getContentRail(String id) async {
    List<RailItem> itemCards = await _getAllContentCards();
    List allRails = (await _fetchData())["content-rails"];

    var rail = allRails.firstWhere((element) => element["id"] == id);
    List<RailItem> railItems = itemCards
        .where((i) => (i is ContentCard && rail["itemIds"].contains(i.id)))
        .toList();

    return Content.horizontalRail(
        rail["id"], rail["title"] ?? "", rail["subtitle"] ?? "", railItems);
  }
}
