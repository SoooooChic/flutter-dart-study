import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/models/user_model.dart';
import 'package:threads_clone/repos/users_repo.dart';

class UsersViewModel extends AsyncNotifier<List<UserModel>> {
  late final UsersRepo _usersRepo;

  @override
  FutureOr<List<UserModel>> build() async {
    _usersRepo = ref.read(usersRepoProvider);
    return _usersRepo.userList(null);
  }

  Future<void> fetchUserList(String? keyword) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _usersRepo.userList(keyword));
  }
}

final userProvider = AsyncNotifierProvider<UsersViewModel, List<UserModel>>(
  () => UsersViewModel(),
);
