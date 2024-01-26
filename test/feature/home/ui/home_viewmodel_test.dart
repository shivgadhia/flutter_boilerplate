import 'package:flutter_boilerplate/feature/home/domain/model/content.dart';
import 'package:flutter_boilerplate/feature/home/domain/repository/home_content_repository.dart';
import 'package:flutter_boilerplate/feature/home/ui/home_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

class _MockHomeContentRepository implements HomeContentRepository {
  final List<Content> _content;

  _MockHomeContentRepository(this._content);

  @override
  Future<List<Content>> getContent() => Future.value(_content);
}

void main() {
  final Content expectedContent =
      Content.horizontalRail("id", "title", "subtitle", []);

  test('startLoading SHOULD return empty content WHEN repo returns empty',
      () async {
    var repo = _MockHomeContentRepository([expectedContent]);
    var sut = HomeViewModel(repo: repo);

    await sut.initialState();

    expect(
        sut.viewState,
        emits(HomeUiState(
            screenTitle: "Screen Title", content: [expectedContent])));
  });
}
