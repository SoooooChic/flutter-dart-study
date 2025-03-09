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
    return getMoods();
  }

  Stream<List<MoodModel>> getMoods() {
    return Stream.fromFuture(
      ref
          .read(moodRepoProvider)
          .searchMoods(
            int.parse(DateFormat('yyyyMMdd').format(DateTime.now())),
          ),
    );
  }

  Future<void> searchMoods(DateTime date) async {
    state = const AsyncValue.loading();
    try {
      final moods = await _moodRepository.searchMoods(
        int.parse(DateFormat('yyyyMMdd').format(date)),
      );
      state = AsyncValue.data(moods);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> writeMood(
    String feel,
    String emoji,
    String comment,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    try {
      final newMood = MoodModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        feel: feel,
        emoji: emoji,
        comment: comment,
        createdDate: int.parse(DateFormat('yyyyMMdd').format(DateTime.now())),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _moodRepository.createMood(newMood);

      state = AsyncValue.data(
        await _moodRepository.searchMoods(
          int.parse(DateFormat('yyyyMMdd').format(DateTime.now())),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showFirebaseErrorSnack(context, e);
    }
  }

  Future<void> deleteMood(
    String uid,
    int createdAt,
    BuildContext context,
  ) async {
    try {
      await _moodRepository.deleteMood(uid, createdAt);

      state = AsyncValue.data(
        await _moodRepository.searchMoods(
          int.parse(DateFormat('yyyyMMdd').format(DateTime.now())),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showFirebaseErrorSnack(context, e);
    }
  }
}

final moodProvider = StreamNotifierProvider<MoodViewModel, List<MoodModel>>(
  () => MoodViewModel(),
);
