import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/view_models/thread_view_model.dart';
import 'package:threads_clone/view_models/users_view_model.dart';
import 'package:threads_clone/widgets/search_users.dart';
import 'package:threads_clone/widgets/thread.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = 'search';
  static const String routeURL = '/search';

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late AnimationController _animationController;
  final FocusNode _searchFocusNode = FocusNode();

  bool _isSearch = false;
  bool _isSearchTap = false;
  bool _isSearchFocus = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocus = _searchFocusNode.hasFocus;
      });
    });
  }

  void _onSearchChanged(String value) {
    _isSearch = value.isNotEmpty;
    ref.read(userProvider.notifier).fetchUserList(value);
  }

  void _onTapSearch() {
    _isSearchTap = true;
    // String keyword = _textEditingController.text;
    // ref.read(threadProvider.notifier).searchThreads(keyword);
    // ref.read(threadProvider.notifier).searchThreads(keyword);
    setState(() {});
  }

  void _onTapSearchBack() {
    _isSearch = false;
    _isSearchTap = false;
    _textEditingController.clear();
    FocusScope.of(context).unfocus();
    ref.read(userProvider.notifier).fetchUserList(null);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userList = ref.watch(userProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: (_isSearch || _isSearchFocus) ? 114 : 200,
          child: AppBar(
            elevation: 1,
            centerTitle: false,
            title: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (_isSearch || _isSearchFocus)
                      GestureDetector(
                        onTap: _onTapSearchBack,
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    Expanded(
                      child: CupertinoSearchTextField(
                        controller: _textEditingController,
                        onChanged: _onSearchChanged,
                        focusNode: _searchFocusNode,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (_isSearch &&
              !_isSearchTap &&
              _textEditingController.text.isNotEmpty)
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
          (_isSearchTap && _textEditingController.text.isNotEmpty)
              ? Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          splashFactory: NoSplash.splashFactory,
                          tabs: [
                            Tab(text: "Popular"),
                            Tab(text: "Recent"),
                            Tab(text: "Profile"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 20),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: const [
                                        Thread(),
                                        Gaps.v16,
                                        Divider(
                                          height: 0,
                                          thickness: 1,
                                        ),
                                        Gaps.v16,
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Container(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 20),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: const [
                                        Thread(),
                                        Gaps.v16,
                                        Divider(
                                          height: 0,
                                          thickness: 1,
                                        ),
                                        Gaps.v16,
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Container(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: userList.when(
                                  data: (users) => ListView.separated(
                                    itemCount: users.length,
                                    separatorBuilder: (context, index) =>
                                        const Padding(
                                      padding:
                                          EdgeInsets.only(left: 70, right: 10),
                                      child: Divider(height: 0, thickness: 1),
                                    ),
                                    itemBuilder: (context, index) {
                                      return SearchUser(user: users[index]);
                                    },
                                  ),
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (error, stackTrace) =>
                                      Center(child: Text('Error: $error')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
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
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Text('Error: $error')),
                  ),
                ),
        ],
      ),
    );
  }
}
