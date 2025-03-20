import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animations_code_challenge/model/game_model.dart';
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
  final PageController _delayedController = PageController(
    viewportFraction: 0.8,
  );

  int _currentPage = 0;
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);
  late final size = MediaQuery.of(context).size;
  final GameRepository gameRepository = GameRepository();
  late List<GameModel> _gameList = [];
  int _selectedGame = 0;
  bool _isCollapsed = false;

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  void _onTap(int gameIndex) {
    setState(() {
      _selectedGame = gameIndex;
      _isCollapsed = !_isCollapsed;
    });
  }

  Future<void> _loadGames() async {
    final games = await gameRepository.loadGames();
    if (mounted) {
      setState(() {
        _gameList = games;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadGames();
    _pageController.addListener(() {
      if (_pageController.page == null) return;
      _scroll.value = _pageController.page!;
      _delayedController.animateTo(
        _pageController.position.pixels,
        // _delayedController.animateToPage(
        //   _pageController.page!.round(),
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _delayedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _gameList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  key: ValueKey(_currentPage),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_gameList[_currentPage].thumbnailUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                    child: Container(
                      color: Colors.black.withValues(
                        alpha: _isCollapsed ? 0.7 : 0.3,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                    top: _isCollapsed ? size.height - 10 : 350,
                    child: SizedBox(
                      height: 630,
                      width: size.width,
                      child: PageView.builder(
                        controller: _delayedController,
                        itemCount: _gameList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final game = _gameList[index];
                          return Column(
                            children: [
                              Transform.scale(
                                scale: (index == _currentPage) ? 1.15 : 0.9,
                                child: Container(
                                  width: 300,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 30,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 100),
                                      Text(
                                        "\"${game.gameName}\"",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
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
                                      for (var store in game.stores)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${store.store} (${store.platform})",
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "가격: ${store.price.isNotEmpty ? '${store.price}원' : '정보 없음'}",
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                  .animate(target: _isCollapsed ? 1 : 0)
                  .fadeOut(duration: 200.ms)
                  .moveY(
                    begin: 0,
                    end: 300,
                    duration: 500.ms,
                    curve: Curves.linear,
                  ),
              Positioned(
                    top: 230,
                    child: SizedBox(
                      height: 230,
                      width: size.width,
                      child: PageView.builder(
                        onPageChanged: _onPageChanged,
                        controller: _pageController,
                        itemCount: _gameList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final game = _gameList[index];
                          return Column(
                            children: [
                              GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isCollapsed = !_isCollapsed;
                                      });
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_up_sharp,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  )
                                  .animate(target: _isCollapsed ? 1 : 0)
                                  .fadeIn(duration: 300.ms),
                              ValueListenableBuilder(
                                valueListenable: _scroll,
                                builder: (context, scroll, child) {
                                  final difference = (scroll - index).abs();
                                  final scale = 1 - (difference * 0.2);
                                  return GestureDetector(
                                    onTap: () => _onTap(index),
                                    child: Transform.scale(
                                      scale: scale,
                                      child: Container(
                                        height: 170,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.red.withValues(
                                                alpha: 0.8,
                                              ),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              game.thumbnailUrl,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                  .animate(target: _isCollapsed ? 1 : 0)
                  .moveY(
                    begin: 0,
                    end: 550,
                    duration: 500.ms,
                    curve: Curves.easeInOut,
                  ),
            ],
          ),
        );
  }
}
