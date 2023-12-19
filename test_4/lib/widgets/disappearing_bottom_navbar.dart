import 'package:flutter/material.dart';

import '../bottom_bar_destinations.dart';

class DisappearingBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  const DisappearingBottomNavbar(
      {super.key, this.selectedIndex = 0, this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      destinations: destinations
          .map((d) => NavigationDestination(icon: Icon(d.icon), label: d.label))
          .toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
