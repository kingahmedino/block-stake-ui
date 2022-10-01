import 'package:block_stake_ui/backend/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  final BLOCK_STAKING_ABI = await rootBundle.loadString("assets/json/abi.json");
  final contract = DeployedContract(
      ContractAbi.fromJson(BLOCK_STAKING_ABI, BLOCK_STAKING_CONTRACT_NAME),
      EthereumAddress.fromHex(BLOCK_STAKING_CONTRACT_ADDRESS));

  return contract;
}

Future<List<dynamic>> checkRewards() async {
  final httpClient = Client();
  final ethClient = Web3Client(RPC_URL, httpClient);
  final contract = await loadContract();
  final checkRewardsFunction = contract.function('checkRewards');
  final result = await ethClient.call(
      contract: contract,
      function: checkRewardsFunction,
      params: [EthereumAddress.fromHex(SAMPLE_STAKER_ADDRESS)]);

  return result;
}

Future<List<dynamic>> getSummary() async {
  final httpClient = Client();
  final ethClient = Web3Client(RPC_URL, httpClient);
  final contract = await loadContract();
  final getSummaryFunction = contract.function('getSummary');
  final result = await ethClient
      .call(contract: contract, function: getSummaryFunction, params: []);

  return result;
}
