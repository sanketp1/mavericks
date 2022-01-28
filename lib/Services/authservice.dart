import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PageDecider {
  static decide() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool home = await prefs.setBool('Home', true);
  }
}
