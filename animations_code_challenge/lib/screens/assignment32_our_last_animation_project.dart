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
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);
  late final size = MediaQuery.of(context).size;
  final GameRepository gameRepository = GameRepository();
  late List<GameModel> _gameList = [];

  int _currentPage = 0;
  int _selectedGame = 0;
  bool _isCollapsed = false;
  bool _isSyncing = false;

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });

    if (_delayedController.hasClients) {
      _delayedController.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
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

    // _pageController.addListener(() {
    // if (_pageController.page == null) return;
    // _scroll.value = _pageController.page!;
    // _delayedController.animateTo(
    //   _pageController.position.pixels,
    //   // _delayedController.animateToPage(
    //   //   _pageController.page!.round(),
    //   duration: const Duration(milliseconds: 200),
    //   curve: Curves.linear,
    // );
    // });

    _pageController.addListener(() {
      if (!_delayedController.hasClients || _isSyncing) return;

      final page = _pageController.page;
      if (page != null && (_delayedController.page?.toInt() != page.toInt())) {
        _isSyncing = true;
        _delayedController
            .animateTo(
              _pageController.offset,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            )
            .then((_) => _isSyncing = false);
      }
    });

    _delayedController.addListener(() {
      if (!_pageController.hasClients || _isSyncing) return;

      final page = _delayedController.page;
      if (page != null && (_pageController.page?.toInt() != page.toInt())) {
        _isSyncing = true;
        _pageController
            .animateTo(
              _delayedController.offset,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            )
            .then((_) => _isSyncing = false);
      }
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
              GameBackground(
                imageUrl: _gameList[_currentPage].thumbnailUrl,
                isCollapsed: _isCollapsed,
                key: ValueKey(_currentPage),
              ),
              GameDetail(
                controller: _delayedController,
                currentPage: _currentPage,
                gameList: _gameList,
                isCollapsed: _isCollapsed,
                onTap: _onTap,
              ),
              GamePreview(
                controller: _pageController,
                scroll: _scroll,
                currentPage: _currentPage,
                gameList: _gameList,
                isCollapsed: _isCollapsed,
                onPageChanged: _onPageChanged,
                onTap: _onTap,
              ),
              GameDetailPanel(
                game: _gameList[_selectedGame],
                isCollapsed: _isCollapsed,
              ),
            ],
          ),
        );
  }
}

class GameBackground extends StatelessWidget {
  final String imageUrl;
  final bool isCollapsed;

  const GameBackground({
    super.key,
    required this.imageUrl,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Container(
        key: ValueKey(imageUrl),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
          child: Container(
            color: Colors.black.withValues(alpha: isCollapsed ? 0.7 : 0.3),
          ),
        ),
      ),
    );
  }
}

class GameDetail extends StatelessWidget {
  final PageController controller;
  final List<GameModel> gameList;
  final int currentPage;
  final bool isCollapsed;
  final void Function(int) onTap;

  const GameDetail({
    super.key,
    required this.controller,
    required this.gameList,
    required this.currentPage,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
          top: 300,
          child: SizedBox(
            height: 630,
            width: size.width,
            child: PageView.builder(
              controller: controller,
              itemCount: gameList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final game = gameList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => onTap(index),
                      child: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.white,
                            size: 50,
                          )
                          .animate(target: isCollapsed ? 0 : 1)
                          .fadeOut(duration: 300.ms),
                    ),
                    const SizedBox(height: 10),
                    Transform.scale(
                      scale: (index == currentPage) ? 1.15 : 0.9,
                      child: Container(
                        width: 300,
                        padding: const EdgeInsets.symmetric(
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
                            const SizedBox(height: 100),
                            Text(
                              "\"${game.gameName}\"",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "출시일 : ${game.releaseDate}",
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(game.genres),
                            if (game.supportKorean)
                              Text("공식 한국어 지원 ${game.supportKoreanEtc}"),
                            for (var store in game.stores)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${store.store} (${store.platform})"),
                                  const SizedBox(width: 10),
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
        .animate(target: isCollapsed ? 1 : 0)
        .moveY(begin: 0, end: 500, duration: 500.ms, curve: Curves.easeInCirc);
  }
}

class GamePreview extends StatelessWidget {
  final PageController controller;
  final ValueNotifier<double> scroll;
  final List<GameModel> gameList;
  final int currentPage;
  final bool isCollapsed;
  final Function(int) onPageChanged;
  final Function(int) onTap;

  const GamePreview({
    super.key,
    required this.controller,
    required this.scroll,
    required this.gameList,
    required this.currentPage,
    required this.isCollapsed,
    required this.onPageChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
          top: 230,
          child: SizedBox(
            height: 230,
            width: size.width,
            child: PageView.builder(
              controller: controller,
              itemCount: gameList.length,
              onPageChanged: (index) {
                scroll.value = index.toDouble();
                onPageChanged(index);
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final game = gameList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => onTap(index),
                      child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 50,
                          )
                          .animate(target: isCollapsed ? 1 : 0)
                          .fadeOut(duration: 300.ms),
                    ),
                    ValueListenableBuilder<double>(
                      valueListenable: scroll,
                      builder: (context, scrollValue, _) {
                        final diff = (scrollValue - index).abs();
                        final scale = 1 - (diff * 0.2).clamp(0.0, 1.0);

                        return GestureDetector(
                          onTap: () => onTap(index),
                          child: Transform.scale(
                            scale: scale,
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withValues(alpha: 0.8),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(game.thumbnailUrl),
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
        .animate(target: isCollapsed ? 1 : 0)
        .moveY(begin: 0, end: 700, duration: 500.ms, curve: Curves.easeInCirc);
  }
}

class GameDetailPanel extends StatelessWidget {
  final GameModel game;
  final bool isCollapsed;

  const GameDetailPanel({
    super.key,
    required this.game,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
            width: size.width,
            height: size.height,
            constraints: BoxConstraints(maxHeight: size.height * 0.9),
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    game.gameName,
                    style: const TextStyle(color: Colors.white, fontSize: 48),
                  ),
                  const Divider(color: Colors.white, thickness: 2, height: 30),
                  Text(
                    game.genres,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const Divider(color: Colors.white, thickness: 2, height: 30),
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.8),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(game.thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    game.gameDescription,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                    height: 50,
                    indent: 50,
                    endIndent: 50,
                  ),
                  for (var store in game.stores)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${store.store} (${store.platform})",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "가격: ${store.price.isNotEmpty ? '${store.price}원' : '정보 없음'}",
                          style: const TextStyle(color: Colors.white70),
                          softWrap: true,
                        ),
                      ],
                    ),
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                    height: 50,
                    indent: 50,
                    endIndent: 50,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://img.youtube.com/vi/${game.trailerUrl}/hqdefault.jpg',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.play_circle_fill,
                        size: 64,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          )
          .animate(target: isCollapsed ? 1 : 0)
          .fadeIn(duration: 300.ms)
          .slideY(begin: -1, end: 0, duration: 500.ms, curve: Curves.easeOut),
    );
  }
}
