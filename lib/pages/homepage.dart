import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mavericks/Models/UserModel.dart';
import 'package:mavericks/constants.dart';
import 'package:mavericks/data.dart';
import 'package:mavericks/pages/aboutus.dart';
import 'package:mavericks/pages/contributeUs.dart';
import 'package:mavericks/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  UserModel? userModel;
  HomePage({Key? key, this.userModel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerSlideController;
  final database = FirebaseDatabase.instance.ref('mavericks');
  dynamic? dailySpecial;
  String? fuelLevel;
  String? batteryLevel;
  String? getLocation;
  String? temperature;
  String? depthDistance;

  @override
  void initState() {
    super.initState();
    _activateListener();

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

  void _activateListener() {
    dailySpecial = database.onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value as Map);

      final show = data;

      setState(() {
        fuelLevel = show['fuel'].toString() + "\t%";
        batteryLevel = show['battery'].toString() + "\t%";
        getLocation = show['getLocation'].toString();
        temperature = show['temperature'].toString() + "\t°C";
        depthDistance = show['depthDistance'].toString() + "\tCm";
      });
    });
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
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildContent(width, height),
          _buildDrawer(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: gradientStartColor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: AnimatedBuilder(
        animation: _drawerSlideController,
        builder: (context, child) {
          return IconButton(
            onPressed: _toggleDrawer,
            icon: _isDrawerOpen() || _isDrawerOpening()
                ? const Icon(
                    Icons.clear,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
          );
        },
      ),
    );
  }

  Widget _buildContent(double width, double height) {
    // Put page content here.

    return Container(
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
                    widget.userModel!.fname! + "\t" + widget.userModel!.lname!,
                    style: TextStyle(
                      fontFamily: 'BalsamiqSans',
                      fontSize: width * 0.07653,
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
                  fontSize: width * 0.06365,
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
                  builder: DotSwiperPaginationBuilder(activeSize: 20, space: 8),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 100),
                                    Text(
                                      sensorInfo[index].name.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Avenir',
                                        fontSize: width * 0.0561,
                                        color: const Color(0xff47455f),
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (index == 0)
                                      Text(
                                        getLocation ?? "updating...",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: width * 0.07142,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    if (index == 1)
                                      Text(
                                        batteryLevel ?? "updating...",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: width * 0.07142,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    if (index == 2)
                                      Text(
                                        fuelLevel ?? "updating...",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: width * 0.07142,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    if (index == 3)
                                      Text(
                                        temperature ?? "updating...",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: width * 0.07142,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    if (index == 4)
                                      Text(
                                        depthDistance ?? "updating...",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: width * 0.07142,
                                            fontWeight: FontWeight.w500),
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
                        right: width * 0.02546,
                        bottom: height * 0.11119,
                        child: Text(
                          sensorInfo[index].position.toString(),
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: width * 0.45833,
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
    );

    ;
  }

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: Offset(1.0 - _drawerSlideController.value, 0.0),
          child: _isDrawerClosed() ? const SizedBox() : Menu(),
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    'About us',
    'Contribute us',
    'Logout',
  ];
  static List<Icon> _icon = [
    Icon(
      Icons.person,
      color: Colors.white,
    ),
    Icon(
      Icons.money,
      color: Colors.white,
    ),
    Icon(
      Icons.logout,
      color: Colors.white,
    )
  ];

  static const _initialDelayTime = Duration(milliseconds: 100);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  late Interval _buttonInterval;

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuTitles.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }

    final buttonStartTime =
        Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
    final buttonEndTime = buttonStartTime + _buttonTime;
    _buttonInterval = Interval(
      buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
      buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gradientStartColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildFlutterLogo(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildFlutterLogo() {
    return Positioned(
      right: -225,
      bottom: -50,
      child: Opacity(
          opacity: 0.2,
          child: Image.asset(
            'assets/icons/logobg.png',
            color: Colors.white,
          )),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ..._buildListItems(),
        const Spacer(),
      ],
    );
  }

  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (var i = 0; i < _menuTitles.length; ++i) {
      listItems.add(
        AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.easeOut.transform(
              _itemSlideIntervals[i].transform(_staggeredController.value),
            );
            final opacity = animationPercent;
            final slideDistance = (1.0 - animationPercent) * 150;

            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(slideDistance, 0),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: InkWell(
              onTap: () async {
                if (i == 0) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs()));
                }
                if (i == 1) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContributeUs()));
                }
                if (i == 2) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut();

                  var uid = prefs.remove('uid');
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
              child: ListTile(
                leading: _icon[i],
                title: Text(
                  _menuTitles[i],
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return listItems;
  }
}
