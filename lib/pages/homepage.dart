import 'dart:developer';

import 'dart:ui';
import 'package:mavericks/pages/test.dart';

import 'package:flutter/material.dart';
import 'package:mavericks/constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:mavericks/data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _drawerSlideController;

  @override
  void initState() {
    super.initState();

    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  bool _isDrawerOpen() {
    return _drawerSlideController.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _drawerSlideController.status == AnimationStatus.forward;
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void _toggleDrawer() {
    if (_isDrawerOpen() || _isDrawerOpening()) {
      _drawerSlideController.reverse();
    } else {
      _drawerSlideController.forward();
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: gradientEndColor,
      appBar: AppBar(
        leading: PopupMenuButton(
          offset: Offset(10,10),
          icon: Icon(Icons.menu),
              itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("First"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Second"),
                    value: 2,
                  )
                ]
              
            ),
        backgroundColor: gradientStartColor,
        elevation: 0.0,
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
                height: height * 0.6115,
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
                            SizedBox(height: height * (70 / height)),
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
                          right: 0,
                          bottom: 80,
                          child: Text(
                            sensorInfo[index].position.toString(),
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 180,
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
