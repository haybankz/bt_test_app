import 'dart:convert';

import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:bt_test_app/features/top_team/presentation/match_helper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_resources/reader.dart';

final testMatch = MatchesDto.fromJson(jsonDecode(reader("matches.json")));
void main() {
  MatchHelper helperClass = MatchHelper();
  group("Match helper tests", () {
    test('check if competition is completed', () {
      final isCompleted = helperClass.isCompetitionFinished(testMatch.matches!);

      expect(isCompleted, false);
    });

    test('check that unfinished matches are removed from list of matches', () {
      final finishedMatches =
          helperClass.removeUnfinishedMatches(testMatch.matches!);

      final unfinishedMatches = finishedMatches
          .where((match) => match.status != MatchStatus.FINISHED)
          .toList();

      expect(unfinishedMatches.isEmpty, true);
    });

    test('check that unfinished matches are removed from list of matches', () {
      final finishedMatches =
          helperClass.removeUnfinishedMatches(testMatch.matches!);

      final unfinishedMatches = finishedMatches
          .where((match) => match.status != MatchStatus.FINISHED)
          .toList();

      expect(unfinishedMatches.isEmpty, true);
    });

    test('check last played match in a competition', () {
      final match =
          helperClass.getCompetitionLastPlayedMatch(testMatch.matches!);

      expect(match, testMatch.matches!.last);
    });

    test('check that matches are sorted in ascending order by date', () {
      final matches =
          helperClass.sortMatchesInAscendingOrder(testMatch.matches!);

      expect(matches.first, testMatch.matches!.first);
    });

    test('check that no of days is subtracted from a given date', () {
      final date = DateTime.now();

      var resultDate = date.subtract(const Duration(days: 10));

      expect(helperClass.subtractFromDate(date, noOfDays: 10), resultDate);
    });

    test('check that a match has winner', () {
      final match = testMatch.matches!.first;

      expect(helperClass.getMatchWinner(match), match.homeTeam);
    });
  });
}
