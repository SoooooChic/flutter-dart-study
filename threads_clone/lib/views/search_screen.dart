import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/models/user_model.dart';
import 'package:threads_clone/util.dart';
import 'package:threads_clone/widgets/search_users.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = 'search';
  static const String routeURL = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  List<UserModel> _users = [];

  List<UserModel> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _generateUsers();
  }

  void _generateUsers() {
    final faker = Faker();
    setState(() {
      _users = List.generate(20, (index) {
        return UserModel(
          userId: faker.internet.userName(),
          userName: faker.person.name(),
          followers: faker.randomGenerator.integer(1000) / 10,
          avatarUrl:
              'https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(60)}',
          followersAvatar: faker.randomGenerator.boolean()
              ? 'https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(60)}'
              : '',
        );
      });
      _filteredUsers = List.from(_users);
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _filteredUsers = _users.where((user) {
        return user.userId.toLowerCase().contains(value.toLowerCase()) ||
            user.userName.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: Sizes.size28,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: _filteredUsers.length,
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.only(left: 70, right: 10),
          child: Divider(height: 0, thickness: 1),
        ),
        itemBuilder: (context, index) {
          return SearchUser(user: _filteredUsers[index]);
        },
      ),
    );
  }
}
