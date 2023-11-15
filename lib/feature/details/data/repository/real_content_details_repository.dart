import 'package:flutter_boilerplate/feature/details/data/datasource/content_details_datasource.dart';
import 'package:flutter_boilerplate/feature/details/domain/model/content_detail.dart';
import 'package:flutter_boilerplate/feature/details/domain/repository/content_details_repository.dart';

class RealContentDetailsRepository extends ContentDetailsRepository {
  final ContentDetailsDataSource _dataSource;

  RealContentDetailsRepository({required ContentDetailsDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<ContentDetail> getContentDetail(String id) async {
    var data = await _dataSource.fetchContent();
    List allDetails = data["details"];

    Map<String?, Object?> thisItem = allDetails.firstWhere((element) {
      return element["id"] == id;
    }, orElse: () => <String, Object>{});

    if (thisItem.isEmpty) return Future.error(Exception("No details for $id"));

    return ContentDetail(
      thisItem["id"] as String,
      thisItem["title"] as String,
      thisItem["description"] as String,
      thisItem["background"] as String,
      thisItem["link"] as String,
      thisItem["locked"] as bool,
      BigInt.from(thisItem["created"] as int),
      BigInt.from(thisItem["edited"] as int),
    );
  }
}
