import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3dart/src/crypto/secp256k1.dart';
import 'package:web3dart/web3dart.dart';

var connector = WalletConnect(
  bridge: 'https://bridge.walletconnect.org',
  clientMeta: const PeerMeta(
    name: 'Block Stake',
    description:
        'A staking dApp that takes in an upgradeable token as stake asset and issues rewards in a different token.',
    url: 'https://walletconnect.org',
    icons: [
      'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
    ],
  ),
);

Future<dynamic> loginUsingMetamask(BuildContext context) async {
  if (!connector.connected) {
    String _uri = "";
    try {
      var session = await connector.connect(
          chainId: 5,
          onDisplayUri: (uri) async {
            _uri = uri;
            await launchUrlString(uri, mode: LaunchMode.externalApplication);
          });
      return {'uri': _uri, 'sessionStatus': session, 'provider': connector};
    } catch (error) {
      print(error);
      return null;
    }
  }
  return;
}

Future<dynamic> signMessageWithMetamask(BuildContext context, String message,
    String uri, SessionStatus sessionStatus) async {
  if (connector.connected) {
    try {
      EthereumWalletConnectProvider provider =
          EthereumWalletConnectProvider(connector);
      launchUrlString(uri, mode: LaunchMode.externalApplication);
      var signature = await provider.personalSign(
          message: message, address: sessionStatus.accounts[0], password: "");

      return signature;
    } catch (error) {
      print(error);
    }
  }
}

class EthereumTransactionSender extends CustomTransactionSender {
  EthereumTransactionSender({required this.provider});

  final EthereumWalletConnectProvider provider;

  @override
  Future<EthereumAddress> extractAddress() {
    throw UnimplementedError();
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    final hash = await provider.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    return hash;
  }
}
