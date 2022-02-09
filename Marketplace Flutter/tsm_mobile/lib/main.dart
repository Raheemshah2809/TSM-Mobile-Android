import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'menu.dart';
import 'navigation_controls.dart';
import 'web_view_stack.dart';
import "package:geolocator/geolocator.dart";

Future<void> main() async {
  LocationPermission permission = await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

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

class _WebViewAppState extends State<WebViewApp> {
  final controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TSM'),
        actions: [
          NavigationControls(controller: controller),
          Menu(controller: controller), // Add this linez
        ],
      ),
      body: WebViewStack(controller: controller),
    );
  }
}
