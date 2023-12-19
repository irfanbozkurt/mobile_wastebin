import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'src/webview_stack.dart';
import 'src/nav_controller.dart';

void main() {
  runApp(MaterialApp(theme: ThemeData(useMaterial3: true), home: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Init the WebViewController at the root, so that it
  // can be shared across child Widgets
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    controller.loadRequest(Uri.parse('https://atilim.edu.tr'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WebView'),
          actions: [NavController(controller: controller)],
        ),
        body: WebViewStack(
          controller: controller,
        ));
  }
}
