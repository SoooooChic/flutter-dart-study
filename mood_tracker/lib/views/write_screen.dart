import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/view_model/mood_view_model.dart';
import 'package:mood_tracker/widgets/auth_button.dart';
import 'package:mood_tracker/widgets/heart_beat.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  static const String routeURL = '/write';
  static const String routeName = 'write';

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final TextEditingController _moodTextController = TextEditingController();

  String _mood = '';

  Map<String, String> emotions = {
    "happy": "😊",
    "love": "😍",
    "laugh": "😂",
    "sad": "😢",
    "angry": "😡",
    "shocked": "😱",
    "thinking": "🤔",
    "pleading": "🥺",
  };

  String _feel = '';

  String _emoji = '';

  @override
  void initState() {
    super.initState();
    _moodTextController.addListener(() {
      setState(() {
        _mood = _moodTextController.text;
      });
    });
  }

  @override
  void dispose() {
    _moodTextController.dispose();
    super.dispose();
  }

  Future<void> _onMoodWrite() async {
    if (_mood.isNotEmpty && _emoji.isNotEmpty) {
      await ref
          .read(moodProvider.notifier)
          .writeMood(_feel, _emoji, _mood, context);
      if (mounted) {
        context.go('/');
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 100,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              HeartBeat(size: 20.0),
              Gaps.h10,
              const Text(
                "MY MOOD",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
            vertical: Sizes.size10,
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How do you feel?',
                          style: TextStyle(fontSize: Sizes.size16),
                        ),
                        Gaps.v10,
                        TextField(
                          controller: _moodTextController,
                          minLines: 5,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            hintText: "Write it down here...",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                            ),
                          ),
                        ),
                        Gaps.v10,
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                          itemCount: emotions.length,
                          itemBuilder: (context, index) {
                            String label = emotions.keys.elementAt(index);
                            String emoji = emotions.values.elementAt(index);
                            bool isSelected = _emoji == emoji;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _feel = isSelected ? '' : label;
                                  _emoji = isSelected ? '' : emoji;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border:
                                      isSelected
                                          ? Border.all(
                                            color: Colors.blue,
                                            width: 3,
                                          )
                                          : null,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimatedScale(
                                      scale: isSelected ? 1.3 : 1.0,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                      child: Text(
                                        emoji,
                                        style: const TextStyle(fontSize: 38),
                                      ),
                                    ),
                                    Text(
                                      label.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Gaps.v10,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 12,
            left: 20,
            right: 20,
          ),
          child: AuthButton(
            text: 'Post',
            onTap: _onMoodWrite,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
