import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/models/thread_model.dart';
import 'package:threads_clone/repos/thread_repo.dart';
import 'package:threads_clone/util.dart';

class ThreadViewModel extends AsyncNotifier<void> {
  late final ThreadRepo _threadRepo;

  @override
  FutureOr<void> build() {
    _threadRepo = ref.read(threadRepoProvider);
  }

  Future<void> writeThread(
    String comment,
    List<File>? images,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
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
      },
    );

    if (state.hasError) {
      // ignore: use_build_context_synchronously
      showFirebaseErrorSnack(context, state.error);
    } else {
      // ignore: use_build_context_synchronously
      // context.go('/');
    }
  }

  Future<List<ThreadModel>> getThreads() {
    return _threadRepo.getThreads();
  }

  Stream<List<ThreadModel>> watchThreads() {
    return _threadRepo.watchThreads();
  }
}

final threadProvider = AsyncNotifierProvider<ThreadViewModel, void>(
  () => ThreadViewModel(),
);

final threadWatchProvider = StreamProvider<List<ThreadModel>>((ref) {
  final threadRepo = ref.read(threadRepoProvider);
  return threadRepo.watchThreads();
});
