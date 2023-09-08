class AppException implements Exception {
  String? _message;
  String? _prefix;
  AppException(this._message,this._prefix);
  @override
  String toString(){
    return '$_message$_prefix';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}
class BadRequestException extends AppException {
  BadRequestException([String? message])
      : super(message, 'Invalid request');
}
class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}
class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, 'Invalid Input');
}