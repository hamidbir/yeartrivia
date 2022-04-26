import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the https://numbersapi.com/{number} end points
  ///
  /// throws for [ServerException] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the https://numbersapi.com/{random} end points
  ///
  /// throws for [ServerException] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
