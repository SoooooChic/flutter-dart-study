import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<List<MoodModel>> searchMoods(int date) async {
    final query =
        await _db
            .collection("moods")
            .where(
              Filter.and(
                Filter(
                  "uid",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                ),
                Filter("createdDate", isEqualTo: date),
              ),
            )
            // .orderBy("createdAt", descending: true)
            .get();

    return query.docs.map((doc) => MoodModel.fromJson(doc.data())).toList();
  }

  Future<void> deleteMood(String uid, int createdAt) async {
    final querySnapshot =
        await _db
            .collection("moods")
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("createdAt", isEqualTo: createdAt)
            .get();

    for (var doc in querySnapshot.docs) {
      await _db.collection("moods").doc(doc.id).delete();
    }
  }
}

final moodRepoProvider = Provider<MoodRepo>((ref) => MoodRepo());
