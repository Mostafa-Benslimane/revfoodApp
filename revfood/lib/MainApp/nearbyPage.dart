import 'package:flutter/material.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: const Text(
              'Nearby homie',
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
