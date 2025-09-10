import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage(name: paymentWebViewScreenName)
class PaymentWebView extends StatefulWidget {
  final String initialUrl;

  const PaymentWebView({super.key, required this.initialUrl});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (url.contains("windcave/success")) {
              // return success and close webview
              context.router.pop(true);
            } else if (url.contains("windcave/fail")) {
              // return fail and close webview
              context.router.pop(false);
            }
          },
          onWebResourceError: (error) {
            context.router.pop(false); // error case
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'WINDCAVE VERIFICATION',
            style: AppStyles.of(context).copyWith(
              color: Colors.black,
              fontSize: 18,
              height: 13 / 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [SizedBox(width: 30, height: 30)],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}