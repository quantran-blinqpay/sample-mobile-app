class ServiceException implements Exception {
  ServiceException({required this.message, this.data});
  final String message;
  final dynamic data;
}

class NotAuthenticatedException implements Exception {
  NotAuthenticatedException(this.message);
  final String? message;
}

class GetUserProfileException implements Exception {
  GetUserProfileException({this.message = 'Failed to get User profile.'});
  final String? message;
}
