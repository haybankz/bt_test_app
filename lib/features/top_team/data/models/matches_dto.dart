// To parse this JSON data, do
//
//     final matchesDto = matchesDtoFromJson(jsonString);

import 'package:equatable/equatable.dart';

class MatchesDto extends Equatable {
  MatchesDto({
    this.count,
    this.filters,
    this.competition,
    this.matches,
  });

  int? count;
  Filters? filters;
  Competition? competition;
  List<Match>? matches;

  factory MatchesDto.fromJson(Map<String, dynamic> json) => MatchesDto(
        count: json["count"],
        filters: Filters.fromJson(json["filters"]),
        competition: Competition.fromJson(json["competition"]),
        matches:
            List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "filters": filters?.toJson(),
        "competition": competition?.toJson(),
        "matches": matches != null
            ? matches!.map((match) => match.toJson()).toList()
            : null,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [matches];
}

class Competition {
  Competition({
    this.id,
    this.area,
    this.name,
    this.code,
    this.plan,
    this.lastUpdated,
  });

  int? id;
  Area? area;
  String? name;
  String? code;
  String? plan;
  DateTime? lastUpdated;

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json["id"],
        area: Area.fromJson(json["area"]),
        name: json["name"],
        code: json["code"],
        plan: json["plan"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area?.toJson(),
        "name": name,
        "code": code,
        "plan": plan,
        "lastUpdated": lastUpdated?.toIso8601String(),
      };
}

class Area {
  Area({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Filters {
  Filters();

  factory Filters.fromJson(Map<String, dynamic> json) => Filters();

  Map<String, dynamic> toJson() => {};
}

class Match extends Equatable {
  Match({
    this.id,
    this.season,
    this.utcDate,
    this.status,
    this.matchday,
    this.stage,
    this.group,
    this.lastUpdated,
    this.score,
    this.homeTeam,
    this.awayTeam,
    this.referees,
  });

  int? id;
  Season? season;
  DateTime? utcDate;
  MatchStatus? status;
  int? matchday;
  Stage? stage;
  dynamic group;
  DateTime? lastUpdated;
  Score? score;
  Team? homeTeam;
  Team? awayTeam;
  List<Referee>? referees;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        season: Season.fromJson(json["season"]),
        utcDate: DateTime.parse(json["utcDate"]),
        status: statusValues.map[json["status"]],
        matchday: json["matchday"],
        stage: stageValues.map[json["stage"]],
        group: json["group"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
        score: Score.fromJson(json["score"]),
        homeTeam: Team.fromJson(json["homeTeam"]),
        awayTeam: Team.fromJson(json["awayTeam"]),
        referees: List<Referee>.from(
            json["referees"].map((x) => Referee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "season": season?.toJson(),
        "utcDate": utcDate?.toIso8601String(),
        "status": statusValues.reverse[status],
        "matchday": matchday,
        "stage": stageValues.reverse[stage],
        "group": group,
        "lastUpdated": lastUpdated?.toIso8601String(),
        "score": score?.toJson(),
        "homeTeam": homeTeam?.toJson(),
        "awayTeam": awayTeam?.toJson(),
        "referees":
            referees != null ? referees!.map((x) => x.toJson()).toList() : null,
      };

  @override
  List<Object?> get props => [id, matchday, utcDate];
}

class Team extends Equatable {
  Team({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}

class Referee {
  Referee({
    this.id,
    this.name,
    this.role,
    this.nationality,
  });

  int? id;
  String? name;
  Role? role;
  String? nationality;

  factory Referee.fromJson(Map<String, dynamic> json) => Referee(
        id: json["id"],
        name: json["name"],
        role: roleValues.map[json["role"]],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": roleValues.reverse[role],
        "nationality": nationality,
      };
}

enum Role {
  REFEREE,
  ASSISTANT_REFEREE_N1,
  ASSISTANT_REFEREE_N2,
  FOURTH_OFFICIAL,
  VIDEO_ASSISANT_REFEREE_N1,
  VIDEO_ASSISANT_REFEREE_N2
}

final roleValues = EnumValues({
  "ASSISTANT_REFEREE_N1": Role.ASSISTANT_REFEREE_N1,
  "ASSISTANT_REFEREE_N2": Role.ASSISTANT_REFEREE_N2,
  "FOURTH_OFFICIAL": Role.FOURTH_OFFICIAL,
  "REFEREE": Role.REFEREE,
  "VIDEO_ASSISANT_REFEREE_N1": Role.VIDEO_ASSISANT_REFEREE_N1,
  "VIDEO_ASSISANT_REFEREE_N2": Role.VIDEO_ASSISANT_REFEREE_N2
});

class Score {
  Score({
    this.winner,
    this.duration,
    this.fullTime,
    this.halfTime,
    this.extraTime,
    this.penalties,
  });

  Winner? winner;
  MatchDuration? duration;
  TimeScore? fullTime;
  TimeScore? halfTime;
  TimeScore? extraTime;
  TimeScore? penalties;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        winner:
            json["winner"] == null ? null : winnerValues.map[json["winner"]],
        duration: durationValues.map[json["duration"]],
        fullTime: TimeScore.fromJson(json["fullTime"]),
        halfTime: TimeScore.fromJson(json["halfTime"]),
        extraTime: TimeScore.fromJson(json["extraTime"]),
        penalties: TimeScore.fromJson(json["penalties"]),
      );

  Map<String, dynamic> toJson() => {
        "winner": winner == null ? null : winnerValues.reverse[winner],
        "duration": durationValues.reverse[duration],
        "fullTime": fullTime?.toJson(),
        "halfTime": halfTime?.toJson(),
        "extraTime": extraTime?.toJson(),
        "penalties": penalties?.toJson(),
      };
}

enum MatchDuration { REGULAR }

final durationValues = EnumValues({"REGULAR": MatchDuration.REGULAR});

class TimeScore {
  TimeScore({
    required this.homeTeam,
    required this.awayTeam,
  });

  int? homeTeam;
  int? awayTeam;

  factory TimeScore.fromJson(Map<String, dynamic> json) => TimeScore(
        homeTeam: json["homeTeam"],
        awayTeam: json["awayTeam"],
      );

  Map<String, dynamic> toJson() => {
        "homeTeam": homeTeam,
        "awayTeam": awayTeam,
      };
}

enum Winner { HOME_TEAM, DRAW, AWAY_TEAM }

final winnerValues = EnumValues({
  "AWAY_TEAM": Winner.AWAY_TEAM,
  "DRAW": Winner.DRAW,
  "HOME_TEAM": Winner.HOME_TEAM
});

class Season {
  Season({
    required this.id,
    this.startDate,
    this.endDate,
    this.currentMatchday,
  });

  int? id;
  DateTime? startDate;
  DateTime? endDate;
  int? currentMatchday;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        currentMatchday: json["currentMatchday"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate":
            "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        "currentMatchday": currentMatchday,
      };
}

enum Stage { REGULAR_SEASON }

final stageValues = EnumValues({"REGULAR_SEASON": Stage.REGULAR_SEASON});

enum MatchStatus { FINISHED, POSTPONED, SCHEDULED }

final statusValues = EnumValues({
  "FINISHED": MatchStatus.FINISHED,
  "POSTPONED": MatchStatus.POSTPONED,
  "SCHEDULED": MatchStatus.SCHEDULED
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }

    return reverseMap;
  }
}
