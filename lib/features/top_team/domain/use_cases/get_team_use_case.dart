import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';

class GetTeamUseCase implements UseCase<TeamDto, int> {
  final TeamRepository _teamRepository;

  GetTeamUseCase(this._teamRepository);

  @override
  Future<NetworkResponse<TeamDto>> call(int teamId) {
    return _teamRepository.getTeam(teamId);
  }
}
