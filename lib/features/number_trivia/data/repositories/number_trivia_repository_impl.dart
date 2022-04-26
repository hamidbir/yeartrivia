import 'package:clean_code_architecture/core/platform/network_info.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_sources.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entites/number_trivia.dart';
import 'package:clean_code_architecture/core/error/failure.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NetworkInfo networkInfo;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;

  NumberTriviaRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
