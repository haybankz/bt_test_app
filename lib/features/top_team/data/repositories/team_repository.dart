import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/data_sources/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';

abstract class TeamRepository {
  /// Gets details of a team matches
  /// accepts [teamId] id of the team
  /// returns [NetworkResponse] of [TeamDto]
  Future<NetworkResponse<TeamDto>> getTeam(int teamId);
}

class TeamRepositoryImpl implements TeamRepository {
  final NetworkInfo networkInfo;
  final TeamRemoteDataSource teamRemoteDataSource;

  TeamRepositoryImpl(
      {required this.networkInfo, required this.teamRemoteDataSource});

  @override
  Future<NetworkResponse<TeamDto>> getTeam(int teamId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await teamRemoteDataSource.getTeam(teamId);
        return NetworkResponse<TeamDto>.success(response);
      } catch (e) {
        return NetworkResponse<TeamDto>.error(e.toString());
      }
    } else {
      return NetworkResponse<TeamDto>.error(Constants.noInternet);
    }
  }
}
