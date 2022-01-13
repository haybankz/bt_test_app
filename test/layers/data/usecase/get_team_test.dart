//@dart = 2.9
import 'dart:convert';

import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:bt_test_app/features/top_team/domain/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/reader.dart';

class TeamRepositoryMock extends Mock implements TeamRepository {}

final testTeam = TeamDto.fromJson(jsonDecode(reader("team.json")));
const teamId = 99;

void main() {
  GetTeamUseCase getTeam;
  TeamRepositoryMock teamRepositoryMock;

  setUp(() {
    teamRepositoryMock = TeamRepositoryMock();
    getTeam = GetTeamUseCase(teamRepositoryMock);
  });

  test(
    'it should gets team with a given id',
    () async {
      // arrange
      when(teamRepositoryMock.getTeam(teamId)).thenAnswer(
          (realInvocation) async =>
              Future.value(NetworkResponse<TeamDto>.success(testTeam)));

      // act
      final result = await getTeam.call(teamId);

      // assert
      expect(result.data, testTeam);
      verify(teamRepositoryMock.getTeam(teamId));
      verifyNoMoreInteractions(teamRepositoryMock);
    },
  );
}
