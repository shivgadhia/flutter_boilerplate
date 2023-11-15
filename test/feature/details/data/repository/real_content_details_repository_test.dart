import 'package:flutter_boilerplate/feature/details/data/datasource/content_details_datasource.dart';
import 'package:flutter_boilerplate/feature/details/data/repository/real_content_details_repository.dart';
import 'package:flutter_boilerplate/feature/details/domain/model/content_detail.dart';
import 'package:flutter_test/flutter_test.dart';

class _MockContentDetailsDataSource implements ContentDetailsDataSource {
  final Map<String, Object> _content;

  _MockContentDetailsDataSource(this._content);

  @override
  Future<Map> fetchContent() => Future.value(_content);
}

void main() {
  final Map<String, Object> _expectedContent = {
    "details": [
      {
        "id": "content-id",
        "title": "content-title",
        "description": "",
        "caption": "",
        "background": "",
        "link": "",
        "locked": false,
        "created": 0,
        "edited": 0
      }
    ]
  };
  test('getContentDetail SHOULD return details WHEN called with id', () async {
    var dataSource = _MockContentDetailsDataSource(_expectedContent);
    var sut = RealContentDetailsRepository(dataSource: dataSource);

    final result = await sut.getContentDetail("content-id");
    await expectLater(
        result,
        ContentDetail("content-id", "content-title", "", "", "", false,
            BigInt.zero, BigInt.zero));
  });

  test('getContentDetail SHOULD return error WHEN called with unknown id',
      () async {
    var dataSource = _MockContentDetailsDataSource(_expectedContent);
    var sut = RealContentDetailsRepository(dataSource: dataSource);

    final result = sut.getContentDetail("unknown id");
    await expectLater(result, throwsA(isException));
  });
}
