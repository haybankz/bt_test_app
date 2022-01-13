//@dart = 2.9

import 'dart:convert';

import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/data_sources/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/reader.dart';

class NetworkInfoMock extends Mock implements NetworkInfo {}

class MatchRemoteDatasourceMock extends Mock implements MatchRemoteDataSource {}

MatchRepository matchRepository;
NetworkInfoMock networkInfoMock;
MatchRemoteDatasourceMock matchRemoteDatasource;

final testMatches = MatchesDto.fromJson(jsonDecode(reader("matches.json")));

void main() {
  setUp(() {
    networkInfoMock = NetworkInfoMock();
    matchRemoteDatasource = MatchRemoteDatasourceMock();

    matchRepository = MatchRepositoryImpl(
      networkInfo: networkInfoMock,
      matchRemoteDataSource: matchRemoteDatasource,
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

    group('Match repository tests', () {
      test(
        'It should check that device is connected to the internet',
        () async {
          // act
          await matchRepository.fetchMatches(Constants.competitionId);

          // assert
          assert(await networkInfoMock.isConnected(), true);
        },
      );

      test(
        'It should fetch matches from the network',
        () async {
          // arrange
          when(matchRemoteDatasource.fetchMatches(Constants.competitionId))
              .thenAnswer((_) async => testMatches);

          // act
          final result =
              await matchRepository.fetchMatches(Constants.competitionId);

          // assert
          expect(result, NetworkResponse<MatchesDto>.success(testMatches));
          verify(matchRemoteDatasource.fetchMatches(Constants.competitionId));
        },
      );
    });
  });
}
