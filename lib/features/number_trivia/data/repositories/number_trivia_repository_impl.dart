import 'package:clean_code_architecture/core/error/exceptions.dart';
import 'package:clean_code_architecture/core/network/network_info.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_sources.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entites/number_trivia.dart';
import 'package:clean_code_architecture/core/error/failure.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NetworkInfo networkInfo;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;

  NumberTriviaRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });

    // if (await networkInfo.isConnected) {
    //   try {
    //     final remoteTrivia =
    //         await remoteDataSource.getConcreteNumberTrivia(number);
    //     await localDataSource.cacheNumberTrivia(remoteTrivia);

    //     return Right(remoteTrivia);
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   try {
    //     final cacheTrivia = await localDataSource.getLastNumberTrivia();
    //     return Right(cacheTrivia);
    //   } on CachingException {
    //     return Left(CachingFailure());
    //   }
    // }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandomChooser) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandomChooser();
        await localDataSource.cacheNumberTrivia(remoteTrivia);

        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheTrivia = await localDataSource.getLastNumberTrivia();
        return Right(cacheTrivia);
      } on CachingException {
        return Left(CachingFailure());
      }
    }
  }
}
