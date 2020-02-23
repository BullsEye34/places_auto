import 'dart:convert';

import 'package:flutter/services.dart';

class Players {
  String keyword;
  String id;
  String autocompleteterm;
  String country;

  Players({this.keyword, this.id, this.autocompleteterm, this.country});

  factory Players.fromJson(Map<String, dynamic> parsedJson) {
    return Players(
        keyword: parsedJson['autocompleteTerm'] as String,
        id: parsedJson['id'] as String,
        autocompleteterm: parsedJson['autocompleteTerm'] as String,
        country: parsedJson['state'] as String);
  }
}

class PlayersViewModel {
  static List<Players> players;

  static Future loadPlayers() async {
    try {
      players = new List<Players>();
      String jsonString = await rootBundle.loadString('assets/players1.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['players'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        players.add(new Players.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
