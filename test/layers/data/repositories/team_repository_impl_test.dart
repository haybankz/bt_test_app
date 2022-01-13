//@dart = 2.9

import 'dart:convert';

import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/data_sources/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/reader.dart';

class NetworkInfoMock extends Mock implements NetworkInfo {}

class TeamRemoteDatasourceMock extends Mock implements TeamRemoteDataSource {}

TeamRepository teamRepository;
NetworkInfoMock networkInfoMock;
TeamRemoteDatasourceMock teamRemoteDatasource;

final testTeam = TeamDto.fromJson(jsonDecode(reader("team.json")));
const int teamId = 99;

void main() {
  setUp(() {
    networkInfoMock = NetworkInfoMock();
    teamRemoteDatasource = TeamRemoteDatasourceMock();

    teamRepository = TeamRepositoryImpl(
      networkInfo: networkInfoMock,
      teamRemoteDataSource: teamRemoteDatasource,
    );
  });

  runOnlineScenarioTests();
}

void runOnlineScenarioTests() {
  group('Given an Online Device', () {
    setUp(() {
      // networkInfoMock!.isConnected.then((value) => print);
      when(networkInfoMock.isConnected()).thenAnswer((_) async => true);
    });

    group('Team repository tests', () {
      test(
        'It should check that device is connected to the internet',
        () async {
          // act
          await teamRepository.getTeam(teamId);

          // assert
          assert(await networkInfoMock.isConnected(), true);
        },
      );

      test(
        'It should get team with an id from the network',
        () async {
          // arrange
          when(teamRemoteDatasource.getTeam(teamId))
              .thenAnswer((_) async => testTeam);

          // act
          final result = await teamRepository.getTeam(teamId);

          // assert
          expect(result, NetworkResponse<TeamDto>.success(testTeam));
          verify(teamRemoteDatasource.getTeam(teamId));
        },
      );
    });
  });
}
