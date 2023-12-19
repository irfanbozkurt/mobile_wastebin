import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.alphaBlend(
            _colorScheme.primary.withOpacity(0.14), _colorScheme.surface),
        child: EmailListView(
          currentUser: widget.currentUser,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _colorScheme.tertiaryContainer,
        foregroundColor: _colorScheme.onTertiaryContainer,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
