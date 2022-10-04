import 'package:rick_and_morty/core/error/exeption.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/features/data/datasources/person_local_datasource.dart';
import 'package:rick_and_morty/features/data/datasources/person_remote_datasource.dart';
import 'package:rick_and_morty/features/data/models/person_model.dart';
import 'package:rick_and_morty/features/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDatasource remoteDatasource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDatasource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonModel>>> getAllPersons(int page) async =>
      await _getPersons(() => remoteDatasource.getAllPersons(page));

  @override
  Future<Either<Failure, List<PersonModel>>> searchPerson(String query) async =>
      await _getPersons(() => remoteDatasource.searchPerson(query));

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
