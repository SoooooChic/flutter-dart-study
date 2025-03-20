import 'dart:convert';
import 'package:animations_code_challenge/model/game_model.dart';
import 'package:flutter/services.dart';

class GameRepository {
  Future<List<GameModel>> loadGames() async {
    String jsonString = await rootBundle.loadString('assets/game_list.json');

    List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData.map((e) => GameModel.fromJson(e)).toList();
  }
}
