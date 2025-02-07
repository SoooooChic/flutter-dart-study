import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/sizes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = 'search';
  static const String routeURL = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  final List<int> followerCounts = List.generate(20, (index) => index * 10);

  void _onSearchChanged(String value) {
    print("Searching form $value");
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: Text(
            'Search',
            style: TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30), // 검색창 높이 설정
            child: Padding(
              padding: EdgeInsets.all(8.0), // 여백 추가
              child: CupertinoSearchTextField(
                controller: _textEditingController,
                onChanged: _onSearchChanged,
                onSubmitted: _onSearchSubmitted,
              ),
            ),
          ),
        ),
        body: ListView.separated(
          itemCount: followerCounts.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              left: 70,
              right: 10,
            ),
            child: Divider(
              height: 0,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.users,
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text(
                'User Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  text: "User Name",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  children: [
                    TextSpan(
                      text: "\n\n ${followerCounts[index]}K followers",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                  minimumSize: const Size(0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Follow",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
