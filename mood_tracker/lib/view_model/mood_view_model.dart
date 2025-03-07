import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/models/mood_model.dart';
import 'package:mood_tracker/repos/mood_repo.dart';
import 'package:mood_tracker/util.dart';

class MoodViewModel extends StreamNotifier<List<MoodModel>> {
  late final MoodRepo _moodRepository;

  @override
  Stream<List<MoodModel>> build() {
    _moodRepository = ref.read(moodRepoProvider);
    return getThreads();
  }

  Stream<List<MoodModel>> getThreads() {
    return ref.read(moodRepoProvider).getMood();
  }

  Future<List<MoodModel>> searchThreads(String keyWord) {
    return ref.read(moodRepoProvider).searchThreads(keyWord);
  }

  Future<void> writeMood(
    String feel,
    String emoji,
    String comment,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    try {
      await _moodRepository.createMood(
        MoodModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          feel: feel,
          emoji: emoji,
          comment: comment,
          createdDate: int.parse(DateFormat('yyyyMMdd').format(DateTime.now())),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showFirebaseErrorSnack(context, e);
    }
  }

  Future<void> fetchThreadList(String keyword) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _moodRepository.searchThreads(keyword),
    );
  }
}

final moodProvider = StreamNotifierProvider<MoodViewModel, List<MoodModel>>(
  () => MoodViewModel(),
);
