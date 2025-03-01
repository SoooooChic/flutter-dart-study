import 'package:assignment26/firebase_options.dart';
import 'package:assignment26/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Firebase App',
      routerConfig: ref.watch(routerProvider),
    );
  }
}
