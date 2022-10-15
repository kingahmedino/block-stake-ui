import 'dart:async';

import 'package:block_stake_ui/backend/constants.dart';
import 'package:block_stake_ui/wallet/connect_wallet.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

class ContractCallsController extends GetxController {
  final error = ''.obs;

  final _getSummaryResponse = [].obs;
  List<dynamic> get summary => _getSummaryResponse;

  final _checkRewardsResponse = [].obs;
  String get rewards {
    if (_checkRewardsResponse.isNotEmpty) {
      return _checkRewardsResponse[0].toString();
    }
    return '';
  }

  final _getStakerResponse = [].obs;
  List<dynamic> get stakerDetails => _getStakerResponse;

  @override
  void onInit() {
    super.onInit();
    //get user rewards, staker info and staking summary every 5 minutes.
    Timer.periodic(const Duration(minutes: 5), (Timer t) {
      checkRewards();
      getStaker();
      getSummary();
    });
  }

  Web3Client get _ethereumClient => Web3Client(RPC_URL, Client());
  EthereumWalletConnectProvider get _provider =>
      EthereumWalletConnectProvider(connector);
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
        .then((value) => {_checkRewardsResponse.value = value})
        .catchError((error) {});
  }

  getSummary() async {
    final contract = await _loadContract();
    final getSummaryFunction = contract.function('getSummary');
    _ethereumClient
        .call(contract: contract, function: getSummaryFunction, params: [])
        .then((value) => {_getSummaryResponse.value = value})
        .catchError((err) {
          error.value = err.printError();
        });
  }

  getStaker() async {
    final contract = await _loadContract();
    final getStakerFunction = contract.function('stakers');
    _ethereumClient
        .call(contract: contract, function: getStakerFunction, params: [
          EthereumAddress.fromHex(_provider.connector.session.accounts[0])
        ])
        .then((value) => {_getStakerResponse.value = value})
        .catchError((error) {});
  }

  approve(String uri) async {
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

  deposit(String uri, int amount) async {
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
              EtherAmount.fromUnitAndValue(EtherUnit.ether, amount).getInWei
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

  claimRewards(String uri) async {
    //load contract
    final contract = await _loadContract();
    final claimRewardsFunction = contract.function('claimRewards');
    //launch metamask
    launchUrlString(uri, mode: LaunchMode.externalApplication);
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

  subscribeToEvent(String eventName,
      Function(List<dynamic> decodedEvent) eventCallback) async {
    final contract = await _loadContract();
    final Event = contract.event(eventName);
    final subscription = _ethereumClient
        .events(FilterOptions.events(contract: contract, event: Event))
        .take(5)
        .listen((event) {
      final decoded = Event.decodeResults(event.topics!, event.data!);

      eventCallback(decoded);
    });
  }
}
