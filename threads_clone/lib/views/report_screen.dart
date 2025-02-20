import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

final List<String> reportText = [
  "I just don't like it",
  "It's unlawful content under NetzDG",
  "It's spam",
  "Hate speech or symbols",
  "Nudity or sexual activity",
  "Scam, Fraud or Spam",
  "Misinformation",
  "Other",
];

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  void _onNextStep(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.6,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          toolbarHeight: 20,
          elevation: 1,
          // backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text(
            "Report",
            style: TextStyle(
              fontSize: Sizes.size18,
              fontWeight: FontWeight.bold,
              // color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size10,
            bottom: Sizes.size20,
            left: Sizes.size16,
            right: Sizes.size16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(height: 1, color: Colors.grey),
              Gaps.v16,
              const Text(
                'Why are you reporting this thread?',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              const Text(
                'Your report is anonymous, except if you\'re reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don\'t wait.',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.grey,
                ),
              ),
              Gaps.v16,
              const Divider(height: 1, color: Colors.grey),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  itemCount: reportText.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      reportText[index],
                      style: const TextStyle(fontSize: Sizes.size16),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size18,
                      color: Colors.grey.shade500,
                    ),
                    onTap: () => _onNextStep(context),
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
