import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mavericks/Models/UserModel.dart';
import 'package:mavericks/Services/authservice.dart';
import 'package:mavericks/Services/uihepler.dart';
import 'package:mavericks/pages/homepage.dart';
import 'package:mavericks/pages/signUp.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _onclick = false;
  bool wait = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  onLogin() {
    if (_formkey.currentState!.validate()) {
      final email = _email.text.trim();
      final password = _password.text.trim();
      onSignIn(email, password);
    } else {
      setState(() {
        setState(() {
          _onclick = false;
        });
      });
    }
  }

  onSignIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      setState(() {
        _onclick = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Error',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    ex.code,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            );
          });
    }
    if (userCredential != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('uid', userCredential.user!.uid);
      setState(() {
        _onclick = false;
      });
      final user = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      final userModel = UserModel.fromMap(user.data() as Map<String, dynamic>);

      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(userModel: userModel)));
    }
  }

  bool visible = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), fit: BoxFit.fill)),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 15),
                      child: Text(
                        "Welcome to Mavericks",
                        style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 16),
                      child: Text(
                        "You are above the sky....",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              "Today is our oppurtunity to build the tomorrow we want....",
                              textStyle: const TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: 'BalsamiqSansBold',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              speed: const Duration(milliseconds: 200),
                            ),
                          ],
                          totalRepeatCount: 4,
                          pause: const Duration(milliseconds: 1000),
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        )),
                  ],
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* Required";
                              } else
                                return null;
                            },
                            cursorColor: Colors.yellow,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            obscureText: visible,
                            controller: _password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* Required";
                              } else if (value.length < 6) {
                                return "Password should be atleast 6 characters";
                              } else if (value.length > 15) {
                                return "Password should not be greater than 15 characters";
                              } else
                                return null;
                            },
                            cursorColor: Colors.yellow,
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_rounded,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                              onPressed: () {
                                if (visible) {
                                  setState(() {
                                    visible = false;
                                  });
                                } else {
                                  setState(() {
                                    visible = true;
                                  });
                                }
                              },
                              icon: visible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                            ),

                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _onclick = true;
                                });

                                onLogin();
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1000),
                                height: 50,
                                width: _onclick ? 50 : 180,
                                decoration: BoxDecoration(
                                    color:
                                        _onclick ? Colors.green : Colors.yellow,
                                    borderRadius: _onclick
                                        ? BorderRadius.circular(25)
                                        : BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 9.0)
                                    ]),
                                child: Center(
                                    child: Container(
                                        child: _onclick
                                            ? Icon(
                                                Icons.done,
                                                color: Colors.white,
                                                size: 20,
                                              )
                                            : Text(
                                                'Login',
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateAccountPage()));
                            },
                            child: Container(
                              height: 50,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.person_add,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Create Account',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  progress(BuildContext context) {
    wait
        ? showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Dialog(
                  backgroundColor: Colors.black,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Please wait...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
        : null;
  }
}
