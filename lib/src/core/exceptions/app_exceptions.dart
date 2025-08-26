class AppException implements Exception {
  AppException({required this.message, this.data});
  final String message;
  final dynamic data;
}

class NotAuthenticatedException extends AppException {
  NotAuthenticatedException({required super.message});
}

class GetMovieGenresException extends AppException {
  GetMovieGenresException() : super(message: 'Failed to get movie genres.');
}
