import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const getUserIpJSCode = '''
var req = new XMLHttpRequest();
req.open('GET', "https://api.ipify.org/?format=json");
req.onload = () => SnackBar.postMessage((req.status == 200) ? JSON.parse(req.responseText).ip : req.status);
req.send();
''';

enum _MenuOptions {
  navigationDelegate,
  userAgent,
  javaScriptChannel,
  listCookies,
  clearCookies,
  addCookie,
  setCookie,
  removeCookie
}

class Menu extends StatefulWidget {
  final WebViewController controller;

  const Menu({super.key, required this.controller});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final cookieManager = WebViewCookieManager();

  Future<void> _onListCookies(WebViewController controller) async {
    if (!mounted) return;
    final String cookies = await controller
        .runJavaScriptReturningResult('document.cookie') as String;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(cookies.isEmpty ? 'No cookies' : cookies)));
  }

  Future<void> _onClearCookies() async {
    final hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There were no cookies to clear.';
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _onAddCookie(WebViewController controller) async {
    await controller.runJavaScript('''var date = new Date();
  date.setTime(date.getTime()+(30*24*60*60*1000));
  document.cookie = "FirstName=John; expires=" + date.toGMTString();''');
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Custom cookie added.'),
      ),
    );
  }

  Future<void> _onSetCookie(WebViewController controller) async {
    await cookieManager.setCookie(
      const WebViewCookie(name: 'foo', value: 'bar', domain: 'flutter.dev'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Custom cookie is set.'),
      ),
    );
  }

  Future<void> _onRemoveCookie(WebViewController controller) async {
    await controller.runJavaScript(
        'document.cookie="FirstName=John; expires=Thu, 01 Jan 1970 00:00:00 UTC" ');
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Custom cookie removed.'),
      ),
    );
  }

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
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.clearCookies,
          child: Text('Clear cookies'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.listCookies,
          child: Text('List cookies'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.addCookie,
          child: Text('Add cookie'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.setCookie,
          child: Text('Set cookie'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.removeCookie,
          child: Text('Remove cookie'),
        ),
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
          case _MenuOptions.clearCookies:
            await _onClearCookies();
            break;
          case _MenuOptions.listCookies:
            await _onListCookies(widget.controller);
            break;
          case _MenuOptions.addCookie:
            await _onAddCookie(widget.controller);
            break;
          case _MenuOptions.setCookie:
            await _onSetCookie(widget.controller);
            break;
          case _MenuOptions.removeCookie:
            await _onRemoveCookie(widget.controller);
            break;
        }
      },
    );
  }
}
