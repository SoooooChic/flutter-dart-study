import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/widgets/movie_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// 세 가지 영화 카테고리의 데이터를 가져옴
  final Future<List<MovieModel>> popular = ApiService.getMovies("popular");
  final Future<List<MovieModel>> nowPlaying =
      ApiService.getMovies('now-playing');
  final Future<List<MovieModel>> comingSoon =
      ApiService.getMovies('coming-soon');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black, // 검은색
              Colors.deepPurple, // 보라색
              Colors.blueGrey, // 부드러운 회색
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              buildCategorySection(
                  'Popular Movies', popular, 300, 0, 'Popular'),
              //SizedBox(height: 10),
              buildCategorySection('Now Playing', nowPlaying, 180, 180, 'Now'),
              //SizedBox(height: 10),
              buildCategorySection(
                  'Coming Soon', comingSoon, 150, 150, 'Coming'),
            ],
          ),
        ),
      ),
    );
  }

  /// 카테고리 섹션을 빌드하는 함수
  Widget buildCategorySection(String title, Future<List<MovieModel>> future,
      double height, double width, String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: height, // 고정 높이 설정
          child: FutureBuilder<List<MovieModel>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (snapshot.hasData) {
                return makeList(snapshot, height, width, category);
              } else {
                return const Center(child: Text('No Data'));
              }
            },
          ),
        ),
      ],
    );
  }
}

ListView makeList(AsyncSnapshot<List<MovieModel>> snapshot, double height,
    double width, String category) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    itemBuilder: (context, index) {
      var movie = snapshot.data![index];
      return Movie(
          title: movie.title,
          thumb: movie.thumb,
          id: movie.id,
          height: height,
          width: width,
          category: category);
    },
    separatorBuilder: (context, index) => const SizedBox(width: 10),
  );
}
