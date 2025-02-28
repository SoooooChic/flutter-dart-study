import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/models/user_model.dart';

class UsersRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<UserModel>> userList(String? keyword) async {
    Query query = _db.collection("users");

    if (keyword != null && keyword.isNotEmpty) {
      query =
          query.orderBy("userId").startAt([keyword]).endAt(["$keyword\uf8ff"]);
    }

    final queryGet = await query.get();

    final List<UserModel> users = queryGet.docs
        .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return users;
  }
}

final usersRepoProvider = Provider((ref) => UsersRepo());
