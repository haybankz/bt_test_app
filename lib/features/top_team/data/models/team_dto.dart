import 'package:bt_test_app/features/top_team/data/export.dart';

class TeamDto {
  TeamDto({
    this.id,
    this.area,
    this.activeCompetitions,
    this.name,
    this.shortName,
    this.tla,
    this.crestUrl,
    this.address,
    this.phone,
    this.website,
    this.email,
    this.founded,
    this.clubColors,
    this.venue,
    this.squad,
    this.lastUpdated,
  });

  TeamDto.fromJson(dynamic json) {
    id = json['id'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    if (json['activeCompetitions'] != null) {
      activeCompetitions = [];
      json['activeCompetitions'].forEach((v) {
        activeCompetitions?.add(ActiveCompetitions.fromJson(v));
      });
    }
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crestUrl = json['crestUrl'];
    address = json['address'];
    phone = json['phone'];
    website = json['website'];
    email = json['email'];
    founded = json['founded'];
    clubColors = json['clubColors'];
    venue = json['venue'];
    if (json['squad'] != null) {
      squad = [];
      json['squad'].forEach((v) {
        squad?.add(Squad.fromJson(v));
      });
    }
    lastUpdated = json['lastUpdated'];
  }
  int? id;
  Area? area;
  List<ActiveCompetitions>? activeCompetitions;
  String? name;
  String? shortName;
  String? tla;
  String? crestUrl;
  String? address;
  String? phone;
  String? website;
  String? email;
  int? founded;
  String? clubColors;
  String? venue;
  List<Squad>? squad;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (area != null) {
      map['area'] = area?.toJson();
    }
    if (activeCompetitions != null) {
      map['activeCompetitions'] =
          activeCompetitions?.map((v) => v.toJson()).toList();
    }
    map['name'] = name;
    map['shortName'] = shortName;
    map['tla'] = tla;
    map['crestUrl'] = crestUrl;
    map['address'] = address;
    map['phone'] = phone;
    map['website'] = website;
    map['email'] = email;
    map['founded'] = founded;
    map['clubColors'] = clubColors;
    map['venue'] = venue;
    if (squad != null) {
      map['squad'] = squad?.map((v) => v.toJson()).toList();
    }
    map['lastUpdated'] = lastUpdated;
    return map;
  }
}

class Squad {
  Squad({
    this.id,
    this.name,
    this.position,
    this.dateOfBirth,
    this.countryOfBirth,
    this.nationality,
    this.shirtNumber,
    this.role,
  });

  Squad.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    dateOfBirth = json['dateOfBirth'];
    countryOfBirth = json['countryOfBirth'];
    nationality = json['nationality'];
    shirtNumber = json['shirtNumber'];
    role = json['role'];
  }
  int? id;
  String? name;
  String? position;
  String? dateOfBirth;
  String? countryOfBirth;
  String? nationality;
  dynamic shirtNumber;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['position'] = position;
    map['dateOfBirth'] = dateOfBirth;
    map['countryOfBirth'] = countryOfBirth;
    map['nationality'] = nationality;
    map['shirtNumber'] = shirtNumber;
    map['role'] = role;
    return map;
  }
}

class ActiveCompetitions {
  ActiveCompetitions({
    this.id,
    this.area,
    this.name,
    this.code,
    this.plan,
    this.lastUpdated,
  });

  ActiveCompetitions.fromJson(dynamic json) {
    id = json['id'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    name = json['name'];
    code = json['code'];
    plan = json['plan'];
    lastUpdated = json['lastUpdated'];
  }
  int? id;
  Area? area;
  String? name;
  String? code;
  String? plan;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (area != null) {
      map['area'] = area?.toJson();
    }
    map['name'] = name;
    map['code'] = code;
    map['plan'] = plan;
    map['lastUpdated'] = lastUpdated;
    return map;
  }
}
