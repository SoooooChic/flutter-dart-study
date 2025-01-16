import 'package:flutter/material.dart';

//https://github.com/devgony/flutter-study 여기서 코드 확인 가능

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
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 50,
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'MONDAY 16',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'TODAY',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color(0xffb22580),
                      size: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // 가로 스크롤 설정
                        child: Text(
                          '17 18 19 20',
                          style: TextStyle(
                            fontSize: 38,
                            color: Color(0xff8e8e8e),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xfffef754),
                    borderRadius: BorderRadius.circular(40),
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
                            height: 10,
                          ),
                          Text(
                            '11',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '30',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '|',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '12',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '20',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DESIGN',
                            style: TextStyle(fontSize: 52),
                          ),
                          Text(
                            'MEETING',
                            style: TextStyle(fontSize: 52, height: 0.2),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ALEX',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'HELENA',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'NANA',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff9c6bce),
                    borderRadius: BorderRadius.circular(40),
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
                            height: 10,
                          ),
                          Text(
                            '12',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '35',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '|',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '14',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '10',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DAILY',
                            style: TextStyle(fontSize: 52),
                          ),
                          Text(
                            'PROJECT',
                            style: TextStyle(fontSize: 52, height: 0.2),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ME',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'RHCHARD',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'CIRY',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '+4',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffbcee4b),
                    borderRadius: BorderRadius.circular(40),
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
                            height: 10,
                          ),
                          Text(
                            '15',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '00',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '|',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '16',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '30',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WEEKLY',
                            style: TextStyle(fontSize: 52),
                          ),
                          Text(
                            'PLANNING',
                            style: TextStyle(fontSize: 52, height: 0.2),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'DEN',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'NANA',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'MARK',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffb0aa28),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
