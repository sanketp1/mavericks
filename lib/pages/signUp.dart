import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mavericks/Models/UserModel.dart';
import 'package:mavericks/Services/uihepler.dart';
import 'package:mavericks/pages/homepage.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone_no = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  Future onSignUp(String fname, String lname, String email, String phone_no,
      String password, String cpassword, BuildContext context) async {
    UserModel userModel =
        UserModel(fname: fname, lname: lname, email: email, phone_no: phone_no);
    if (_formkey.currentState!.validate()) {
      if (password == cpassword) {
        UserModel userModel = UserModel(
            fname: fname, lname: lname, email: email, phone_no: phone_no);
        FirebaseAuth auth = FirebaseAuth.instance;
        UserCredential? userCredential;

        try {
          userCredential = await auth.createUserWithEmailAndPassword(
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
                  title: Row(
                    children: [
                      Icon(
                        Icons.error,
                        size: 35,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Error",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  content: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      ex.code,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                );
              });
        }
        if (userCredential != null) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          await firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(userModel.toMap())
              .whenComplete(() {
            showDialog(
                context: context,
                builder: (context) {
              
                  return Dialog(
                    child: Container(
                      color: Colors.black,
                      height: 200,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          Text(
                            'Successfully created',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                              userModel: userModel,
                                            )));
                              },
                              child: Text('ok'))
                        ],
                      ),
                    ),
                  );
                });
          });
        }
      }
    } else {
      setState(() {
        _onclick = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Error",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              content: Text(
                'Some fields are empty\nKindly fill it.\n try again...',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          });
    }
  }

  bool _onclick = false;
  bool visbility = true;
  bool c_visbility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, bottom: 20),
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: fname,
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
                              Icons.person,
                              color: Colors.white,
                            ),
                            hintText: "First Name",
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
                          controller: lname,
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
                              Icons.person,
                              color: Colors.white,
                            ),
                            hintText: "Last Name",
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
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
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
                          keyboardType: TextInputType.phone,
                          controller: phone_no,
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
                              Icons.mobile_friendly,
                              color: Colors.white,
                            ),
                            hintText: "Mobile Number",
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
                          controller: password,
                          obscureText: visbility,
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
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (visbility) {
                                  setState(() {
                                    visbility = false;
                                  });
                                } else {
                                  setState(() {
                                    visbility = true;
                                  });
                                }
                              },
                              icon: visbility
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                            ),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: c_visbility,
                          controller: cpassword,
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
                              Icons.password,
                              color: Colors.white,
                            ),
                            hintText: "Confirm Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (c_visbility) {
                                  setState(() {
                                    c_visbility = false;
                                  });
                                } else {
                                  setState(() {
                                    c_visbility = true;
                                  });
                                }
                              },
                              icon: c_visbility
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                            ),
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
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _onclick = true;
                            });

                            final _fname = fname.text.trim();
                            final _lname = lname.text.trim();
                            final _email = email.text.trim();
                            final _phone_no = phone_no.text.trim();
                            final _password = password.text.trim();
                            final _cpassword = cpassword.text.trim();

                            onSignUp(_fname, _lname, _email, _phone_no,
                                _password, _cpassword, context);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            height: 50,
                            width: _onclick ? 50 : 180,
                            decoration: BoxDecoration(
                                color: _onclick ? Colors.green : Colors.green,
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
                                            'Sign up',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ))),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already sign up?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 18),
                                  ))
                            ],
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
      ),
    );
  }
}
