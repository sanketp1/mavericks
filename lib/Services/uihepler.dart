import 'package:flutter/material.dart';

class UiHelper {
  bool trigger;

  UiHelper({required this.trigger});

  showprogress(BuildContext context) {
    return trigger
        ? showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        child: CircularProgressIndicator(
                          color: Colors.yellow,
                          strokeWidth: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Text(
                          'Please wait...',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
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
