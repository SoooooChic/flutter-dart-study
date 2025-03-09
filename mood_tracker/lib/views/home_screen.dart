import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/util.dart';
import 'package:mood_tracker/view_model/mood_view_model.dart';
import 'package:mood_tracker/widgets/heart_beat.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  void _showDeleteDialog(String uid, int createdAt) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete note'),
            content: const Text('Are you sure you want to do this?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(moodProvider.notifier)
                      .deleteMood(uid, createdAt, context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moodList = ref.watch(moodProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeartBeat(size: 20.0),
            Gaps.h10,
            Text("Moods Calendar"),
            Gaps.h10,
            HeartBeat(size: 20.0),
          ],
        ),
      ),
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
                ref.read(moodProvider.notifier).searchMoods(selectedDay);
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
              child: moodList.when(
                data:
                    (moods) => ListView.separated(
                      itemCount: moods.length,
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemBuilder: (context, index) {
                        final mood = moods[index];
                        return GestureDetector(
                          onLongPress:
                              () => _showDeleteDialog(mood.uid, mood.createdAt),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Sizes.size10),
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: Sizes.size6,
                            ),
                            child: ListTile(
                              leading: Text(
                                mood.emoji,
                                style: TextStyle(fontSize: Sizes.size36),
                              ),
                              title: Text(mood.feel),
                              subtitle: Text(mood.comment),
                              trailing: Text(timeAgo(mood.createdAt)),
                            ),
                          ),
                        );
                      },
                    ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
