import 'dart:convert';

import 'package:clean_code_architecture/core/error/exceptions.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

abstract class NumberTriviaLocalDataSource {
  /// Get the cached [NumberTriviaModel] which was gottn the last time
  /// the user had an internet connection
  ///
  /// throws  [CachedException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel cachedNumber);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel cachedNumber) {
    return sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, json.encode(cachedNumber.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CachingException();
    }
  }
}
