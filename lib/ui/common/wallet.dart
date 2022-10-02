// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable

import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/wallet/wallet_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class Wallet extends StatelessWidget {
  Wallet({Key? key}) : super(key: key);

  var walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        walletController.connectWallet(context);
      },
      child: GetX<WalletController>(
        builder: (controller) {
          return Text(controller.isWalletConnected
              ? truncateString(controller.walletAddress, 4, 2)
              : 'Connect wallet');
        },
      ),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.all(
              Colors.black,
            ),
          ),
    );
  }
}
