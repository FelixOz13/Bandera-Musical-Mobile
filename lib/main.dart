import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bandera Musical',
            style: TextStyle(
              fontFamily: 'Gajraj',
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.flag_circle, size: 43),
              tooltip: 'Go to initial URL',
              onPressed: () {
                controller.loadUrl('https://banderamusical.com/');
              },
            ),
          ],
          backgroundColor: Colors.black,
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          userAgent: 'CustomUserAgent/1.0; no-cache',
          initialUrl: 'https://banderamusical.com/',
          onWebViewCreated: (WebViewController controller) {
            this.controller = controller;
          },
          onPageStarted: (String url) {
            print('Bandera Musical: $url');
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.import_export,
            size: 43,
          ),
          onPressed: () async {
            if (await controller.canGoBack()) {
              controller.goBack();
            } else {
              // If the WebView cannot go back, show an alert dialog
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Text('Cannot go back'),
                  content: Text('The WebView cannot go back any further.'),
                ),
              );
            }
          },
        )
    );
  }
}



