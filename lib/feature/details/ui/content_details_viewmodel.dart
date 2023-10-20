class ContentDetailsViewModel {
  ContentDetailsViewModel();

  //TODO: create repository and fetch details

  Future<DetailsUiState> getDetails(String id) async {
    return DetailsUiState(
        screenTitle: "Content $id",
        name: "$id name",
        details: "details about $id");
  }
}

class DetailsUiState {
  final String screenTitle;
  final String name;
  final String details;

  const DetailsUiState(
      {required this.screenTitle, required this.name, required this.details});
}
