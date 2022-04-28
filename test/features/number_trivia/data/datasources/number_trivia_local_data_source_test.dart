import 'dart:convert';

import 'package:clean_code_architecture/core/error/exceptions.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';
import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockShared;
  late NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSourceImpl;

  setUp(() {
    mockShared = MockSharedPreferences();
    numberTriviaLocalDataSourceImpl =
        NumberTriviaLocalDataSourceImpl(mockShared);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached')));
    test(
        'should number trivia from sharedpreferences when there is one in the cache',
        () async {
      //arrange
      when(mockShared.getString(CACHED_NUMBER_TRIVIA))
          .thenReturn(fixture('trivia_cached'));
      //act
      final result =
          await numberTriviaLocalDataSourceImpl.getLastNumberTrivia();
      //assert
      verify(mockShared.getString(CACHED_NUMBER_TRIVIA));

      expect(result, equals(tNumberTriviaModel));
    });
    test('should throw a CacheExpection when there is not a cached value  ',
        () async {
      //arrange
      when(mockShared.getString(CACHED_NUMBER_TRIVIA)).thenReturn(null);
      //act
      final call = numberTriviaLocalDataSourceImpl.getLastNumberTrivia;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CachingException>()));
    });
  });
  //TODO:
  // group('cacheNumbertrivia', () {
  //   const tNumberTriviaModel =
  //       NumberTriviaModel(text: 'test trivia', number: 1);
  //   test('should call sharedperfernces to cache data', () async {
  //     //act
  //     await numberTriviaLocalDataSourceImpl
  //         .cacheNumberTrivia(tNumberTriviaModel);
  //     //assert
  //     final expectedJson = json.encode(tNumberTriviaModel.toJson());
  //     verify(mockShared.setString(CACHED_NUMBER_TRIVIA, expectedJson));
  //   });
  // });
}
