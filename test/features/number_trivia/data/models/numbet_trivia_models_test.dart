import 'dart:convert';

import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entites/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  NumberTriviaModel tNumber = const NumberTriviaModel(text: "test", number: 1);
  test('should be numbertrivia models is a numbers ', () {
    expect(tNumber, isA<NumberTrivia>());
  });

  group('From json', () {
    test('should be convert json to number trivia model when number is integer',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, tNumber);
    });
    test('should be convert json to number trivia model when number is integer',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert

      expect(result, isA<NumberTrivia>());
    });
  });
  group('To Map', () {
    test('should be convert Number trivia model to json model', () {
      //act
      final result = tNumber.toJson();
      // assert
      final expectedMap = {
        "text": "test",
        "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}
