import 'package:block_stake_ui/controllers/contact-calls-controller.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:get/get.dart';

class DepositController extends GetxController {
  final ContractCallsController contractCallsController =
      Get.find<ContractCallsController>();
  final WalletController walletController = Get.find<WalletController>();

  final depositValue = ''.obs;

  int get getDepositValue {
    if (depositValue.value.isEmpty) {
      return 0;
    }
    return int.parse(depositValue.value);
  }

  deposit() {
    if (walletController.isWalletConnected && getDepositValue > 0) {
      contractCallsController.deposit(walletController.uri, getDepositValue);
    }
  }
}
