sealed class UiState {}

class Loading extends UiState {}

class Success extends UiState {
  final String data;
  Success(this.data);
}

class Error extends UiState {
  final String message;
  Error(this.message);
}
