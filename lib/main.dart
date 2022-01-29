import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mavericks/Models/UserModel.dart';
import 'package:mavericks/pages/homepage.dart';
import 'package:mavericks/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uid');

  UserModel? userModel;
  if (prefs.containsKey('uid')) {
    final firestore = FirebaseFirestore.instance;
    final user = await firestore.collection('users').doc(uid).get();

    userModel = UserModel.fromMap(user.data() as Map<String, dynamic>);
  }
  runApp(MaterialApp(
    home: uid == null
        ? const LoginPage()
        : HomePage(
            userModel: userModel,
          ),
  ));
}
