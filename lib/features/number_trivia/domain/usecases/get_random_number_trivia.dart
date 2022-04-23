import 'package:clean_code_architecture/core/error/failure.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entites/number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
