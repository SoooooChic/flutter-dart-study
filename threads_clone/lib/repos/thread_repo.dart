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
    final fileRef = _storage.ref().child("threadsImages/$fileName");
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }

  Future<void> createThread(ThreadModel thread) async {
    await _db.collection("threads").add(thread.toJson());
  }

  Future<List<ThreadModel>> getThreads() async {
    final snapshot = await _db
        .collection("threads")
        .orderBy("createdAt", descending: true)
        .get();
    return snapshot.docs
        .map((doc) => ThreadModel.fromJson(doc.data()))
        .toList();
  }

  Stream<List<ThreadModel>> watchThreads() {
    return _db
        .collection("threads")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ThreadModel.fromJson(doc.data()))
          .toList();
    });
  }
}

final threadRepoProvider = Provider<ThreadRepo>((ref) => ThreadRepo());
