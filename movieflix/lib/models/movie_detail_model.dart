class MovieDetailModel {
  final String title, overview, id;
  final num voteAverage, voteCount;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        id = json['id'].toString(),
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}
