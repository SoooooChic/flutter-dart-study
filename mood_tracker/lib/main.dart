import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/router.dart';

// --------------------
// -firebase set
// --------------------
// dart pub global activate flutterfire_cli
// flutterfire configure
// flutter pub add firebase_core
// flutter pub add firebase_auth
// flutter pub add cloud_firestore
// flutter pub add firebase_storage
// flutterfire configure

// --------------------
// -flutter set
// --------------------
// flutter pub add flutter_riverpod
// flutter pub add go_router
// flutter pub add font_awesome_flutter

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp(const MyApp());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  // Widget build(BuildContext context) {
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Mood Tracker',
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.pinkAccent),
      darkTheme: ThemeData(useMaterial3: true, primaryColor: Colors.pinkAccent),
      // home: MainNavigationScreen(),
    );
  }
}
