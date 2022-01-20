import 'dart:developer';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mavericks/constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:mavericks/data.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: gradientEndColor,
      drawer: Drawer(
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 20),
                child: Text(
                  "Hi",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 32, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Sanket Patil',
                      style: TextStyle(
                        fontFamily: 'BalsamiqSans',
                        fontSize: 30,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    // DropdownButton(
                    //   items: [
                    //     DropdownMenuItem(
                    //       child: Text(
                    //         'Solar System',
                    //         style: TextStyle(
                    //           fontFamily: 'Avenir',
                    //           fontSize: 24,
                    //           color: const Color(0x7cdbf1ff),
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //         textAlign: TextAlign.left,
                    //       ),
                    //     ),
                    //   ],
                    //   onChanged: (value) {},
                    //   icon: Padding(
                    //     padding: const EdgeInsets.only(left: 16.0),
                    //     child: Image.asset('assets/drop_down_icon.png'),
                    //   ),
                    //   underline: SizedBox(),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontFamily: 'BalsamiqSans',
                    fontSize: 25,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 500,
                padding: const EdgeInsets.only(left: 32),
                child: Swiper(
                  itemCount: sensorInfo.length,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder:
                        DotSwiperPaginationBuilder(activeSize: 20, space: 8),
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 70),
                            Container(
                              width: width * 0.83333,
                              height: height * 0.355,
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 100),
                                      Text(
                                        sensorInfo[index].name.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: 22,
                                          color: const Color(0xff47455f),
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        sensorInfo[index].data.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: 26,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Hero(
                          tag: int.parse(sensorInfo[index].position.toString()),
                          child: Image.asset(
                            sensorInfo[index].icon.toString(),
                            width: 150,
                            height: 200,
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 130,
                          child: Text(
                            sensorInfo[index].position.toString(),
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 200,
                              color: primaryTextColor.withOpacity(0.08),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
