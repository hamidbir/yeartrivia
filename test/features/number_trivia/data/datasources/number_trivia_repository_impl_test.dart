import 'package:clean_code_architecture/core/platform/network_info.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_sources.dart';
import 'package:clean_code_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

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
}
