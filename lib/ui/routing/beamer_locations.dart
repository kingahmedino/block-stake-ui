// ignore_for_file: prefer_const_constructors

import 'package:beamer/beamer.dart';
import 'package:block_stake_ui/ui/balances_page.dart';
import 'package:block_stake_ui/ui/staking-page.dart';
import 'package:flutter/material.dart';

class ALocation extends BeamLocation<BeamState> {
  ALocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
            key: ValueKey('/balances'),
            title: 'Balances',
            type: BeamPageType.noTransition,
            child: BalancesPage()),
        // if (state.uri.pathSegments.length == 2)
        //   BeamPage(
        //     key: ValueKey('/balances/deposit'),
        //     title: 'Deposit',
        //     child: DepositPage(),
        //   ),
      ];
}

class BLocation extends BeamLocation<BeamState> {
  BLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
            key: ValueKey('/staking'),
            title: 'Stake',
            type: BeamPageType.noTransition,
            child: StakingPage()),
        // if (state.uri.pathSegments.length == 2)
        //   const BeamPage(
        //     key: ValueKey('/balances/deposit'),
        //     title: 'Details A',
        //     child: DetailsScreen(label: 'A'),
        //   ),
      ];
}
