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
    final fileRef = _storage.ref().child("threads/$fileName");
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }

  Future<void> createThread(ThreadModel thread) async {
    await _db.collection("threads").doc(thread.author).set(thread.toJson());
  }
}

// final threadRepo = Provider((ref) => ThreadRepo());
final threadRepo = Provider<ThreadRepo>((ref) => ThreadRepo());
