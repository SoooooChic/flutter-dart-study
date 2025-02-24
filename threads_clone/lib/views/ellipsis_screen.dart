import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/views/report_screen.dart';

class EllipsisScreen extends StatelessWidget {
  const EllipsisScreen({super.key});

  void _onReportTap(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) => ReportScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size28),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Sizes.size12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unfollow',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Divider(),
                      Text(
                        'Mute',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.v10,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Sizes.size12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hide',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {
                          _onReportTap(context);
                        },
                        child: Text(
                          'Report',
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
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
