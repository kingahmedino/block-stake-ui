// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:block_stake_ui/controllers/balances-controller.dart';
import 'package:block_stake_ui/controllers/stake-info-controller.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/ui/common/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class StakingPage extends StatelessWidget {
  StakingPage({Key? key}) : super(key: key);

  BalancesController balancesController = Get.find<BalancesController>();
  WalletController walletController = Get.find<WalletController>();
  StakeInfoController stakeInfoController = Get.find<StakeInfoController>();

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
                      Image.asset(
                          width: 220.0,
                          height: 220.0,
                          'assets/images/Coins.gif'),
                      SizedBox(height: 25.0),
                      RichText(
                        text: TextSpan(
                          text: 'Stake',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Block Stake (BST)',
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          text: 'Earn',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Block Reward (BRW)',
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('BRW Earned'),
                                SizedBox(height: 5.0),
                                GetX<BalancesController>(
                                  builder: ((controller) {
                                    return Text(
                                      controller.rewards.isEmpty
                                          ? '0'
                                          : controller.formattedRewards,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20.0,
                                          ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Collect'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BST Staked',
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                SizedBox(height: 5.0),
                                GetX<StakeInfoController>(
                                  builder: ((controller) {
                                    return Text(
                                      controller.stakerBST.isEmpty
                                          ? '0'
                                          : controller.stakerBST,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[850],
                                  ),
                                  child: Icon(
                                    Icons.remove_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.0,
                                ),
                                Container(
                                  padding: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[850],
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Stake info',
                          style:
                              Theme.of(context).textTheme.headline3?.copyWith(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(24.0),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Rewards per block:'),
                                  SizedBox(height: 5.0),
                                  Text(
                                    '1 BWR',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 20.0,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(24.0),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total BST staked:'),
                                  SizedBox(height: 5.0),
                                  GetX<StakeInfoController>(
                                    builder: ((controller) {
                                      return Text(
                                        controller.totalStake.isEmpty
                                            ? '0'
                                            : controller.totalStake,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(24.0),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Acc. reward/share:',
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  SizedBox(height: 5.0),
                                  GetX<StakeInfoController>(
                                    builder: ((controller) {
                                      return Text(
                                        controller.accRewardPerShare.isEmpty
                                            ? '0'
                                            : controller.accRewardPerShare,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(24.0),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Last reward block:'),
                                  SizedBox(height: 5.0),
                                  GetX<StakeInfoController>(
                                    builder: ((controller) {
                                      return Text(
                                        controller.lastRewardBlock.isEmpty
                                            ? '0'
                                            : controller.lastRewardBlock,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
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
