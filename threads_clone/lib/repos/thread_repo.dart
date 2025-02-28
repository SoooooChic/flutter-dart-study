import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/models/thread_model.dart';
import 'package:uuid/uuid.dart';

class ThreadRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    final String fileName = Uuid().v4();
    final fileRef = _storage.ref().child("threadImages/$fileName");
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }

  Future<void> createThread(ThreadModel thread) async {
    await _db.collection("threads").add(thread.toJson());
  }

  Stream<List<ThreadModel>> getThreads() {
    return _db
        .collection("threads")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map((doc) => ThreadModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<List<ThreadModel>> searchThreads(String keyword) async {
    final query = await _db
        .collection("threads")
        .where(
          Filter.or(
            Filter("author", isEqualTo: keyword),
            Filter("comment", isEqualTo: keyword),
          ),
        )
        .get();

    return query.docs.map((doc) => ThreadModel.fromJson(doc.data())).toList();
  }

  // Future<List<ThreadModel>> threadList()
}

final threadRepoProvider = Provider<ThreadRepo>((ref) => ThreadRepo());
