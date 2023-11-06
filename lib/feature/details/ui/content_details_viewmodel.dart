import 'dart:async';

import 'package:flutter_boilerplate/core/ui/base_viewmodel.dart';
import 'package:flutter_boilerplate/feature/details/domain/model/content_detail.dart';
import 'package:flutter_boilerplate/feature/details/domain/repository/content_details_repository.dart';

class ContentDetailsViewModel extends BaseViewModel<DetailsUiState> {
  final ContentDetailsRepository _repo;
  final String _id;

  ContentDetailsViewModel(
      {required ContentDetailsRepository repo, required String id})
      : _repo = repo,
        _id = id;

  @override
  Future<DetailsUiState> startLoading() async {
    return await _repo.getContentDetail(_id).then(
        (ContentDetail result) => InitialDetailsViewState(result.title,
            details: result.toDisplayValue(), ctaText: "Do something"),
        onError: (e) => ErrorViewState("Oops",
            errorMessage: "There was a problem loading content id: $_id"));
  }

  void doSomething() async {
    setState(LoadingViewState("..."));

    await Future.delayed(const Duration(seconds: 3));

    setState(SecondDetailsViewState("Yay",
        details: "You clicked the button... the view state changed."));
  }
}

abstract class DetailsUiState extends ViewState {
  final String screenTitle;

  DetailsUiState(this.screenTitle);
}

class InitialDetailsViewState extends DetailsUiState {
  final String details;
  final String ctaText;

  InitialDetailsViewState(String screenTitle,
      {required this.details, required this.ctaText})
      : super(screenTitle);
}

class SecondDetailsViewState extends DetailsUiState {
  final String details;

  SecondDetailsViewState(String screenTitle, {required this.details})
      : super(screenTitle);
}

class ErrorViewState extends DetailsUiState {
  final String errorMessage;

  ErrorViewState(String screenTitle, {required this.errorMessage})
      : super(screenTitle);
}

class LoadingViewState extends DetailsUiState {
  LoadingViewState(String screenTitle) : super(screenTitle);
}

extension _ContentDetailMapper on ContentDetail {
  String toDisplayValue() =>
      "$description\nisLocked: $locked\ncreatedAt: $createdAt";
}
