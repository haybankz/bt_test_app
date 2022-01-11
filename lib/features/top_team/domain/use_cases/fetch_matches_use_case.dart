import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';

class FetchMatchesUseCase implements UseCase<MatchesDto, int> {
  final MatchRepository _matchRepository;

  FetchMatchesUseCase(this._matchRepository);

  @override
  Future<NetworkResponse<MatchesDto>> call(int competitionId) {
    return _matchRepository.fetchMatches(competitionId);
  }
}

class FetchMatchesParam {
  int competitionId;
  String dateFrom;
  String dateTo;

  FetchMatchesParam(
      {required this.competitionId,
      required this.dateFrom,
      required this.dateTo});
}
