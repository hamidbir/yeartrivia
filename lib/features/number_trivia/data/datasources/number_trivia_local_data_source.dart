import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Get the cached [NumberTriviaModel] which was gottn the last time
  /// the user had an internet connection
  ///
  /// throws  [CachedException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel cachedNumber);
}
