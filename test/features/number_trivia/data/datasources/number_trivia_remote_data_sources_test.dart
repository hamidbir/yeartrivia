import 'dart:convert';

import 'package:clean_code_architecture/core/error/exceptions.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_sources.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_sources_test.mocks.dart';

const https = http.Client;
@GenerateMocks([https])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(mockClient);
  });
  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response("Something went worng", 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumbertriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia')));
    test('''should perform a GET request on a URL with number
       being the endpoint and with application/json header''', () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      dataSourceImpl.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockClient.get(
        Uri.parse('http://numbersapi.com/$tNumber'),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });
    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumbertriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSourceImpl.getConcreteNumberTrivia;
        // assert
        expect(
            () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSourceImpl.getRandomNumberTrivia();
        // assert
        verify(mockClient.get(
          Uri.parse(
            'http://numbersapi.com/random',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSourceImpl.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSourceImpl.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
