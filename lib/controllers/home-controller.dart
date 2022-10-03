// ignore_for_file: file_names

import 'package:block_stake_ui/controllers/contact-calls-controller.dart';
import 'package:block_stake_ui/controllers/utils.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ContractCallsController contractCallsController =
      Get.find<ContractCallsController>();
  final WalletController walletController = Get.find<WalletController>();

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
    });
  }

  getRewards() async {
    if (walletController.isWalletConnected) {
      await contractCallsController.checkRewards();
    }
  }
}
