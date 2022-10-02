// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:block_stake_ui/backend/constract-call-manager.dart';
import 'package:block_stake_ui/theme/constants.dart';
import 'package:block_stake_ui/wallet/connect_wallet.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic response = {'uri': '', 'sessionStatus': ''};
  late ContractCallsManager manager;

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
                  manager.checkRewards();
                  toggleMode();
                },
                child: Text('How'),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () async {
                  response = await loginUsingMetamask(context);
                  manager = ContractCallsManager(
                      uri: response['uri'],
                      walletConnect: response['provider']);
                },
                child: Text('Connect wallet'),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  signMessageWithMetamask(
                      context,
                      'Hello there, kindly sign this message',
                      response['uri'],
                      response['sessionStatus']);
                },
                child: Text('Sign a message'),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  manager.claimRewards();
                },
                child: Text('Claim rewards'),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  manager.approve();
                },
                child: Text('Approve'),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  manager.deposit();
                },
                child: Text('Deposit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
