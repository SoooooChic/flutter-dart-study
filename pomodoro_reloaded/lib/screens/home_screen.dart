import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 시작 값, 반복 횟수, 증가 값
  static const startValue = 5;
  static const repeatCount = 5;
  static const difference = 5;
  List<int> minuteConfing = List.generate(
    repeatCount,
    (index) => startValue + (index * difference),
  );
  // List<int> minuteConfing = [5, 10, 15, 25, 30];
  int standardTime = startValue + (difference * 2);
  int totalSeconds = (startValue + (difference * 2)) * 60;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer? timer;
  static const pomodoroRound = 3;
  static const pomodoroGoal = 2;
  int goal = 0;
  bool isBreak = false;
  int breakTime = 7;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isRunning = false;
        totalSeconds = standardTime * 60;
        totalPomodoros += 1;
        if (totalPomodoros == pomodoroRound) {
          totalPomodoros = 0;
          goal += 1;

          if (goal > pomodoroGoal) {
            goal = 0;
          }
        }
      });
      timer.cancel();
      breakTimeStart();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void breakTimeStart() {
    timer = Timer.periodic(
      //Duration(seconds: 1),
      Duration(microseconds: 1),
      onTickBreakTime,
    );
    setState(() {
      isBreak = true;
      totalSeconds = breakTime * 60;
    });
  }

  void onTickBreakTime(Timer timer) {
    if (totalSeconds == 0) {
      isBreak = false;
      totalSeconds = standardTime * 60;
      setState(() {});
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      //Duration(seconds: 1),
      Duration(microseconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
      isBreak = false;
    });
  }

  void onPausePressed() {
    if (timer != null) {
      timer?.cancel();
    }

    setState(() {
      isRunning = false;
      isBreak = false;
    });
  }

  void onResetPressed() {
    if (!isRunning) {
      totalSeconds = standardTime * 60;
      isRunning = false;
      isBreak = false;
      totalPomodoros = 0;
      goal = 0;
      onPausePressed();
    }
  }

  void setTime(int time) {
    if (!isRunning) {
      standardTime = time;
      totalSeconds = standardTime * 60;
      isRunning = false;
      isBreak = false;
      setState(() {});
    }
  }

  Widget format(int seconds) {
    var duration = Duration(seconds: seconds);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timeCard(duration.toString().split(".").first.substring(2, 4)),
          SizedBox(
            width: 5,
          ),
          Text(
            ":",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 70,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          timeCard(duration.toString().split(".").first.substring(5, 7)),
        ],
      ),
    );
  }

  Widget timeCard(String time) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          width: 130,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isBreak ? Colors.yellow[200] : Colors.white60,
          ),
        ),
        Container(
          width: 135,
          height: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isBreak ? Colors.yellow[400] : Colors.white70,
          ),
        ),
        Container(
          width: 140,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isBreak ? Colors.yellow[700] : Colors.white,
          ),
          child: Text(
            time,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget timeListDisplay() {
    List<Widget> returnValue = [];

    for (var time in minuteConfing) {
      returnValue.add(timeListIcon(time));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: returnValue,
    );
  }

  Widget timeListIcon(int time) {
    final double opacity =
        (100 - (time - standardTime * 60 / 60).abs() * 1.5) / 100;

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: InkWell(
        onTap: () {
          setTime(time);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Text(
            time.toString(),
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).scaffoldBackgroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 40,
        title: Text(
          'POMOTIMER',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.displayLarge!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: format(totalSeconds),
            ),
          ),
          Flexible(
            flex: 1,
            child: timeListDisplay(),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    iconSize: 120,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(
                      isRunning
                          ? Icons.pause_circle_filled_sharp
                          : Icons.play_circle,
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    iconSize: 60,
                    onPressed: onResetPressed,
                    icon: Icon(Icons.restart_alt_outlined),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$totalPomodoros/$pomodoroRound',
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'ROUND',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '$goal/$pomodoroGoal',
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'GOAL',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
