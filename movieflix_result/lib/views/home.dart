import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix_result/consts.dart';
import 'package:movieflix_result/services/movie_service.dart';
import 'package:movieflix_result/widgets/horizontal_scrollable_movies.dart';

class Home extends ConsumerWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Popular Movies", style: TextStyle(fontSize: 24)),
          Gaps.v20,
          HorizontalScrollableMovies(
            fetchType: FetchType.popular,
            imageType: ImageType.landscape,
          ),
          Gaps.v20,
          Text("Now In Cinemas", style: TextStyle(fontSize: 24)),
          Gaps.v20,
          HorizontalScrollableMovies(
            fetchType: FetchType.nowPlaying,
            imageType: ImageType.square,
            withTitle: true,
          ),
          Gaps.v20,
          Text("Coming soon", style: TextStyle(fontSize: 24)),
          Gaps.v20,
          HorizontalScrollableMovies(
            fetchType: FetchType.comingSoon,
            imageType: ImageType.square,
            withTitle: true,
          ),
        ],
      ),
    );
  }
}
