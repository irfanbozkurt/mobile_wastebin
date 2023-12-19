import 'package:flutter/material.dart';
import 'package:test_4/bottom_bar_destinations.dart';

import 'models/lib.dart';
import 'widgets/email_list.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final _colorScheme = Theme.of(context).colorScheme;

  int selectedEmailIndex = 0;
  int selectedBottomBarDestIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.alphaBlend(
            _colorScheme.primary.withOpacity(0.14), _colorScheme.surface),
        child: EmailListView(
          selectedIndex: selectedEmailIndex,
          onSelected: (index) => setState(() => selectedEmailIndex = index),
          currentUser: widget.currentUser,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _colorScheme.tertiaryContainer,
        foregroundColor: _colorScheme.onTertiaryContainer,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        destinations: destinations
            .map((d) =>
                NavigationDestination(icon: Icon(d.icon), label: d.label))
            .toList(),
        selectedIndex: selectedBottomBarDestIndex,
        onDestinationSelected: (index) =>
            setState(() => selectedBottomBarDestIndex = index),
      ),
    );
  }
}
