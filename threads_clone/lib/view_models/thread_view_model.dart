import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/models/thread_model.dart';
import 'package:threads_clone/repos/thread_repo.dart';
import 'package:threads_clone/util.dart';

class ThreadViewModel extends StreamNotifier<List<ThreadModel>> {
  late final ThreadRepo _threadRepo;

  @override
  Stream<List<ThreadModel>> build() {
    _threadRepo = ref.read(threadRepoProvider);
    return getThreads();
  }

  Stream<List<ThreadModel>> getThreads() {
    return ref.read(threadRepoProvider).getThreads();
  }

  Future<List<ThreadModel>> searchThreads(String keyWord) {
    return ref.read(threadRepoProvider).searchThreads(keyWord);
  }

  Future<void> writeThread(
    String comment,
    List<File>? images,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    try {
      final imageUrl = images != null
          ? await Future.wait(
              images.map((file) async {
                return await _threadRepo.uploadImage(file);
              }),
            )
          : null;
      await _threadRepo.createThread(ThreadModel(
        author: "Anonmyous",
        comment: comment,
        imageUrls: imageUrl,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ));
    } catch (e) {
      // ignore: use_build_context_synchronously
      showFirebaseErrorSnack(context, e);
    }
  }
}

final threadProvider =
    StreamNotifierProvider<ThreadViewModel, List<ThreadModel>>(
  () => ThreadViewModel(),
);
