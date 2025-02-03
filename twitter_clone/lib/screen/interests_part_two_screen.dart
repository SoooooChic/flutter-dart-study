import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/form_button.dart';

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

class InterestsPartTwoScreen extends StatefulWidget {
  const InterestsPartTwoScreen({super.key});

  @override
  State<InterestsPartTwoScreen> createState() => _InterestsPartTwoScreenState();
}

class _InterestsPartTwoScreenState extends State<InterestsPartTwoScreen> {
  @override
  void initState() {
    super.initState();
    _isSelected = {
      for (var item in data.entries)
        item.key: List.filled(item.value.length, false),
    };
  }

  int _interestCount = 0;
  final Map<String, List> data = interests['part2']!;

  late Map<String, List<bool>> _isSelected;

  void _onTap(String key, int index) {
    _isSelected[key]![index] = !_isSelected[key]![index];
    _interestCount += (_isSelected[key]![index] == true) ? 1 : -1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      'Interests are used to personalize your\nexperience and will be visible on your profile.',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var interest in data.entries) ...[
                    Text(
                      interest.key,
                      style: TextStyle(
                          fontSize: Sizes.size16, fontWeight: FontWeight.w700),
                    ),
                    Gaps.v10,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 160,
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 15,
                          runSpacing: 5,
                          children: [
                            for (var item in interest.value.asMap().entries)
                              GestureDetector(
                                onTap: () => {_onTap(interest.key, item.key)},
                                child: AnimatedContainer(
                                  duration: Duration(microseconds: 300),
                                  padding: EdgeInsets.symmetric(
                                    vertical: Sizes.size10,
                                    horizontal: Sizes.size16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _isSelected[interest.key]![item.key]
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      Sizes.size20,
                                    ),
                                    border: Border.all(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    item.value,
                                    style: TextStyle(
                                      fontSize: Sizes.size12,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          _isSelected[interest.key]![item.key]
                                              ? Colors.white
                                              : Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.v20,
                  ],
                ],
              ),
              Gaps.v28,
            ],
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
            ),
            SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () {}, // next
                child: FormButton(
                  disabled: _interestCount >= 3 ? true : false,
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
