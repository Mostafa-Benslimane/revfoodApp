// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:revfood/Location.dart';
import 'package:revfood/Login.dart';
import 'package:revfood/signUp.dart';

class SignOrLog extends StatefulWidget {
  const SignOrLog({super.key});
  @override
  State<StatefulWidget> createState() => _SignOrLogState();
}

class _SignOrLogState extends State<SignOrLog> {
  @override
  // ignore: dead_code
  Widget build(Object context) {
    return Scaffold(
      body: Column(
        children: [
          //Head has Wave..Script..Skip
          Stack(
            children: [
              ClipPath(
                //Wave
                clipper: WaveClipper(),
                child: Container(
                  color: const Color.fromARGB(232, 178, 34, 34),
                  height: 500,
                ),
              ),
              Container(
                //Skip
                width: 80,
                margin: const EdgeInsets.only(top: 69, left: 355),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      this.context,
                      MaterialPageRoute(builder: (context) => const Location()),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(232, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              Container(
                width: 370,
                margin: const EdgeInsets.only(top: 80, left: 20),
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  Welcome',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'poppins',
                            height: 6),
                      ),
                      Text(
                        'Are You Intrested In Sharing Your Opinions And Thoughts With The Cummunity?',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: 'poppins'),
                      ),
                      Text(
                        'Then You Must Join Us!',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'poppins'),
                      ),
                    ]),
              )
            ],
          ),

          //Body From TextField To Revfood Script
          Container(
            //Body

            width: 400,
            margin: const EdgeInsets.only(left: 12, top: 50),
            child: Column(
              children: [
                //Buttons
                Container(
                  //SignUp Button
                  margin: const EdgeInsets.only(top: 15, bottom: 35),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          this.context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(270, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: const Color(0xffb22222)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 40),
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          )
                        ],
                      )),
                ),
                ElevatedButton(
                    //Login Button
                    onPressed: () {
                      Navigator.push(
                        this.context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        fixedSize: const Size(270, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 252, 248, 248)),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 57),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 150),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )
                      ],
                    )),
                //RevFoodScript
                Container(
                  //RevFoodScript
                  padding: const EdgeInsets.only(top: 50),
                  child: const Text(
                    'RevFood',
                    style: TextStyle(
                      color: Color(0xFFb22222),
                      fontSize: 40.0,
                      fontFamily: 'lol',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height - 120); //start path with this if you a
    var firstStart = Offset(size.width / 5, size.height - 30);
    var firstEnd = Offset(size.width / 2.25, size.height - 70.0);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 117);

    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(
        size.width, 0); //end with this path if you are making path.close()

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
