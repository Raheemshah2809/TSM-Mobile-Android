import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'web_view_stack.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);
  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

void requestPermission() async {
  Map<Permission, PermissionStatus> statuses =
      await [Permission.location, Permission.camera].request();
}

class _WebViewAppState extends State<WebViewApp> {
  final controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        top: true,
        right: false,
        bottom: true,
        minimum: const EdgeInsets.all(1.0),
        child: WebViewStack(
          controller: controller,
        ),
      ),
    );
  }
}
