import 'package:flutter/material.dart';
//import 'widgets/schedule.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff1f1f1f),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 100,
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 50,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'MONDAY 16',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'TODAY',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color(0xffb22580),
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '17  18  19  20',
                      style: TextStyle(
                        fontSize: 64,
                        color: Color(0xff8e8e8e),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //Schedule(),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfffef754),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '11',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            '30',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '|',
                          ),
                          Text(
                            '12',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            '20',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DESIGN',
                            style: TextStyle(
                              fontSize: 94,
                            ),
                          ),
                          Text(
                            'MEETING',
                            style: TextStyle(
                              fontSize: 94,
                              height: 0.2,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          SizedBox(
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ALEX',
                                  style: TextStyle(
                                    color: Color(0xffb0aa28),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'HELENA',
                                  style: TextStyle(
                                    color: Color(0xffb0aa28),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'NANA',
                                  style: TextStyle(
                                    color: Color(0xffb0aa28),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff9c6bce),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '12',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            '35',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '|',
                          ),
                          Text(
                            '14',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DAILY',
                            style: TextStyle(
                              fontSize: 94,
                            ),
                          ),
                          Text(
                            'PROJECT',
                            style: TextStyle(
                              fontSize: 94,
                              height: 0.2,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          SizedBox(
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ME',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'HELENA',
                                  style: TextStyle(
                                    color: Color(0xff65438c),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'HELENA',
                                  style: TextStyle(
                                    color: Color(0xff65438c),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'NANA',
                                  style: TextStyle(
                                    color: Color(0xff65438c),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffbcee4b),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '15',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            '00',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '|',
                          ),
                          Text(
                            '16',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            '30',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WEEKLY',
                            style: TextStyle(
                              fontSize: 94,
                            ),
                          ),
                          Text(
                            'PLANNING',
                            style: TextStyle(
                              fontSize: 94,
                              height: 0.2,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          SizedBox(
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'DEN',
                                  style: TextStyle(
                                    color: Color(0xff86ac30),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'NANA',
                                  style: TextStyle(
                                    color: Color(0xff86ac30),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'MARK',
                                  style: TextStyle(
                                    color: Color(0xff86ac30),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
