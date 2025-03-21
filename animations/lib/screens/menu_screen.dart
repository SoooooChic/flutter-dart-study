import 'package:animation_master/screens/apple_watch_screen.dart';
import 'package:animation_master/screens/container_transform_screen.dart';
import 'package:animation_master/screens/explicit_animations_screen.dart';
import 'package:animation_master/screens/fade_through_screen.dart';
import 'package:animation_master/screens/implicit_animations_dscreen.dart';
import 'package:animation_master/screens/music_player_screen.dart';
import 'package:animation_master/screens/rive_screen.dart';
import 'package:animation_master/screens/shared_axis_screen.dart';
import 'package:animation_master/screens/swiping_cards_screen.dart';
import 'package:animation_master/screens/wallet_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Animations')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ImplicitAnimationsScreen());
              },
              child: const Text('Implicit Animations'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ExplicitAnimationsScreen());
              },
              child: const Text('Explicit Animations'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const AppleWatchScreen());
              },
              child: const Text('Apple Watch'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const SwipingCardsScreen());
              },
              child: const Text('Swiping Cards'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const MusicPlayerScreen());
              },
              child: const Text('Music Player'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const RiveScreen());
              },
              child: const Text('Rive'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ContainerTransformScreen());
              },
              child: const Text('Container Transform'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const SharedAxisScreen());
              },
              child: const Text('Shared Axis'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const FadeThroughScreen());
              },
              child: const Text('Fade Through'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const WalletScreen());
              },
              child: const Text('Wallet Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
