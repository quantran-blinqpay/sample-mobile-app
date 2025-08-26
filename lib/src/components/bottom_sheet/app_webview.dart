import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebview extends StatefulWidget {
  const AppWebview({
    super.key,
    required this.url,
    this.title,
  });

  final String? title;
  final String url;

  @override
  State<AppWebview> createState() => _AppWebviewState();
}

class _AppWebviewState extends State<AppWebview> {
  late final WebViewController _controller;
  bool isLoading = true;
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
            ''');
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url != widget.url) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 1,
        controller: draggableScrollableController,
        builder: (BuildContext context, ScrollController scrollController) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                if (isLoading) Text('data'),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                ),
                Expanded(child: WebViewWidget(controller: _controller)),
              ],
            ),
          );
        });
  }
}
