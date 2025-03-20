import 'dart:convert';

class GameModel {
  final String gameCalendarId;
  final String gameName;
  final String releaseDate;
  final String thumbnailUrl;
  final String trailerUrl;
  final String genres;
  final bool supportKorean;
  final String? supportKoreanEtc;
  final String gameDescription;
  final List<StoreInfo> stores;

  GameModel({
    required this.gameCalendarId,
    required this.gameName,
    required this.releaseDate,
    required this.thumbnailUrl,
    required this.trailerUrl,
    required this.genres,
    required this.supportKorean,
    this.supportKoreanEtc,
    required this.gameDescription,
    required this.stores,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      gameCalendarId: json['game_calendar_id'] as String,
      gameName: json['game_name'] as String,
      releaseDate: json['release_date'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      trailerUrl: json['trailer_url'] as String,
      genres: json['genres'] as String,
      supportKorean: json['support_korean_yn'] == "1",
      supportKoreanEtc: json['support_korean_etc'] as String?,
      gameDescription: json['game_description'] as String,
      stores:
          (jsonDecode(json['store_json']) as List)
              .map((e) => StoreInfo.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_calendar_id': gameCalendarId,
      'game_name': gameName,
      'release_date': releaseDate,
      'thumbnail_url': thumbnailUrl,
      'trailer_url': trailerUrl,
      'genres': genres,
      'support_korean_yn': supportKorean ? "1" : "0",
      'support_korean_etc': supportKoreanEtc,
      'game_description': gameDescription,
      'store_json': jsonEncode(stores.map((e) => e.toJson()).toList()),
    };
  }
}

class StoreInfo {
  final String url;
  final String price;
  final String store;
  final String platform;

  StoreInfo({
    required this.url,
    required this.price,
    required this.store,
    required this.platform,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) {
    return StoreInfo(
      url: json['url'] as String,
      price: json['price'] as String,
      store: json['store'] as String,
      platform: json['platform'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'price': price, 'store': store, 'platform': platform};
  }
}
