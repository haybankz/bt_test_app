import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:http/http.dart' as http;

abstract class MatchRemoteDataSource {
  /// Fetches matches played in a competition
  /// accepts [competitionId] id of the competition
  /// returns [MatchesDto]
  Future<MatchesDto> fetchMatches(int competitionId);
}

class MatchRemoteDataSourceImpl implements MatchRemoteDataSource {
  final http.Client client;

  MatchRemoteDataSourceImpl({required this.client});

  @override
  Future<MatchesDto> fetchMatches(int competitionId) {
    final matchesUrl = Uri(
      scheme: "http",
      host: Constants.kBaseUrl,
      pathSegments: ["v2", "competitions", "$competitionId", "matches"],
    );

    log("matchesUrl: ${matchesUrl.toString()}");

    return client.get(
      matchesUrl,
      headers: {'X-Auth-Token': Constants.token},
    ).then((response) {
      if (response.statusCode == HttpStatus.ok) {
        return MatchesDto.fromJson(jsonDecode(response.body));
      }

      throw ServerException("Error occurred: ${response.reasonPhrase}!");
    }).catchError((e) => throw ServerException(Constants.connectionError));
  }
}
