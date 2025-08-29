// ignore_for_file: must_be_immutable, cascade_invocations, lines_longer_than_80_chars, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:perubeca/app/utils/constans.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class AppWebView extends StatefulWidget {
  AppWebView({required this.url, super.key});
  String? url;

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late final WebViewController _controller;
  bool loader = true;
  bool isError = false;

  bool internetError = false;
  @override
  void initState() {
    initwebViewController();
    super.initState();
  }

  void initwebViewController() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            loader = false;
            debugPrint('Page finished loading: $url');
            setState(() {});
          },
          onWebResourceError: (WebResourceError error) {
            loader = false;
            if (error.description.contains('ERR_INTERNET_DISCONNECTED')) {
              internetError = true;
            } else {
              isError = true;
            }
            setState(() {});
            debugPrint('''
                        Page resource error:
                          code: ${error.errorCode}
                          description: ${error.description}
                          errorType: ${error.errorType}
                          isForMainFrame: ${error.isForMainFrame}
                      ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {},
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url!));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              decoration: ConstantsApp.boxRadialDecoratioBottonBorderPrimary,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: -43,
                    bottom: -5,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -50,
                    top: -7,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Volver',
                            style: TextStyle(
                              fontFamily: ConstantsApp.OPMedium,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //web view

            Visibility(
              visible: !isError && !internetError,
              child: Expanded(
                child: Stack(
                  children: [
                    Visibility(
                      visible: loader,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Visibility(
                      visible: !loader && !isError,
                      child: WebViewWidget(controller: _controller),
                    ),
                    Visibility(
                      visible: isError,
                      child: const Center(
                        child: Text(
                          'En este momento el Gob.pe de la Presidencia del Consejo de Ministros no se encuentra disponible, por favor inténtelo más tarde.',
                          style: TextStyle(
                            fontFamily: ConstantsApp.OPRegular,
                            fontSize: 16,
                            color: ConstantsApp.colorBlackPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Visibility(
              visible: internetError,
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: SvgPicture.asset(
                            ConstantsApp.peluchinNoInternet,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Text(
                            'Sin conexión a internet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstantsApp.textBluePrimary,
                              fontFamily: ConstantsApp.OPBold,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          child: Text(
                            'Comprueba tu conexión  Wi-Fi o de datos móbiles. Por favor, verifica y vuelva a intentar.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstantsApp.colorBlackSecondary,
                              fontFamily: ConstantsApp.QSMedium,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
