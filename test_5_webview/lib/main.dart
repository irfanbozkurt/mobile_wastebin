import 'package:flutter/material.dart';
import 'package:test_5_webview/src/webview_stack.dart';

void main() {
  runApp(MaterialApp(theme: ThemeData(useMaterial3: true), home: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WebView'),
        ),
        body: const WebViewStack());
  }
}
