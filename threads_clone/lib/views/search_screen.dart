import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/view_models/users_view_model.dart';
import 'package:threads_clone/widgets/search_users.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = 'search';
  static const String routeURL = '/search';

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _isSearch = false;
  bool _isSearchTap = false;

  @override
  void initState() {
    super.initState();
  }

  void _onSearchChanged(String value) {
    if (value.isNotEmpty) {
      _isSearch = true;
    } else {
      _isSearch = false;
    }

    ref.read(userProvider.notifier).fetchUserList(value);
  }

  void _onTapSearch() {
    _isSearchTap = true;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userList = ref.watch(userProvider);

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
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (_isSearch)
            Container(
              padding: EdgeInsets.all(Sizes.size20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.search),
                      Gaps.h10,
                      Expanded(
                        child: Text('"${_textEditingController.text}" Search'),
                      ),
                      GestureDetector(
                        onTap: _onTapSearch,
                        child: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  const Divider(height: 0, thickness: 1),
                ],
              ),
            ),
          Expanded(
            child: userList.when(
              data: (users) => ListView.separated(
                itemCount: users.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(left: 70, right: 10),
                  child: Divider(height: 0, thickness: 1),
                ),
                itemBuilder: (context, index) {
                  return SearchUser(user: users[index]);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
