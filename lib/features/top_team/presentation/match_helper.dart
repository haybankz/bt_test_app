import 'package:bt_test_app/features/top_team/data/export.dart';

class MatchHelper {
  static const int DATE_RANGE = 30;

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

  Team? getTeamWithMostWins(Map<Team, int> teamWins) {
    int highestWinIndicator = 0;
    Team? topTeam;

    teamWins.forEach((team, noOfWins) {
      //if the team no of wins is greater than the current highest win, set team as top team
      if (noOfWins > highestWinIndicator) {
        highestWinIndicator = noOfWins;
        topTeam = team;
      }
    });

    return topTeam;
  }
}
