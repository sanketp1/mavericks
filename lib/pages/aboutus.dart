import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mavericks/Services/uihepler.dart';
import 'package:mavericks/constants.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientStartColor,
      appBar: AppBar(
        backgroundColor: gradientStartColor,
        title: Container(
            child: Text(
          'About Us',
          style: TextStyle(
              color: Colors.white, fontSize: 29, fontWeight: FontWeight.bold),
        )),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('members').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final data = snapshot.data!.docs.asMap();
              // snapshot.data!.docs.forEach((element) {
              //   data =   element.data()

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(
                          0xe50050ac,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(
                              0x33000000,
                            ),
                            offset: Offset(
                              1,
                              3,
                            ),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 9, bottom: 20),
                            child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('assets/sanket-patil.png')),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, left: 9),
                                  child: Text(
                                    data[index]!.data()['name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 5),
                                  child: Text(
                                    data[index]!.data()['class'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9),
                                  child: Text(
                                    data[index]!.data()['role'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
                strokeWidth: 2,
              ),
            );
          }
        },
      )),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mavericks/Services/uihepler.dart';

// class AboutUs extends StatelessWidget {
//   AboutUs({Key? key}) : super(key: key);

//  Stream<DocumentSnapshot<Map<String, dynamic>>> members =
//       FirebaseFirestore.instance.collection('members').doc().snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(
//         0xe50050ac,
//       ),
//       body: SafeArea(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(20),
//             child: Text(
//               'About Us',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 29,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           Container(
//               child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                   stream: FirebaseFirestore.instance.collection('members').doc().snapshots(),
//                   builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                    
//                    if(snapshot.connectionState == ConnectionState.active){
//                      if (snapshot.hasData) {
                       
//                       return Expanded(
//                           child: ListView.builder(
//                               itemCount:20,
//                               itemBuilder: (context, index) {
//                                 return Container(
//                                   margin: EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Color(
//                                       0xe50050ac,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Color(
//                                           0x33000000,
//                                         ),
//                                         offset: Offset(
//                                           1,
//                                           3,
//                                         ),
//                                         blurRadius: 2,
//                                       ),
//                                     ],
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 20, left: 9, bottom: 20),
//                                         child: CircleAvatar(
//                                           radius: 50,
//                                           backgroundColor: Colors.white,
//                                           backgroundImage: AssetImage(
//                                               'assets/sanket-patil.png'),
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 30, left: 9),
//                                               child: Text(
//                                                 'Patil Sanket Atmaram',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 23,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 9,
//                                                       vertical: 5),
//                                               child: Text(
//                                                 'T.E. (E&tc Engg.)',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w400,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 9),
//                                               child: Text(
//                                                 'App development & Embedded Sys. Engg.',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               }));
//                     }
//                       else{
//                       return Center(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           padding: EdgeInsets.all(40),
//                           margin: EdgeInsets.all(18),
//                           child: Center(
//                               child: Text(
//                             'An error ocuured, kindly contact with Administrator',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500),
//                           )),
//                         ),
//                       );
//                     }



//                    } else {
//                       return UiHelper(trigger: true).showprogress(context);
//                     }
//                   })),
//         ],
//       )),
//     );
//   }
// }
