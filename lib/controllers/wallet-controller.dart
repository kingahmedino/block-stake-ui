import 'package:block_stake_ui/wallet/connect_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class WalletController extends GetxController {
  final _connectWalletResponse = {}.obs;

  String get uri => _connectWalletResponse['uri'] as String;
  SessionStatus get sessionStatus =>
      _connectWalletResponse['sessionStatus'] as SessionStatus;

  WalletConnect? get connector =>
      _connectWalletResponse['provider'] as WalletConnect?;

  String get walletAddress => sessionStatus.accounts[0];

  bool get isWalletConnected {
    if (connector != null && connector!.connected) return true;
    return false;
  }

  connectWallet(BuildContext context) async {
    var response = await connect(context);
    _connectWalletResponse.value = response;
  }

  //experimental
  disconnectWallet() async {
    await disconnect();
  }
}
