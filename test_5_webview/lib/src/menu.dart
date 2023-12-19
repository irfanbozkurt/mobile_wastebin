import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const getUserIpJSCode = '''
var req = new XMLHttpRequest();
req.open('GET', "https://api.ipify.org/?format=json");
req.onload = () => SnackBar.postMessage((req.status == 200) ? JSON.parse(req.responseText).ip : req.status);
req.send();
''';

enum _MenuOptions { navigationDelegate, userAgent, javaScriptChannel }

class Menu extends StatefulWidget {
  final WebViewController controller;

  const Menu({super.key, required this.controller});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: _MenuOptions.navigationDelegate,
            child: Text('Navigate to YouTube')),
        const PopupMenuItem(
            value: _MenuOptions.userAgent, child: Text('Show user-agent')),
        const PopupMenuItem(
            value: _MenuOptions.javaScriptChannel, child: Text('Run JS')),
      ],
      onSelected: (val) async {
        switch (val) {
          case _MenuOptions.navigationDelegate:
            await widget.controller
                .loadRequest(Uri.parse('https://youtube.com'));
            break;
          case _MenuOptions.userAgent:
            if (!mounted) return;
            final userAgent = await widget.controller
                .runJavaScriptReturningResult('navigator.userAgent');
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('$userAgent')));
            break;
          case _MenuOptions.javaScriptChannel:
            await widget.controller.runJavaScript(getUserIpJSCode);
            break;
        }
      },
    );
  }
}
