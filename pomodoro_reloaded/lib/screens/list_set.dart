/*import 'package:flutter/material.dart';

class HighlightedList extends StatefulWidget {
  const HighlightedList({super.key});

  @override
  _HighlightedListState createState() => _HighlightedListState();
}

class _HighlightedListState extends State<HighlightedList> {
  int _selectedIndex = 0; // Default selected index (list starts from 5)
  final List<int> _items =
      List.generate(12, (index) => (index + 1) * 5); // 5 ~ 60

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final distanceFromCenter = (index - _selectedIndex).abs();

              // Scale and opacity decrease as the item moves away from the center
              final scale = 1.0 - (0.2 * distanceFromCenter).clamp(0.0, 0.8);
              final opacity = 1.0 - (0.3 * distanceFromCenter).clamp(0.0, 0.6);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_items[index]}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
*/
