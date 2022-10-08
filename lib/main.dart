// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:beamer/beamer.dart';
import 'package:block_stake_ui/controllers/contact-calls-controller.dart';
import 'package:block_stake_ui/controllers/balances-controller.dart';
import 'package:block_stake_ui/controllers/stake-info-controller.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/theme/constants.dart';
import 'package:block_stake_ui/ui/routing/scaffold_with_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          Get.isDarkMode ? darkBGColor : Colors.white, // navigation bar color
      systemNavigationBarIconBrightness:
          Get.isDarkMode ? Brightness.light : Brightness.dark,
      statusBarColor:
          Get.isDarkMode ? darkBGColor : Colors.white, // status bar color
      statusBarIconBrightness:
          Get.isDarkMode ? Brightness.light : Brightness.dark));
  runApp(MyApp());
  //init controllers
  Get.put(WalletController());
  Get.put(ContractCallsController());
  Get.put(BalancesController());
  Get.put(StakeInfoController());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final routerDelegate = BeamerDelegate(
    initialPath: '/',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => const ScaffoldWithBottomNavBar(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Block Stake',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
    );
  }
}
