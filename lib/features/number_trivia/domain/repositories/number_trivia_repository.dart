import 'package:clean_code_architecture/core/error/failure.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entites/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
