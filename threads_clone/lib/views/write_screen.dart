import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/view_models/thread_vm.dart';
import 'package:threads_clone/views/camera_screen.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  static const String routeURL = '/write';
  static const String routeName = 'write';

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final TextEditingController _thredController = TextEditingController();
  // final FocusNode _focusNode = FocusNode();

  String _thread = '';
  final List<String> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _thredController.addListener(() {
      setState(() {
        _thread = _thredController.text;
      });
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _focusNode.requestFocus();
    // });
  }

  @override
  void dispose() {
    _thredController.dispose();
    // _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onThreadWrite() async {
    if (_thread.isNotEmpty) {
      //
      // Navigator.of(context).pop();
      //
      List<File> imageFiles =
          _selectedImages.map((path) => File(path)).toList();

      await ref
          .read(threadProvider.notifier)
          .writeThread(_thread, imageFiles, context);
    }
  }

  void _onTabPaperClip() async {
    final List<String>? imagePaths = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    );

    if (imagePaths != null && imagePaths.isNotEmpty) {
      _selectedImages.addAll(imagePaths);
      setState(() {});
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
          elevation: 1,
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
          title: const Text(
            "New thread",
            style: TextStyle(
              fontSize: Sizes.size24,
              fontWeight: FontWeight.bold,
            ),
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
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/150?img=10'),
                        radius: Sizes.size20,
                      ),
                      Gaps.v10,
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      Gaps.v10,
                      Opacity(
                        opacity: 0.7,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/150?img=10'),
                          radius: Sizes.size10,
                        ),
                      ),
                    ],
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'jane_mobbin',
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: Sizes.size44,
                          child: TextField(
                            controller: _thredController,
                            // focusNode: _focusNode,
                            minLines: null,
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              hintText: "Start a thread...",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size12,
                              ),
                            ),
                          ),
                        ),
                        Gaps.v20,
                        if (_selectedImages.isNotEmpty)
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 200,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _selectedImages.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: Sizes.size8),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Sizes.size16),
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
                                                  _selectedImages
                                                      .removeAt(index);
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
                      Text(
                        'Anyone can reply',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: _onThreadWrite,
                        child: Text(
                          'Post',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _thredController.text.isEmpty
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
