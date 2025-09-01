import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioError(dynamic dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: 'Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive Timeout');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request Cancelled');
      case DioExceptionType.unknown:
        if (dioError.message.contains('SocketException')) {
          return ServerFailure(errorMessage: 'No Internet Connection');
        } else {
          return ServerFailure(
            errorMessage: 'Unexpected Error, Please try again!',
          );
        }
    }
    return ServerFailure(errorMessage: 'Unexpected Error, Please try again!');
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(
        errorMessage: 'Your request not found, Please try later!',
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        errorMessage: 'Internal Server Error, Please try later!',
      );
    } else {
      return ServerFailure(
        errorMessage: 'Oops, Something went wrong, Please try again!',
      );
    }
  }
}
