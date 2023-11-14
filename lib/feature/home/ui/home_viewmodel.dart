import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/core/ui/base_viewmodel.dart';

import '../domain/model/content.dart';
import '../domain/repository/home_content_repository.dart';

class HomeViewModel extends BaseViewModel<HomeUiState> {
  final HomeContentRepository _repo;

  HomeViewModel({required HomeContentRepository repo}) : _repo = repo;

  @override
  Future<HomeUiState> startLoading() async {
    return await _repo.getContent().then(
        (value) => HomeUiState(content: value, screenTitle: "Screen Title"),
        onError: (e) => HomeUiState(content: [], screenTitle: "Oops"));
  }
}

class HomeUiState extends ViewState with EquatableMixin {
  final List<Content> content;
  final String screenTitle;

  HomeUiState({required this.content, required this.screenTitle});

  @override
  List<Object?> get props => [content, screenTitle];
}
