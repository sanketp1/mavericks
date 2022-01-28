import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
        0xe50050ac,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'About Us',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              child: Expanded(
                  child: ListView.builder(
                      itemCount: 20,
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
                                padding: const EdgeInsets.only(top: 20,left: 20,bottom: 20),
                                child: CircleAvatar(radius: 50,backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/sanket-patil.png'),
                                ),
                              ),
                              
                              Container(
                                
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30,left: 10),
                                      child: Text(
                                        'Patil Sanket Atmaram',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 23,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                      Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Text(
                                        'T.E. (E&tc Engg.)',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                    ),
                                      Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'App development & Embedded Engg.',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
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
                      }))),
        ],
      )),
    );
  }
}
