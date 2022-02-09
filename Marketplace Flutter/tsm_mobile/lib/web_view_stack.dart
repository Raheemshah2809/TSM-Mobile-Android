import 'dart:async';
// import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:location/location.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';

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
              javaScriptEnabled: true,
            ),
            android: AndroidInAppWebViewOptions(
              allowFileAccess: true,
              domStorageEnabled: true,
              geolocationEnabled: true,
            ),
          ),
          androidOnGeolocationPermissionsShowPrompt:
              (InAppWebViewController controller, String origin) async {
            return GeolocationPermissionShowPromptResponse(
                origin: origin, allow: true, retain: true);
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
