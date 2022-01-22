



import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseDatabase.instance.ref('mavericks').onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text("No data found..."));
            if (snapshot.hasError)
              return Center(
                child: Text('An error occured...'),
              );
            final data = '' ;
            return ListTile(
              leading: Text(data.toString()),
            );
          }),
    );
  }
}
