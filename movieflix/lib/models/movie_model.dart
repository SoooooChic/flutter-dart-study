class MovieModel {
  final String title, thumb, id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
        id = json['id'].toString();
}
