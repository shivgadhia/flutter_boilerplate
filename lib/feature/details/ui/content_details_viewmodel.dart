import 'package:flutter_boilerplate/feature/details/domain/model/content_detail.dart';
import 'package:flutter_boilerplate/feature/details/domain/repository/content_details_repository.dart';

class ContentDetailsViewModel {
  final ContentDetailsRepository _repo;

  ContentDetailsViewModel({required ContentDetailsRepository repo})
      : _repo = repo;

  Future<DetailsUiState> getDetails(String id) async {
    return await _repo.getContentDetail(id).then((ContentDetail result) {
      return DetailsUiState(
          screenTitle: result.title, details: result.toDisplayValue());
    }, onError: (e) {
      return DetailsUiState(
          screenTitle: "Oops",
          details: "There was a problem loading content id: $id");
    });
  }
}

class DetailsUiState {
  final String screenTitle;
  final String details;

  const DetailsUiState({required this.screenTitle, required this.details});
}

extension _ContentDetailMapper on ContentDetail {
  String toDisplayValue() =>
      "$description\nisLocked: $locked\ncreatedAt: $createdAt";
}
