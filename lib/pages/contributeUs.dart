import 'package:flutter/material.dart';
import 'package:mavericks/constants.dart';

class ContributeUs extends StatelessWidget {
  const ContributeUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientStartColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '#Team_Mavericks',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            '''Giving is not just''',
            style: TextStyle(
              fontFamily: 'BalsamiqSans',
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          Text(
            '''about make a''',
            style: TextStyle(
              fontFamily: 'BalsamiqSans',
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          Text(
            '''donation it's about''',
            style: TextStyle(
              fontFamily: 'BalsamiqSans',
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          Text(
            ''' "making a difference." ''',
            style: TextStyle(
              fontFamily: 'BalsamiqSansBold',
              color: Colors.white,
              fontSize: 38,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, top: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                '... Kathy Calvin',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      )),
    );
  }
}
