import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions { navigationDelegate }

class Menu extends StatelessWidget {
  final WebViewController controller;

  const Menu({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: _MenuOptions.navigationDelegate,
            child: Text('Navigate to YouTube')),
      ],
      onSelected: (val) async {
        if (val != _MenuOptions.navigationDelegate) return;
        await controller.loadRequest(Uri.parse('https://youtube.com'));
      },
    );
  }
}
