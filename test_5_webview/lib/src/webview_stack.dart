import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const blockedWebsites = {
  ...[
    'youtube.com',
    'pornhub.com',
    'xhamster.com',
  ]
};

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key, required this.controller});

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) => setState(() => loadingPercentage = 0),
        onProgress: (progress) => setState(() => loadingPercentage = progress),
        onPageFinished: (url) => setState(() => loadingPercentage = 100),
        onNavigationRequest: (nav) {
          for (final blockedWebsite in blockedWebsites) {
            if (!Uri.parse(nav.url).host.contains(blockedWebsite)) continue;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('$blockedWebsite is blocked'),
            ));
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: widget.controller),
        if (loadingPercentage < 100)
          LinearProgressIndicator(value: loadingPercentage / 100.0)
      ],
    );
  }
}
