import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final usersCollectionProvider = Provider((ref) {
  return ref.watch(firestoreProvider).collection('users');
});

final userDataProvider =
    StreamProvider.family<DocumentSnapshot, String>((ref, userId) {
  return ref.watch(usersCollectionProvider).doc(userId).snapshots();
});
