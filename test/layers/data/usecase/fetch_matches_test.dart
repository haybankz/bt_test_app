//@dart = 2.9
import 'dart:convert';

import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:bt_test_app/features/top_team/domain/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/reader.dart';

class MatchRepositoryMock extends Mock implements MatchRepository {}

final testMatches = MatchesDto.fromJson(jsonDecode(reader("matches.json")));

void main() {
  FetchMatchesUseCase fetchMatches;
  MatchRepositoryMock matchRepositoryMock;

  setUp(() {
    matchRepositoryMock = MatchRepositoryMock();
    fetchMatches = FetchMatchesUseCase(matchRepositoryMock);
  });

  test(
    'it should fetch matches for a given competition',
    () async {
      // arrange
      when(matchRepositoryMock.fetchMatches(Constants.competitionId))
          .thenAnswer((realInvocation) async =>
              Future.value(NetworkResponse<MatchesDto>.success(testMatches)));

      // act
      final result = await fetchMatches.call(Constants.competitionId);

      // assert
      expect(result.data, testMatches);
      verify(matchRepositoryMock.fetchMatches(Constants.competitionId));
      verifyNoMoreInteractions(matchRepositoryMock);
    },
  );
}
