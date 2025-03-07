import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/models/mood_model.dart';

class MoodRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createMood(MoodModel mood) async {
    await _db.collection("moods").add(mood.toJson());
  }

  Stream<List<MoodModel>> getMood() {
    return _db
        .collection("moods")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((doc) => MoodModel.fromJson(doc.data())).toList(),
        );
  }

  Future<List<MoodModel>> searchThreads(String keyword) async {
    final query =
        await _db
            .collection("moods")
            .where(
              Filter.or(
                Filter("uid", isEqualTo: keyword),
                Filter("comment", isEqualTo: keyword),
              ),
            )
            .get();

    return query.docs.map((doc) => MoodModel.fromJson(doc.data())).toList();
  }
}

final moodRepoProvider = Provider<MoodRepo>((ref) => MoodRepo());
