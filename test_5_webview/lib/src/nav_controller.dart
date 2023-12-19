import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavController extends StatelessWidget {
  final WebViewController controller;

  const NavController({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async => (await controller.canGoBack())
              ? await controller.goBack()
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item'))),
        ),
        IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () async => (await controller.canGoBack())
                ? await controller.goBack()
                : ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No forward history item')))),
        IconButton(
            icon: const Icon(Icons.replay), onPressed: controller.reload),
      ],
    );
  }
}
