sealed class ReviewResultState {}

class ReviewNoneState extends ReviewResultState {}

class ReviewLoadingState extends ReviewResultState {}

class ReviewErrorState extends ReviewResultState {}

class ReviewLoadedState extends ReviewResultState {}
