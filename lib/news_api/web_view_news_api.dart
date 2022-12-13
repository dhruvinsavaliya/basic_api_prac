import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNewsApi extends StatelessWidget {
  const WebViewNewsApi({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: url!,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
