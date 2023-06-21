import 'package:flutter/material.dart';
import 'package:revfood/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // Center the title widget within the app bar
        title: Container(
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Location()),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        child: const Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Mostaganem',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'poppins',
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.only(left: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: const Image(
              image: AssetImage('assets/images/Revfood_logo_red.png'),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(left: 10),
            color: const Color.fromARGB(164, 255, 193, 7),
            height: 170,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recommended Restaurant :',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.blueAccent,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
