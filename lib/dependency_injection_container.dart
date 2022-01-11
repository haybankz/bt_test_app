import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:bt_test_app/features/top_team/domain/export.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

void init() {
  _registerCommons();
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
}

void _registerCommons() {
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => http.Client());
}

void _registerDataSources() {
  sl.registerLazySingleton<MatchRemoteDataSource>(
      () => MatchRemoteDataSourceImpl(client: sl<http.Client>()));
  sl.registerLazySingleton<TeamRemoteDataSource>(
      () => TeamRemoteDataSourceImpl(client: sl<http.Client>()));
}

void _registerRepositories() {
  sl.registerLazySingleton<MatchRepository>(() => MatchRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      matchRemoteDataSource: sl<MatchRemoteDataSource>()));

  sl.registerLazySingleton<TeamRepository>(() => TeamRepositoryImpl(
      networkInfo: sl(), teamRemoteDataSource: sl<TeamRemoteDataSource>()));
}

void _registerUseCases() {
  sl.registerLazySingleton(() => FetchMatchesUseCase(sl<MatchRepository>()));
  sl.registerLazySingleton(() => GetTeamUseCase(sl<TeamRepository>()));
}
