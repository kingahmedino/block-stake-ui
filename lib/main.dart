// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:block_stake_ui/controllers/contact-calls-controller.dart';
import 'package:block_stake_ui/controllers/home-controller.dart';
import 'package:block_stake_ui/controllers/wallet-controller.dart';
import 'package:block_stake_ui/theme/constants.dart';
import 'package:block_stake_ui/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          Get.isDarkMode ? darkBGColor : Colors.white, // navigation bar color
      statusBarColor:
          Get.isDarkMode ? darkBGColor : Colors.white, // status bar color
      statusBarIconBrightness:
          Get.isDarkMode ? Brightness.light : Brightness.dark));
  runApp(const MyApp());
  //init controllers
  Get.put(WalletController());
  Get.put(ContractCallsController());
  Get.put(HomeController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Block Stake',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
      },
    );
  }
}
