class MovieDetailModel {
  final String title, overview, id, homepage;
  final num voteAverage;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        id = json['id'].toString(),
        homepage = json['homepage'],
        voteAverage = json['vote_average'];
}
