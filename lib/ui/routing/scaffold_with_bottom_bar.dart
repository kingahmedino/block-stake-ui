import 'package:beamer/beamer.dart';
import 'package:block_stake_ui/ui/routing/beamer_locations.dart';
import 'package:flutter/material.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key});

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // keep track of the currently selected index
  late int _currentIndex;

  // create two nested delegates
  final _routerDelegates = [
    BeamerDelegate(
      initialPath: '/balances',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/balances')) {
          return ALocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/staking',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/staking')) {
          return BLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
  ];

  // update the _currentIndex if necessary
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // use an IndexedStack to choose which child to show
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // use Beamer widgets as children
          Beamer(
            routerDelegate: _routerDelegates[0],
          ),
          Beamer(
            routerDelegate: _routerDelegates[1],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Balance'),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange), label: 'Stake'),
        ],
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
            _routerDelegates[_currentIndex].update(rebuild: false);
          }
        },
      ),
    );
  }
}
