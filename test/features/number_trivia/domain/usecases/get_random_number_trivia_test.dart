import 'package:clean_code_architecture/features/number_trivia/domain/entites/number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  late MockNumberTriviaRepository repository;
  late GetRandomNumberTrivia usecase;
  late NumberTrivia tNumberTrivia;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(repository);
    tNumberTrivia = const NumberTrivia(text: 'test', number: 1);
  });

  test('sholud get number trivia for respository', () async {
    //arrange
    when(repository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));

    //act
    final result = await usecase(NoParams());

    //assert
    expect(result, equals(Right(tNumberTrivia)));
    verify(repository.getRandomNumberTrivia());
    verifyNoMoreInteractions(repository);
  });
}
