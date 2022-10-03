import 'package:block_stake_ui/wallet/connect_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class WalletController extends GetxController {
  final connectWalletResponse = {}.obs;

  String get uri => connectWalletResponse['uri'] as String;
  SessionStatus get sessionStatus =>
      connectWalletResponse['sessionStatus'] as SessionStatus;

  WalletConnect? get connector =>
      connectWalletResponse['provider'] as WalletConnect?;

  String get walletAddress => sessionStatus.accounts[0];

  bool get isWalletConnected {
    if (connector != null && connector!.connected) return true;
    return false;
  }

  connectWallet(BuildContext context) async {
    var response = await connect(context);
    connectWalletResponse.value = response;
  }

  //experimental
  disconnectWallet() async {
    await disconnect();
  }
}
