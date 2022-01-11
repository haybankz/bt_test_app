import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';

abstract class MatchRepository {
  /// Fetches matches played in a competition
  /// accepts [competitionId] id of the competition
  /// returns [NetworkResponse] of [MatchesDto]
  Future<NetworkResponse<MatchesDto>> fetchMatches(int competitionId);
}

class MatchRepositoryImpl implements MatchRepository {
  final NetworkInfo networkInfo;
  final MatchRemoteDataSource matchRemoteDataSource;

  MatchRepositoryImpl(
      {required this.networkInfo, required this.matchRemoteDataSource});

  @override
  Future<NetworkResponse<MatchesDto>> fetchMatches(int competitionId) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await matchRemoteDataSource.fetchMatches(competitionId);
        return NetworkResponse<MatchesDto>.success(response);
      } catch (e) {
        return NetworkResponse<MatchesDto>.error(e.toString());
      }
    } else {
      return NetworkResponse<MatchesDto>.error(Constants.noInternet);
    }
  }
}
