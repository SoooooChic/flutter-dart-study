import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import 'widgets/nav_tab.dart';
import 'widgets/post_dummy.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final ScrollController _scrollController = ScrollController();

  int _selectedIndex = 0;
  bool _showTitle = true;

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (!_showTitle) return;
      setState(() {
        _showTitle = false;
      });
    } else {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    }
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: FaIcon(
            FontAwesomeIcons.threads,
            size: Sizes.size40,
          ),
        ),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: PostDummy(),
              ),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const Scaffold(body: Center(child: Text('SEARCH'))),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const Scaffold(body: Center(child: Text('NEW POST'))),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const Scaffold(body: Center(child: Text('HEART'))),
          ),
          Offstage(
            offstage: _selectedIndex != 5,
            child: const Scaffold(body: Center(child: Text('PROFILE'))),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => _onTap(1),
              ),
              NavTab(
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.penToSquare,
                onTap: () => _onTap(3),
              ),
              NavTab(
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.heart,
                onTap: () => _onTap(4),
              ),
              NavTab(
                isSelected: _selectedIndex == 5,
                icon: FontAwesomeIcons.user,
                onTap: () => _onTap(5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
