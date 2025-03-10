import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/view_models/thread_view_model.dart';
import 'package:threads_clone/widgets/go_to_top_button.dart';
import 'package:threads_clone/widgets/threads.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showModal = false;

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showModal) return;
      setState(() {
        _showModal = true;
      });
    } else {
      setState(() {
        _showModal = false;
      });
    }
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
    final threadListAsync = ref.watch(threadProvider);

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 80,
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: FaIcon(
                  FontAwesomeIcons.threads,
                  size: Sizes.size40,
                ),
              ),
              threadListAsync.when(
                data: (threads) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final thread = threads[index];
                      return Column(
                        children: [
                          Threads(threads: thread),
                          Gaps.v16,
                          const Divider(height: 0, thickness: 1),
                          Gaps.v16,
                        ],
                      );
                    },
                    childCount: threads.length,
                  ),
                ),
                loading: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stackTrace) => SliverToBoxAdapter(
                  child: Center(child: Text("Error loading Threads data")),
                ),
              ),
            ],
          ),
          if (_showModal)
            SafeArea(
              child: GestureDetector(
                onTap: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: const GoToTopButton(),
              ),
            )
        ],
      ),
    );
  }
}
