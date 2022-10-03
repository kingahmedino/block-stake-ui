// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/ui/common/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class StakingPage extends StatelessWidget {
  StakingPage({Key? key}) : super(key: key);

  WalletController walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetX<WalletController>(
                    builder: ((controller) {
                      return randomAvatar(
                        controller.isWalletConnected
                            ? controller.walletAddress
                            : '0',
                        height: 56,
                        width: 56,
                      );
                    }),
                  ),
                  Wallet(),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Stake page',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
