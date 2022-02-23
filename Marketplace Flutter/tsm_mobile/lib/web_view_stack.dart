import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse(
                  'https://studentmarketplace.netlify.app/index.html')),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true, useShouldOverrideUrlLoading: true),
            android: AndroidInAppWebViewOptions(
              allowFileAccess: true,
              domStorageEnabled: true,
              geolocationEnabled: true,
              useHybridComposition: true,
            ),
          ),
          androidOnGeolocationPermissionsShowPrompt:
              (InAppWebViewController controller, String origin) async {
            return GeolocationPermissionShowPromptResponse(
                origin: origin, allow: true, retain: true);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            return NavigationActionPolicy.ALLOW;
          },
        )
      ],
    );
  }

  // Add from here ...
  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
        name: 'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      ),
    };
  }
  // ... to here.
}
