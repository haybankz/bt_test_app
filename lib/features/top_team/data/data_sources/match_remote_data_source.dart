import 'dart:developer';
import 'dart:io';

import 'package:bt_test_app/commons/export.dart';
import 'package:bt_test_app/features/top_team/data/export.dart';
import 'package:bt_test_app/features/top_team/domain/export.dart';
import 'package:http/http.dart' as http;

abstract class MatchRemoteDataSource {
  /// Fetches matches played in a competition [params.competitionId]
  /// and start date[params.dateFrom] and end date [params.dateTo]
  /// accepts [FetchMatchesParam] [params]
  /// returns [MatchesDto]
  Future<MatchesDto> fetchMatches(FetchMatchesParam params);
}

class MatchRemoteDataSourceImpl implements MatchRemoteDataSource {
  final http.Client client;

  MatchRemoteDataSourceImpl({required this.client});

  @override
  Future<MatchesDto> fetchMatches(FetchMatchesParam params) {
    final matchesUrl = Uri(host: Constants.kBaseUrl, pathSegments: [
      "competitions",
      "${params.competitionId}",
      "matches"
    ], queryParameters: {
      "dateFrom": params.dateFrom,
      "dateTo": params.dateTo
    });

    log("matchesUrl: ${matchesUrl.toString()}");

    return client.get(
      matchesUrl,
      headers: {'X-Auth-Token': Constants.token},
    ).then((response) {
      if (response.statusCode == HttpStatus.ok) {
        return matchesDtoFromJson(response.body);
      }

      throw ServerException("Error occurred: ${response.reasonPhrase}!");
    }).catchError((e) => throw ServerException(Constants.connectionError));
  }
}
