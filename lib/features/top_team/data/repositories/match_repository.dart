import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:bt_test_app/features/top_team/domain/export.dart';

abstract class MatchRepository {
  /// Fetches matches played in a competition [params.competitionId]
  /// and start date[params.dateFrom] and end date [params.dateTo]
  /// accepts [FetchMatchesParam] [params]
  /// returns [NetworkResponse] of [MatchesDto]
  Future<NetworkResponse<MatchesDto>> fetchMatches(FetchMatchesParam params);
}

class MatchRepositoryImpl implements MatchRepository {
  final NetworkInfo networkInfo;
  final MatchRemoteDataSource matchRemoteDataSource;

  MatchRepositoryImpl(
      {required this.networkInfo, required this.matchRemoteDataSource});

  @override
  Future<NetworkResponse<MatchesDto>> fetchMatches(
      FetchMatchesParam params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await matchRemoteDataSource.fetchMatches(params);
        return NetworkResponse<MatchesDto>.success(response);
      } catch (e) {
        return NetworkResponse<MatchesDto>.error(e.toString());
      }
    } else {
      return NetworkResponse<MatchesDto>.error(Constants.noInternet);
    }
  }
}
