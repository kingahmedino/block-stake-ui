// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable
import 'package:beamer/beamer.dart';
import 'package:block_stake_ui/controllers/balances-controller.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/models/Transaction.dart';
import 'package:block_stake_ui/ui/common/wallet.dart';
import 'package:block_stake_ui/wallet/wallet_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class BalancesPage extends StatelessWidget {
  BalancesPage({Key? key}) : super(key: key);

  BalancesController balancesController = Get.find<BalancesController>();
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
                      SizedBox(
                        height: 64.0,
                      ),
                      Text('Pending rewards:'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetX<BalancesController>(
                            builder: ((controller) {
                              return Text(
                                controller.rewards.isEmpty
                                    ? '0'
                                    : controller.formattedRewards,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      fontSize: 48.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                              );
                            }),
                          ),
                          Text(
                            ' BRW',
                            style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                      fontSize: 48.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Beamer.of(context)
                                  .beamToNamed('/balances/deposit');
                            },
                            child: Row(
                              children: [
                                Text('Deposit'),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14.0,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Beamer.of(context).beamToNamed('/balances/claim');
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Claim',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.system_update_tv_rounded,
                                  size: 14.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(Icons.receipt_long_rounded),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Transactions',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      GetX<BalancesController>(
                        builder: (controller) {
                          if (controller.getTransactions.isEmpty) {
                            return Center(
                              heightFactor: 15.0,
                              child: Text('No transaction'),
                            );
                          }
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.getTransactions.length,
                            itemBuilder: (context, index) {
                              Transaction transaction =
                                  controller.getTransactions[index];
                              return Card(
                                child: Container(
                                  padding: EdgeInsets.all(
                                    15.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transaction.type.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.copyWith(
                                                  color: transaction.color(),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            truncateString(
                                                transaction.stakerAdress,
                                                10,
                                                4),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            transaction.amount,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(transaction.block.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
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
