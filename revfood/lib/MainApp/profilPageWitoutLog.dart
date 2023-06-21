import 'package:flutter/material.dart';

class ProfilScreenWithoutLog extends StatefulWidget {
  const ProfilScreenWithoutLog({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilScreenWithoutLogState();
}

class _ProfilScreenWithoutLogState extends State<ProfilScreenWithoutLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: const Text(
              'Profil homie i didnt login',
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
