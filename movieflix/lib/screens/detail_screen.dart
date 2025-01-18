import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id, category;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
    required this.category,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Hero(
            tag: '${widget.category}/${widget.id}',
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.thumb,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.5), // 배경 어두운 필터 추가
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 200), // 배경 이미지 상단 간격
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  FutureBuilder<MovieDetailModel>(
                    future: movie,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vote Avg : ${snapshot.data!.voteAverage}',
                              style: const TextStyle(
                                color: Colors.amberAccent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              snapshot.data!.overview,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrlString(snapshot.data!.homepage);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.yellow,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(2, 2),
                                        color: Colors.black
                                            .withValues(alpha: 0.1)),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 30,
                                  ),
                                  child: Text(
                                    'VISIT HOMEPAGE',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "Error loading movie details",
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
