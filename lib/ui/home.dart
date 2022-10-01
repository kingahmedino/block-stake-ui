// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:block_stake_ui/theme/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '\$241,873',
              style: TextStyle(
                  fontFamily: 'GTWalsheimPro',
                  fontWeight: FontWeight.w900,
                  fontSize: 50.0),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  toggleMode();
                },
                child: Text('How'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
