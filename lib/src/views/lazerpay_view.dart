import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazerpay_flutter/src/model/lazerpay_data.dart';
import 'package:lazerpay_flutter/src/model/lazerpay_event_model.dart';
import 'package:lazerpay_flutter/src/raw/lazer_html.dart';
import 'package:lazerpay_flutter/src/utils/colors.dart';
import 'package:lazerpay_flutter/src/utils/functions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:lazerpay_flutter/src/const/const.dart';
import 'package:lazerpay_flutter/src/widgets/lazerpay_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:lazerpay_flutter/src/utils/extensions.dart';
import 'package:lazerpay_flutter/src/views/lazerpay_error_view.dart';

import '../model/lazerpay_initialize_model.dart';

class LazerPayView extends StatefulWidget {
  /// Public Key from your https://app.withLazerPay.com/apps
  final LazerPayData data;

  /// initialize callback
  final ValueChanged<LazerpayInitializeModel>? onInitialize;

  /// Success callback
  final ValueChanged<dynamic>? onSuccess;

  /// Error callback<
  final ValueChanged<dynamic>? onError;

  /// LazerPay popup Close callback
  final VoidCallback? onClosed;

  /// Error Widget will show if loading fails
  final Widget? errorWidget;

  /// Show LazerPayView Logs
  final bool showLogs;

  /// Toggle dismissible mode
  final bool isDismissible;

  const LazerPayView({
    Key? key,
    required this.data,
    this.errorWidget,
    this.onSuccess,
    this.onClosed,
    this.onError,
    this.onInitialize,
    this.showLogs = false,
    this.isDismissible = false,
  }) : super(key: key);

  /// Show Dialog with a custom child
  Future show(BuildContext context) => showCupertinoModalBottomSheet<void>(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        isDismissible: isDismissible,
        enableDrag: isDismissible,
        context: context,
        builder: (context) => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: context.screenHeight(.9),
                    child: LazerPayView(
                      data: data,
                      onClosed: onClosed,
                      onSuccess: onSuccess,
                      onInitialize: onInitialize,
                      onError: onError,
                      showLogs: showLogs,
                      errorWidget: errorWidget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  _LazerPayViewState createState() => _LazerPayViewState();
}

class _LazerPayViewState extends State<LazerPayView> {
  final _controller = Completer<WebViewController>();
  Future<WebViewController> get _webViewController => _controller.future;

  LazerpayInitializeModel? _initializeModel;
  LazerpayInitializeModel? get initializeModel => _initializeModel;
  set initializeModel(LazerpayInitializeModel? val) {
    _initializeModel = val;
    if (mounted) setState(() {});
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    if (mounted) setState(() {});
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  set hasError(bool val) {
    _hasError = val;
    if (mounted) setState(() {});
  }

  int? _loadingPercent;
  int? get loadingPercent => _loadingPercent;
  set loadingPercent(int? val) {
    _loadingPercent = val;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _handleInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<ConnectivityResult>(
        future: Connectivity().checkConnectivity(),
        builder: (context, snapshot) {
          /// Show error view
          if (hasError == true) {
            return Center(
              child: widget.errorWidget ??
                  LazerPayErrorView(
                    onClosed: widget.onClosed,
                    reload: () async {
                      setState(() {});
                      await (await _webViewController).reload();
                    },
                  ),
            );
          }

          if (snapshot.hasData == true &&
              snapshot.data != ConnectivityResult.none) {
            final createUrl = LazerPayHtml.buildLazerPayHtml(
              widget.data,
            );

            return Stack(
              alignment: Alignment.center,
              children: [
                if (isLoading == true) ...[
                  const LazerPayLoader(),
                ],

                /// LazerPay Webview
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isLoading == true && _loadingPercent != 100 ? 0 : 1,
                  child: WebView(
                    initialUrl: createUrl.toString(),
                    onWebViewCreated: _controller.complete,
                    javascriptChannels: _thelazerpayJavascriptChannel,
                    javascriptMode: JavascriptMode.unrestricted,
                    zoomEnabled: false,
                    debuggingEnabled: true,
                    onPageStarted: (_) async {
                      isLoading = true;
                    },
                    onWebResourceError: (e) {
                      if (widget.showLogs) LazerPayFunctions.log(e.toString());
                    },
                    onProgress: (v) {
                      loadingPercent = v;
                    },
                    onPageFinished: (_) async {
                      isLoading = false;
                    },
                    navigationDelegate: _handleNavigationInterceptor,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }

  /// Javascript channel for events sent by LazerPay
  Set<JavascriptChannel> get _thelazerpayJavascriptChannel => {
        JavascriptChannel(
          name: 'LazerPayClientInterface',
          onMessageReceived: (JavascriptMessage data) {
            try {
              _handleResponse(data.message);
            } on Exception {
              if (mounted && widget.onClosed != null) {
                widget.onClosed!();
              }
            } catch (e) {
              if (widget.showLogs) LazerPayFunctions.log(e.toString());
            }
          },
        )
      };

  /// Parse event from javascript channel
  void _handleResponse(String res) async {
    try {
      final event = LazerPayEventModel.fromJson(res);

      if (widget.showLogs) LazerPayFunctions.log('Event: -> ${event.type}');
      switch (event.type) {
        case ON_SUCCESS:
          if (widget.onSuccess != null) {
            widget.onSuccess!(
              res,
            );
          }
          return;
        case ON_CLOSE:
          if (mounted && widget.onClosed != null) {
            widget.onClosed!();
          }
          return;
        case ON_FETCH:
          if (res.contains('initialized')) {
            final data = LazerpayInitializeModel.fromMap(event.data);
            if (widget.onInitialize != null) {
              widget.onInitialize!(data);
            }
            initializeModel = data;
          }
          return;
        case ON_COPY:
          Clipboard.setData(
            ClipboardData(text: initializeModel?.data.address ?? ''),
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 1,
            backgroundColor: lazerpayBlue.withOpacity(.6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Container(
              height: 20,
              child: Center(
                child: Text(
                  'Copied Address',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 140, vertical: 40),
            behavior: SnackBarBehavior.floating,
          ));
          return;
        default:
          if (mounted && widget.onError != null) widget.onError!(res);
          return;
      }
    } catch (e) {
      if (widget.showLogs == true) LazerPayFunctions.log(e.toString());
    }
  }

  /// Handle WebView initialization
  void _handleInit() async {
    await SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  NavigationDecision _handleNavigationInterceptor(NavigationRequest request) {
    /* if (request.url.toLowerCase().contains('chain.thelazerpay.co')) {
      // Navigate to all urls contianing LazerPay */
    return NavigationDecision.navigate;
    /* } else {
      // Block all navigations outside LazerPay
      return NavigationDecision.prevent;
    } */
  }
}
