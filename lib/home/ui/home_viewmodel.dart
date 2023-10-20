import '../domain/model/content.dart';
import '../domain/repository/content_repository.dart';

class HomeViewModel {
  final ContentRepository _repo;

  HomeViewModel({required ContentRepository repo}) : _repo = repo;

  Future<HomeUiState> getHomeContent() async {
    var homeContent = await _repo.getContent();
    return HomeUiState(content: homeContent, screenTitle: "Screen Title");
  }
}

class HomeUiState {
  final List<Content> content;
  final String screenTitle;

  const HomeUiState({required this.content, required this.screenTitle});
}
