import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/views/camera_screen.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  static const String routeURL = '/write';
  static const String routeName = 'write';

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _thredController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _thread = '';

  @override
  void initState() {
    super.initState();
    _thredController.addListener(() {
      setState(() {
        _thread = _thredController.text;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _thredController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onThreadWrite() {
    if (_thread.isNotEmpty) {
      Navigator.of(context).pop();
    }
  }

  void _onTabPaperClip() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    );
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
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
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
                  color: Colors.black,
                ),
              ),
            ),
          ),
          title: const Text(
            "New thread",
            style: TextStyle(
              fontSize: Sizes.size24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: Sizes.size44,
                          child: TextField(
                            controller: _thredController,
                            focusNode: _focusNode,
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
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size12,
                              ),
                            ),
                          ),
                        ),
                        Gaps.v20,
                        IconButton(
                          onPressed: () => _onTabPaperClip,
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
                  color: Colors.white,
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
