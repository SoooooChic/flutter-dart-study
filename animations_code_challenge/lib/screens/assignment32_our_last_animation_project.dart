import 'dart:ui';
import 'package:animations_code_challenge/model/game_model.dart';
import 'package:flutter/material.dart';
import 'package:animations_code_challenge/repo/game_repository.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Assignment32OurLastAnimationProject extends StatefulWidget {
  const Assignment32OurLastAnimationProject({super.key});

  @override
  State<Assignment32OurLastAnimationProject> createState() =>
      _Assignment32OurLastAnimationProjectState();
}

class _Assignment32OurLastAnimationProjectState
    extends State<Assignment32OurLastAnimationProject> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  late final size = MediaQuery.of(context).size;

  final GameRepository gameRepository = GameRepository();
  late List<GameModel> _gameList = [];
  bool _isLoading = true;

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadGames();
    _pageController.addListener(() {
      if (_pageController.page == null) return;
      _scroll.value = _pageController.page!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int imageIndex) {}

  Future<void> _loadGames() async {
    try {
      final games = await gameRepository.loadGames();
      setState(() {
        _gameList = games;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Container(
              key: ValueKey(_currentPage),
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: NetworkImage(_gameList[_currentPage].thumbnailUrl),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(color: Colors.black.withValues(alpha: 0.5)),
              ),
            ),
          ),
          PageView.builder(
            onPageChanged: _onPageChanged,
            controller: _pageController,
            itemCount: _gameList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final game = _gameList[index];

              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _scroll,
                    builder: (context, scroll, child) {
                      final difference = (scroll - index).abs();
                      final scale = 1 - (difference * 0);
                      return GestureDetector(
                        onTap: () => _onTap(index + 1),
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: 70,
                                left: -10,
                                child: Container(
                                  height: size.height * 0.5,
                                  width: size.width * 0.65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 100),
                                      Text(
                                        "\"${game.gameName}\"",
                                        style: TextStyle(
                                          fontSize: 38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "출시일 : ${game.releaseDate}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(game.genres),
                                      if (game.supportKorean)
                                        Text(
                                          "공식 한국어 지원 ${game.supportKoreanEtc}",
                                        ),

                                      ListView.builder(
                                        itemCount: game.stores.length,
                                        itemBuilder: (context, storeIndex) {
                                          final store = game.stores[storeIndex];
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 20,
                                            ),
                                            color: Colors.grey.withValues(
                                              alpha: 0.2,
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                "${store.store} (${store.platform})",
                                              ),
                                              subtitle: Text(
                                                "가격: ${store.price.isNotEmpty ? '${store.price}원' : '정보 없음'}",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withValues(alpha: 0.4),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                  // image: DecorationImage(
                                  //   image: NetworkImage(game.thumbnailUrl),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                child: Text(
                                  'image',
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 90,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
