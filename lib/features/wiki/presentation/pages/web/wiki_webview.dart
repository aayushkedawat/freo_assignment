import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/web/web_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/web/web_event.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/web/web_state.dart';
import 'package:freo_assignment/features/wiki/presentation/widgets/app_bar.dart';
import 'package:loading_overlay/loading_overlay.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String name;
  const WebViewScreen({super.key, required this.url, required this.name});
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;
  InAppWebViewSettings options = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    incognito: false,
    useHybridComposition: true,
    thirdPartyCookiesEnabled: true,
    allowsInlineMediaPlayback: true,
    javaScriptEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
  );

  String url = 'https://en.wikipedia.org/?curid=';

  @override
  void initState() {
    super.initState();
    url = url + widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.buildAppBar(
        title: widget.name,
      ),
      body: BlocBuilder<WebBloc, WebState>(builder: (context, state) {
        return LoadingOverlay(
          isLoading: state.isLoading,
          child: SafeArea(
            child: PopScope(
              canPop: false,
              onPopInvoked: (didPop) async {
                if (await webViewController!.canGoBack()) {
                  await webViewController!.goBack();
                } else {
                  if (!context.mounted) return;
                  if (!didPop) Navigator.of(context).pop();
                }
              },
              child: InAppWebView(
                initialSettings: options,
                onLoadStart: (controller, url) {
                  BlocProvider.of<WebBloc>(context).add(OnPageStartLoading());
                },
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStop: (controller, url) {
                  BlocProvider.of<WebBloc>(context).add(OnPageStopLoading());
                },
                shouldOverrideUrlLoading:
                    (controller, navigationAction) async =>
                        NavigationActionPolicy.ALLOW,
                onReceivedError: (controller, request, error) {
                  BlocProvider.of<WebBloc>(context).add(OnPageStopLoading());
                },
                onGeolocationPermissionsShowPrompt: (controller, origin) async {
                  return GeolocationPermissionShowPromptResponse(
                      allow: true, retain: true, origin: origin);
                },
                initialUrlRequest: URLRequest(url: WebUri(url)),
              ),
            ),
          ),
        );
      }),
    );
  }
}
