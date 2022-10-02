// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:block_stake_ui/backend/constract-call-manager.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/wallet/connect_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic response = {'uri': '', 'sessionStatus': ''};
  late ContractCallsManager manager;
  var controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: ElevatedButton(
                onPressed: () async {
                  controller.connectWallet(context);
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
            GetX<WalletController>(
              builder: (controller) {
                return Text(controller.isWalletConnected
                    ? controller.walletAddress
                    : 'Empty');
              },
            ),
          ],
        ),
      ),
    );
  }
}
