import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.now(),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
                CalendarFormat.week: 'Week',
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay =
                      focusedDay.isAfter(DateTime.now())
                          ? DateTime.now()
                          : focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Gaps.v40,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size10),
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    padding: EdgeInsets.symmetric(vertical: Sizes.size6),
                    child: ListTile(
                      leading: Text(
                        '😊',
                        style: TextStyle(fontSize: Sizes.size36),
                      ),
                      title: Text(
                        'asddfasdfasasdfasdfasdfasdfasd\nasdfasdfasdfasdf',
                      ),
                      subtitle: Text('$index hours ago'),
                      // trailing: FaIcon(
                      //   FontAwesomeIcons.trash,
                      //   size: Sizes.size12,
                      // ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
              ),
            ),
            if (_selectedDay != null)
              Text(
                "선택된 날짜: ${DateFormat('yyyy년 MM월 dd일').format(_selectedDay!)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
