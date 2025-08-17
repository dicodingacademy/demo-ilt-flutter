// todo-exception: to handle the exception, we can create
// a class that implement a [Exception]. We can store
// a message or stacktrace when the error is happened.
class AppException implements Exception {
  final String message;

  const AppException(this.message);
}
