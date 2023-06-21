import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: const Text(
              'Community homie',
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
