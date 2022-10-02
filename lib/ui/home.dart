// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:block_stake_ui/backend/constract-call-manager.dart';
import 'package:block_stake_ui/controllers/contact-calls-controller.dart';
import 'package:block_stake_ui/ui/common/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ContractCallsManager manager;
  ContractCallsController contractCallsController =
      Get.put(ContractCallsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wallet(),
            SizedBox(
              height: 20.0,
            ),
            GetX<ContractCallsController>(
              builder: (controller) {
                return Text(controller.summary.join(" "));
              },
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
                  contractCallsController.getSummary();
                },
                child: Text('Get Summary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
