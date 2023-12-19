# test_5_webview

Flutter project with a WebView embedded within.

- Provides "go back", "go forward", "reload" functionality thanks to NavigationController
- Blacklists some sites thanks to NavigationDelegate & NavigationDecision
- Uses PopupMenuButton / PopupMenuItem
- Evaluates JS code using WebViewController
  - runJavaScript
  - runJavaScriptReturningResult

    This way, app runs arbitrary JS code in the device.
