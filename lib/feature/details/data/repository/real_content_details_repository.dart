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

    try {
      Map thisItem = allDetails.firstWhere((element) {
        return element["id"] == id;
      }, orElse: () => {});

      return ContentDetail(
        thisItem["id"],
        thisItem["title"],
        thisItem["description"],
        thisItem["background"],
        thisItem["link"],
        thisItem["locked"],
        BigInt.from(thisItem["created"]),
        BigInt.from(thisItem["edited"]),
      );
    } catch (e) {
      return Future.error(e);
    }
  }
}
