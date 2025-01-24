import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';

class InterestButton extends StatefulWidget {
  const InterestButton(
      {super.key, required this.interest, required this.onTap});

  final Function onTap;
  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  final bool _isSelected = false;
  // int _cnt = 0;
  // void _onTap() {
  //   setState(() {
  //     _isSelected = !_isSelected;
  //     _cnt += (_isSelected) ? 1 : -1 ;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap(context),
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
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.interest,
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.bold,
                    color: _isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            Expanded(
              child: _isSelected
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
    );
  }
}
