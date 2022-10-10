// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:beamer/beamer.dart';
import 'package:block_stake_ui/controllers/deposit-controller.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/ui/common/numeric_pad.dart';
import 'package:block_stake_ui/ui/common/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class DepositPage extends StatelessWidget {
  DepositPage({Key? key}) : super(key: key);

  DepositController depositController = Get.find<DepositController>();

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
                      SizedBox(
                        height: 64.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          GetX<DepositController>(
                            builder: ((controller) {
                              return Text(
                                controller.getDepositValue.toString(),
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            }),
                          ),
                          Text(
                            '.00',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      NumberPad(
                        onNumberTapped: (number) {
                          String value = depositController.depositValue.value;
                          if (number != -1) {
                            if (int.parse(value.isEmpty ? '0' : value) <=
                                1000) {
                              depositController.depositValue.value =
                                  value + number.toString();
                            }
                          } else {
                            if (value.isNotEmpty) {
                              depositController.depositValue.value =
                                  value.substring(0, value.length - 1);
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          depositController.deposit();
                        },
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                              minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, 50.0),
                              ),
                            ),
                        child: Text('Deposit'),
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
