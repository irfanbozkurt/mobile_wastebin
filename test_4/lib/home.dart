import 'package:flutter/material.dart';

import 'models/lib.dart';

import 'widgets/email_list.dart';
import 'widgets/disappearing_bottom_navbar.dart';
import 'widgets/disappearing_nav_rail.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
      _colorScheme.primary.withOpacity(0.14), _colorScheme.surface);

  // Manage selected emails
  int selectedEmailIndex = 0;

  // Manage navbars
  int selectedNavDestIndex = 0;
  bool wideScreen = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    wideScreen = MediaQuery.of(context).size.width > 400;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (wideScreen)
            DisappearingNavRail(
              selectedIndex: selectedNavDestIndex,
              backgroundColor: _backgroundColor,
              onDestinationSelected: (index) {
                setState(() {
                  selectedNavDestIndex = index;
                });
              },
            ),
          Expanded(
            child: Container(
              color: _backgroundColor,
              child: EmailListView(
                selectedIndex: selectedNavDestIndex,
                onSelected: (index) {
                  setState(() {
                    selectedNavDestIndex = index;
                  });
                },
                currentUser: widget.currentUser,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: wideScreen
          ? null
          : FloatingActionButton(
              backgroundColor: _colorScheme.tertiaryContainer,
              foregroundColor: _colorScheme.onTertiaryContainer,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
      bottomNavigationBar: wideScreen
          ? null
          : DisappearingBottomNavbar(
              selectedIndex: selectedNavDestIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedNavDestIndex = index;
                });
              },
            ),
    );
  }
}
