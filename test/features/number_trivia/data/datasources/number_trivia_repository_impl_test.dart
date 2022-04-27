import 'package:clean_code_architecture/core/error/exceptions.dart';
import 'package:clean_code_architecture/core/error/failure.dart';
import 'package:clean_code_architecture/core/network/network_info.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_sources.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entites/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaLocalDataSource, NetworkInfo, NumberTriviaRemoteDataSource])
void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaLocalDataSource localDataSource;
  late MockNumberTriviaRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    localDataSource = MockNumberTriviaLocalDataSource();
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
        networkInfo: networkInfo);
  });
  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('get concreate Numbertrivia', () {
    final tNumber = 1;
    final tNumbertriviaModel = const NumberTriviaModel(text: 'test', number: 1);
    final NumberTrivia numberTrivia = tNumbertriviaModel;

    // test('should check is device is online', () async {
    //   //arrange
    //   when(networkInfo.isConnected).thenAnswer((_) async => true);

    //   //act

    //   repository.getConcreteNumberTrivia(tNumber);

    //   //assert
    //   verify(networkInfo.isConnected);
    // });

    runTestOnline(() {
      test(
          'shoould retrun remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(remoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumbertriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(numberTrivia)));
      });
      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        //arrange
        when(remoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumbertriviaModel);
        //act
        await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(localDataSource.cacheNumberTrivia(tNumbertriviaModel));
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
      });
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(remoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenThrow(ServerException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        //arrange
        when(localDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumbertriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Right(numberTrivia)));
      });
      test('should return cache failure when there is no cached data present',
          () async {
        //arrange
        when(localDataSource.getLastNumberTrivia())
            .thenThrow(CachingException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(localDataSource.getLastNumberTrivia());
        verifyZeroInteractions(remoteDataSource);
        expect(result, Left(CachingFailure()));
      });
    });
  });
  group('get random Numbertrivia', () {
    final tNumbertriviaModel = const NumberTriviaModel(text: 'test', number: 1);
    final NumberTrivia numberTrivia = tNumbertriviaModel;

    // test('should check is device is online', () async {
    //   //arrange
    //   when(networkInfo.isConnected).thenAnswer((_) async => true);

    //   //act

    //   repository.getRandomNumberTrivia();

    //   //assert
    //   verify(networkInfo.isConnected);
    // });

    runTestOnline(() {
      test(
          'shoould retrun remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(remoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumbertriviaModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(remoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Right(numberTrivia)));
      });
      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        //arrange
        when(remoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumbertriviaModel);
        //act
        await repository.getRandomNumberTrivia();
        //assert
        verify(localDataSource.cacheNumberTrivia(tNumbertriviaModel));
        verify(remoteDataSource.getRandomNumberTrivia());
      });
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(remoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(remoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        //arrange
        when(localDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumbertriviaModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Right(numberTrivia)));
      });
      test('should return cache failure when there is no cached data present',
          () async {
        //arrange
        when(localDataSource.getLastNumberTrivia())
            .thenThrow(CachingException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(localDataSource.getLastNumberTrivia());
        verifyZeroInteractions(remoteDataSource);
        expect(result, Left(CachingFailure()));
      });
    });
  });
}
