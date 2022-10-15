// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:beamer/beamer.dart';
import 'package:block_stake_ui/controllers/balances-controller.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/ui/common/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class ClaimPage extends StatelessWidget {
  ClaimPage({Key? key}) : super(key: key);

  BalancesController balancesController = Get.find<BalancesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Beamer.of(context).beamBack();
                          },
                          child: Icon(Icons.arrow_back_ios_new_rounded)),
                      SizedBox(width: 10.0),
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
                    ],
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
                      Image.asset(
                          width: 360.0,
                          height: 360.0,
                          'assets/images/claim_coins.gif'),
                      SizedBox(height: 25.0),
                      Text(
                        "Claim BRW",
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: Colors.black,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 15.0),
                      GetX<BalancesController>(
                        builder: ((controller) {
                          return RichText(
                            text: TextSpan(
                              text: 'You have earned ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${controller.rewards.isEmpty ? '0' : controller.formattedRewards} BRW',
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                ),
                                TextSpan(
                                  text:
                                      ' in rewards, you ${controller.rewards.isEmpty ? 'there are no rewards to claim.' : 'can now claim your rewards.'}',
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          );
                        }),
                      ),
                      SizedBox(height: 35.0),
                      ElevatedButton(
                        onPressed: () {
                          balancesController.claimRewards();
                        },
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                              minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, 50.0),
                              ),
                            ),
                        child: Text('Claim your rewards'),
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
