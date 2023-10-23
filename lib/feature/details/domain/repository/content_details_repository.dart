import 'package:flutter_boilerplate/feature/details/domain/model/content_detail.dart';

abstract class ContentDetailsRepository {
  Future<ContentDetail> getContentDetail(String id);
}
