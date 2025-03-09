import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String getImage() {
  final random = Random();
  return 'https://picsum.photos/300/200?hash=${random.nextInt(10000)}';
}

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(
        (error as FirebaseException).message ?? "Something wen't wrong.",
      ),
    ),
  );
}

String timeAgo(int timestamp) {
  DateTime createdDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
  DateTime now = DateTime.now();
  Duration difference = now.difference(createdDate);

  if (difference.inSeconds < 60) {
    return "${difference.inSeconds} seconds ago";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} minutes ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  } else {
    DateTime createdDateOnly = DateTime(
      createdDate.year,
      createdDate.month,
      createdDate.day,
    );
    DateTime nowOnly = DateTime(now.year, now.month, now.day);
    int dayDiff = nowOnly.difference(createdDateOnly).inDays;

    if (dayDiff == 0) {
      return "Today";
    } else if (dayDiff == 1) {
      return "Yesterday";
    } else {
      return "$dayDiff days ago";
    }
  }
}
