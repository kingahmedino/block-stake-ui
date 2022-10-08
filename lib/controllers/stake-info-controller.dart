import 'package:block_stake_ui/controllers/contact-calls-controller.dart';
import 'package:block_stake_ui/controllers/utils.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:get/get.dart';

class StakeInfoController extends GetxController {
  final ContractCallsController contractCallsController =
      Get.find<ContractCallsController>();
  final WalletController walletController = Get.find<WalletController>();

  String get totalStake {
    if (contractCallsController.summary.isNotEmpty) {
      return getValueFromWeiToHumanReadable(contractCallsController.summary[1]);
    }
    return "";
  }

  String get accRewardPerShare {
    if (contractCallsController.summary.isNotEmpty) {
      double div =
          contractCallsController.summary[2].toDouble() / 1000000000000;
      return div.toStringAsFixed(2);
    }
    return "";
  }

  String get lastRewardBlock {
    if (contractCallsController.summary.isNotEmpty) {
      return contractCallsController.summary[3].toString();
    }
    return "";
  }

  String get stakerBST {
    if (contractCallsController.stakerDetails.isNotEmpty) {
      return getValueFromWeiToHumanReadable(
          contractCallsController.stakerDetails[0]);
    }
    return "";
  }

  @override
  void onInit() {
    super.onInit();
    getSummary();
    final walletEvent = Get.find<WalletController>()
        .connectWalletResponse
        .stream
        .listen((event) {
      //do everything need after wallet is connected
      getStaker();
    });
  }

  getSummary() async {
    await contractCallsController.getSummary();
  }

  getStaker() async {
    if (walletController.isWalletConnected) {
      await contractCallsController.getStaker();
    }
  }
}
