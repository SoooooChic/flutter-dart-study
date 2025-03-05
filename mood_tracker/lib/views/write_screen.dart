import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/widgets/heart_beat.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  static const String routeURL = '/write';
  static const String routeName = 'write';

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final TextEditingController _thredController = TextEditingController();

  String _mood = '';
  final List<String> _selectedImages = [];
  final List<String> emojis = [
    "😀", "😁", "😂", "🤣", "😍", // 😃 웃는 얼굴
    "🤔", "🤗", "🙂", "😉", "😌", // 🤔 감정 표현
    "😠", "😡", "😤", "😭", "😢", // 😡 화난 얼굴
    "🤒", "🤢", "🤮", "🤧", "🥴", // 🤢 아픈 얼굴
  ];

  String? _selectedEmoji; // ✅ 선택된 이모지 저장

  @override
  void initState() {
    super.initState();
    _thredController.addListener(() {
      setState(() {
        _mood = _thredController.text;
      });
    });
  }

  @override
  void dispose() {
    _thredController.dispose();
    super.dispose();
  }

  Future<void> _onThreadWrite() async {
    if (_mood.isNotEmpty) {
      // List<File> imageFiles =
      //     _selectedImages.map((path) => File(path)).toList();
      // await ref
      //     .read(threadProvider.notifier)
      //     .writeThread(_thread, imageFiles, context);

      if (mounted) {
        context.go('/');
        Navigator.pop(context);
      }
    }
  }

  void _onTabPaperClip() async {
    // final List<String>? imagePaths = await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const CameraScreen(),
    //   ),
    // );

    // if (imagePaths != null && imagePaths.isNotEmpty) {
    //   _selectedImages.addAll(imagePaths);
    //   setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final isLoading = ref.watch(threadProvider).isLoading;
    final isLoading = false;

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
            // mainAxisAlignment: MainAxisAlignment.center,
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
                          controller: _thredController,
                          minLines: 3,
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
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                          itemCount: emojis.length,
                          itemBuilder: (context, index) {
                            String emoji = emojis[index];
                            bool isSelected = _selectedEmoji == emoji;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedEmoji = isSelected ? null : emoji;
                                });
                              },
                              child: Container(
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
                                child: Center(
                                  child: Text(
                                    emojis[index],
                                    style: const TextStyle(fontSize: 38),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Gaps.v10,
                        if (_selectedImages.isNotEmpty)
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 200,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _selectedImages.length,
                                    separatorBuilder:
                                        (context, index) =>
                                            const SizedBox(width: Sizes.size8),
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              Sizes.size16,
                                            ),
                                            child: Image.file(
                                              File(_selectedImages[index]),
                                              height: 200,
                                              // fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedImages.removeAt(
                                                    index,
                                                  );
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        IconButton(
                          onPressed: () => _onTabPaperClip(),
                          icon: Icon(FontAwesomeIcons.paperclip),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                width: size.width - 32,
                child: BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: isLoading ? () {} : _onThreadWrite,
                        child:
                            isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                  'Post',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _thredController.text.isEmpty
                                            ? Colors.blue[100]
                                            : Colors.blue,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
