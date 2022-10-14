// ignore_for_file: file_names

import 'package:block_stake_ui/controllers/contact-calls-controller.dart';
import 'package:block_stake_ui/controllers/utils.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/models/Transaction.dart';
import 'package:get/get.dart';

class BalancesController extends GetxController {
  final ContractCallsController contractCallsController =
      Get.find<ContractCallsController>();
  final WalletController walletController = Get.find<WalletController>();

  final _transactions = <Transaction>[].obs;
  List<Transaction> get getTransactions => _transactions.value;

  String get rewards => contractCallsController.rewards;
  String get formattedRewards {
    return getValueFromWeiToHumanReadable(contractCallsController.rewards);
  }

  @override
  void onInit() {
    super.onInit();
    final walletEvent = Get.find<WalletController>()
        .connectWalletResponse
        .stream
        .listen((event) {
      //do everything need after wallet is connected
      getRewards();

      //subscribe to event
      subscribeToAllContractEvents();
    });
  }

  getRewards() async {
    if (walletController.isWalletConnected) {
      await contractCallsController.checkRewards();
    }
  }

  subscribeToAllContractEvents() async {
    if (walletController.isWalletConnected) {
      //subscribe to deposit event
      await contractCallsController.subscribeToEvent("Deposit", (decodedEvent) {
        print(decodedEvent);
        _transactions.add(
          Transaction(
              decodedEvent[0].toString(),
              "${getValueFromWeiToHumanReadable(decodedEvent[1])} BST",
              decodedEvent[2].toString(),
              TransactionType.Deposit),
        );
      });
      //subscribe to Claim rewards event
      await contractCallsController.subscribeToEvent("ClaimRewards",
          (decodedEvent) {
        _transactions.add(
          Transaction(
              decodedEvent[0].toString(),
              "${getValueFromWeiToHumanReadable(decodedEvent[1])} BRW",
              decodedEvent[2].toString(),
              TransactionType.ClaimRewards),
        );
      });
      //subscribe to Withdrawal events
      await contractCallsController.subscribeToEvent("Withdrawal",
          (decodedEvent) {
        _transactions.add(
          Transaction(
              decodedEvent[0].toString(),
              "${getValueFromWeiToHumanReadable(decodedEvent[1])} BST",
              decodedEvent[2].toString(),
              TransactionType.Withdrawal),
        );
      });
    }
  }
}
