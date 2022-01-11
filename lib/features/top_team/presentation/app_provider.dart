import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:bt_test_app/features/top_team/domain/export.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  static const int DATE_RANGE = 30;

  final FetchMatchesUseCase _fetchMatchesUseCase;
  final GetTeamUseCase _getTeamUseCase;

  AppProvider(this._fetchMatchesUseCase, this._getTeamUseCase);

  List<Team> topTeams = [];

  NetworkResponse<MatchesDto> matchesResponse =
      NetworkResponse<MatchesDto>.success(null);

  NetworkResponse<TeamDto> teamResponse =
      NetworkResponse<TeamDto>.success(null);

  Future<void> loadTopTeams() async {
    await fetchMatches();

    if (matchesResponse.status == Status.error ||
        matchesResponse.data == null) {
      notifyListeners();
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

    topTeams = getTeamsWithMostWins(teamWinnings);
    notifyListeners();
  }

  Future<void> fetchMatches() async {
    matchesResponse =
        NetworkResponse<MatchesDto>.loading("Fetching matches from server");
    notifyListeners();

    matchesResponse = await _fetchMatchesUseCase.call(Constants.competitionId);
  }

  Future<void> fetchTeam(int teamId) async {
    teamResponse = NetworkResponse<TeamDto>.loading("Getting teams details");
    notifyListeners();

    teamResponse = await _getTeamUseCase.call(teamId);
    notifyListeners();
  }

  bool isCompetitionFinished(List<Match> matches) {
    //get list of unfinished matches
    var unFinishedMatches =
        matches.where((match) => match.status != MatchStatus.FINISHED).toList();

    //if unfinished matches is empty, competition is already finished else competition is still ongoing
    return unFinishedMatches.isEmpty;
  }

  List<Match> removeUnfinishedMatches(List<Match> matches) {
    matches.removeWhere((match) => match.status != MatchStatus.FINISHED);
    return matches;
  }

  Match getCompetitionLastPlayedMatch(List<Match> matches) {
    final sortedMatches = sortMatchesInAscendingOrder(matches);
    //return last played match
    return sortedMatches.last;
  }

  List<Match> sortMatchesInAscendingOrder(List<Match> matches) {
    //sort matches by date in ascending order i.e oldest date first
    matches.sort((Match match1, Match match2) =>
        match1.utcDate!.compareTo(match2.utcDate!));
    return matches;
  }

  DateTime subtractFromDate(DateTime date, {int noOfDays = DATE_RANGE}) {
    return date.subtract(Duration(days: noOfDays));
  }

  Map<Team, int> getTeamWinnings(List<Match> matches) {
    //map to hold team and the no. of wins
    Map<Team, int> teamWinMap = <Team, int>{};

    for (final match in matches) {
      //get the winning team
      final matchWinner = getMatchWinner(match);

      //if winning team is not null
      if (matchWinner != null) {
        // if the team already exist in the map, increment noOfWins else set 1 as no. of wins
        teamWinMap.update(matchWinner, (value) => value + 1, ifAbsent: () => 1);
      }
    }
    return teamWinMap;
  }

  Team? getMatchWinner(Match match) {
    switch (match.score!.winner) {
      case Winner.HOME_TEAM:
        return match.homeTeam;

      case Winner.AWAY_TEAM:
        return match.awayTeam;

      case Winner.DRAW:
      default:
        return null;
    }
  }

  List<Team> getTeamsWithMostWins(Map<Team, int> teamWins) {
    int highestWinIndicator = 0;
    List<Team> teams = [];

    teamWins.forEach((team, noOfWins) {
      //if the team no of wins is greater than the current highest win, clear the list and add the current team
      if (noOfWins > highestWinIndicator) {
        highestWinIndicator = noOfWins;
        teams.clear();
        teams.add(team);
        //if team's no of wins is equal to current highest win, add team to list
      } else if (noOfWins == highestWinIndicator) {
        teams.add(team);
      }
    });

    return teams;
  }
}
