import '../model/content.dart';

abstract class HomeContentRepository {
  Future<List<Content>> getContent();
}
