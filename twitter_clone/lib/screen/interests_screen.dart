import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/form_button.dart';
// import '../widgets/interest_button.dart';

const Map<String, Map<String, List>> interests = {
  "part1": {
    "data": [
      "Fashion & beauty",
      "Outdoors",
      "Arts & culture",
      "Animation \n& comics",
      "Business \n& finance",
      "Food",
      "Travel",
      "Entertainment",
      "Music",
      "Gaming",
      "Fashion & beauty",
      "Outdoors",
      "Arts & culture",
      "Animation \n& comics",
      "Business \n& finance",
      "Food",
      "Travel",
      "Entertainment",
      "Music",
      "Gaming",
    ]
  },
  "part2": {
    "Music": [
      "Rap",
      "R&B & soul",
      "Grammy Awards",
      "Pop",
      "K-pop",
      "Music industry",
      "EDM",
      "Music news",
      "Hip hop",
      "Reggae",
    ],
    "Entertainment": [
      "Anime",
      "Movies & TV",
      "Harry Potter",
      "Marvel Universe",
      "Movie news",
      "Naruto",
      "Movies",
      "Grammy Awards",
      "Entertainment",
    ],
  },
};

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(data.length, (index) => false);
  }

  int _interestCount = 0;
  final List data = interests['part1']!['data']!;

  late List<bool> _isSelected;

  // //final
  // final
  // List<bool> _isSelected =
  //     List.generate(interests['part1']!['data']!.length, (index) => false);

  void _onTap(int index) {
    if (_interestCount == 3 && !_isSelected[index] == true) return;
    _isSelected[index] = !_isSelected[index];
    _interestCount += (_isSelected[index] == true) ? 1 : -1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          //controller: _scrollController,
          child: SingleChildScrollView(
            // controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gaps.v28,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: Sizes.size20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.blueAccent,
                    size: Sizes.size28,
                  ),
                  Gaps.v24,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What do you want to see on Twitter?",
                          style: TextStyle(
                            fontSize: Sizes.size24,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Gaps.v10,
                        Text(
                          'Select at least 3 interests to personalize your\nTwitter experience. They will be visible on\nyour profile.',
                          style: TextStyle(
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v20,
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  Container(
                    alignment: Alignment.center,
                    child: Wrap(
                      direction: Axis.horizontal, // 가로 방향
                      alignment: WrapAlignment.start, // 가로 정렬
                      // 세로 간격
                      runSpacing: 10,
                      // 가로 간격
                      spacing: 10,
                      children: [
                        for (int i = 0; i < data.length; i++)
                          GestureDetector(
                            onTap: () => {_onTap(i)},
                            child: AnimatedContainer(
                              width: 155,
                              height: 70,
                              duration: Duration(microseconds: 300),
                              padding: EdgeInsets.only(
                                left: Sizes.size10,
                                bottom: Sizes.size5,
                                top: Sizes.size5,
                                right: Sizes.size5,
                              ),
                              decoration: BoxDecoration(
                                color: _isSelected[i]
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(
                                  Sizes.size12,
                                ),
                                border: Border.all(
                                  color: Colors.black.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[i],
                                        style: TextStyle(
                                          fontSize: Sizes.size14,
                                          fontWeight: FontWeight.bold,
                                          color: _isSelected[i]
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: _isSelected[i]
                                        ? Align(
                                            alignment: Alignment.topRight,
                                            child: FaIcon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                              size: Sizes.size20,
                                            ),
                                          )
                                        : Gaps.v10,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // for (int i = 0; i < data.length; i++)
                        //     // print("Index: $i, Value: ${data[i]}");
                        //     InterestButton(
                        //       interest: data[i],
                        //       onTap: () {
                        //         // 외부에서 상태를 변경
                        //         // _controllers[index].value = !_controllers[index].value;
                        //         setState(() {
                        //           _isSelected[i] = !_isSelected[i];
                        //           _cnt += (_isSelected[i]) ? 1 : -1;
                        //         }); // 선택된 개수 업데이트
                        //       },
                        //     ),
                        //
                        // for (var interest in interests['part1']!['data']!)
                        //   InterestButton(
                        //     interest: interest,
                        //     onTap: () {
                        //       // 외부에서 상태를 변경
                        //       // _controllers[index].value = !_controllers[index].value;
                        //       setState(() {
                        //         _isSelected[] = !_isSelected;
                        //         _cnt += (_isSelected) ? 1 : -1;
                        //       }); // 선택된 개수 업데이트
                        //     },
                        //   ),
                      ],
                    ),
                  ),
                  Gaps.v28,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 80,
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150,
              child: Text(
                _interestCount == 3
                    ? 'Great work'
                    : '$_interestCount of 3 selected',
              ),
            ),
            SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () {}, // interest part two
                child: FormButton(
                  disabled: _interestCount == 3 ? true : false,
                  buttonSize: 0.5,
                  buttonText: 'Next',
                  blueColor: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
