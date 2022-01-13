import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:bt_test_app/features/top_team/domain/export.dart';
import 'package:bt_test_app/features/top_team/presentation/match_helper.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier with MatchHelper {
  final FetchMatchesUseCase _fetchMatchesUseCase;
  final GetTeamUseCase _getTeamUseCase;

  AppProvider(this._fetchMatchesUseCase, this._getTeamUseCase);

  NetworkResponse<MatchesDto> matchesResponse =
      NetworkResponse<MatchesDto>.success(null);

  NetworkResponse<TeamDto> teamResponse =
      NetworkResponse<TeamDto>.success(null);

  Future<void> loadTopTeam() async {
    await fetchMatches();

    if (matchesResponse.status == Status.error ||
        matchesResponse.data == null) {
      return;
    }
    var matches = matchesResponse.data!.matches ?? <Match>[];

    final isCompetitionCompleted = isCompetitionFinished(matches);
    var dateTo = DateTime.now();
    var dateFrom = DateTime.now();

    if (!isCompetitionCompleted) {
      matches = removeUnfinishedMatches(matches);
    } else {
      final match = getCompetitionLastPlayedMatch(matches);
      dateTo = match.utcDate!;
    }

    dateFrom = subtractFromDate(dateTo);
    matches = matches
        .where((match) =>
            match.utcDate!.isAfter(dateFrom) ||
            match.utcDate!.isBefore(DateTime.now()))
        .toList();

    final Map<Team, int> teamWinnings = getTeamWinnings(matches);

    final topTeam = getTeamWithMostWins(teamWinnings);
    if (topTeam == null) {
      return;
    }
    getTeamDetails(topTeam.id!);
  }

  Future<void> fetchMatches() async {
    matchesResponse =
        NetworkResponse<MatchesDto>.loading("Fetching matches from server");
    notifyListeners();

    matchesResponse = await _fetchMatchesUseCase.call(Constants.competitionId);
    notifyListeners();
  }

  Future<void> getTeamDetails(int teamId) async {
    teamResponse = NetworkResponse<TeamDto>.loading("Getting teams details");
    notifyListeners();

    teamResponse = await _getTeamUseCase.call(teamId);
    notifyListeners();
  }
}
