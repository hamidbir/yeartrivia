import 'package:clean_code_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  InputConverter();
  Either<Failure, int> stringToUnsignedInteger(String input) {
    try {
      final integer = int.parse(input);
      if (integer < 0) {
        throw const FormatException();
      } else {
        return Right(integer);
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
