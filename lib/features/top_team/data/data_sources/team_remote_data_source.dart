import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:http/http.dart' as http;

abstract class TeamRemoteDataSource {
  /// Gets details of a team
  /// accepts [teamId] id of the team
  /// returns [TeamDto] data transfer object containing details of a team
  Future<TeamDto> getTeam(int teamId);
}

class TeamRemoteDataSourceImpl implements TeamRemoteDataSource {
  final http.Client client;

  TeamRemoteDataSourceImpl({required this.client});

  @override
  Future<TeamDto> getTeam(int teamId) {
    final teamUrl = Uri(
        scheme: "http",
        host: Constants.kBaseUrl,
        pathSegments: ["v2", "teams", "$teamId"]);

    log("teamUrl: ${teamUrl.toString()}");

    return client.get(
      teamUrl,
      headers: {'X-Auth-Token': Constants.token},
    ).then((response) {
      if (response.statusCode == HttpStatus.ok) {
        return TeamDto.fromJson(jsonDecode(response.body));
      }

      throw ServerException("Error occurred: ${response.reasonPhrase}!");
    }).catchError((e) => throw ServerException(Constants.connectionError));
  }
}
