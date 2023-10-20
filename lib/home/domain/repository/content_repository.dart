import '../model/content.dart';

abstract class ContentRepository {
  Future<List<Content>> getContent();
}
