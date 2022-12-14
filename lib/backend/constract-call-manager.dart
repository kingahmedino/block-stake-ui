import 'package:block_stake_ui/backend/constants.dart';
import 'package:block_stake_ui/wallet/connect_wallet.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

class ContractCallsManager {
  ContractCallsManager({required this.uri, required this.walletConnect});

  final String uri;
  final WalletConnect walletConnect;

  Web3Client get _ethereumClient => Web3Client(RPC_URL, Client());
  EthereumWalletConnectProvider get _provider =>
      EthereumWalletConnectProvider(walletConnect);
  EthereumTransactionSender get _credentials =>
      EthereumTransactionSender(provider: _provider);

  Future<DeployedContract> _loadContract(
      {String contractABIPath = "assets/json/abi.json",
      String contractAddress = BLOCK_STAKING_CONTRACT_ADDRESS}) async {
    final contractABI = await rootBundle.loadString(contractABIPath);
    final contract = DeployedContract(
        ContractAbi.fromJson(contractABI, contractAddress),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  checkRewards() async {
    final contract = await _loadContract();
    final checkRewardsFunction = contract.function('checkRewards');
    _ethereumClient
        .call(contract: contract, function: checkRewardsFunction, params: [
          EthereumAddress.fromHex(_provider.connector.session.accounts[0])
        ])
        .then((value) => {
              //update state in controller
            })
        .catchError((error) {});
  }

  getSummary() async {
    final contract = await _loadContract();
    final getSummaryFunction = contract.function('getSummary');
    _ethereumClient
        .call(contract: contract, function: getSummaryFunction, params: [])
        .then((value) => {
              //update state in controller
            })
        .catchError((error) {});
  }

  approve() async {
    //load contract
    final contract = await _loadContract(
        contractABIPath: "assets/json/block-stake-abi.json",
        contractAddress: BLOCK_STAKE_TOKEN_CONTRACT_ADDRESS);

    //get function
    final approveFunction = contract.function('approve');
    //launch metamask
    launchUrlString(uri, mode: LaunchMode.externalApplication);
    //send transaction
    _ethereumClient
        .sendTransaction(
          _credentials,
          Transaction.callContract(
            contract: contract,
            function: approveFunction,
            parameters: [
              EthereumAddress.fromHex(BLOCK_STAKING_CONTRACT_ADDRESS),
              EtherAmount.fromUnitAndValue(EtherUnit.ether, 100).getInWei
            ],
            from: EthereumAddress.fromHex(
              _provider.connector.session.accounts[0],
            ),
          ),
        )
        .then((value) => {
              //update state in controller
            })
        .catchError((error) {});
  }

  deposit() async {
    //load contract
    final contract = await _loadContract();
    final depositFunction = contract.function('deposit');
    //launch metamask
    launchUrlString(uri, mode: LaunchMode.externalApplication);
    //send transaction
    _ethereumClient
        .sendTransaction(
          _credentials,
          Transaction.callContract(
            contract: contract,
            function: depositFunction,
            parameters: [
              EtherAmount.fromUnitAndValue(EtherUnit.ether, 1).getInWei
            ],
            from: EthereumAddress.fromHex(
              _provider.connector.session.accounts[0],
            ),
          ),
        )
        .then((value) => {
              //update state in controller
            })
        .catchError((error) {});
  }

  claimRewards() async {
    //load contract
    final contract = await _loadContract();
    final claimRewardsFunction = contract.function('claimRewards');
    //send transaction
    _ethereumClient
        .sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: contract,
              function: claimRewardsFunction,
              parameters: [],
              from: EthereumAddress.fromHex(
                  _provider.connector.session.accounts[0])),
        )
        .then((value) => {
              //update state in controller
            })
        .catchError((error) {});
  }
}
