library flutter_paypal;

import 'dart:core';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/paypal/complete_payment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'paypal_services.dart';

class UsePaypal extends StatefulWidget {
  final Function onSuccess, onCancel, onError;
  final String returnURL, cancelURL, note, clientId, secretKey;
  final List transactions;
  final bool sandboxMode;

  const UsePaypal({
    super.key,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
    required this.returnURL,
    required this.cancelURL,
    required this.transactions,
    required this.clientId,
    required this.secretKey,
    this.sandboxMode = false,
    this.note = '',
  });

  @override
  State<StatefulWidget> createState() {
    return UsePaypalState();
  }
}

class UsePaypalState extends State<UsePaypal> {
  WebViewController? _controller;
  String checkoutUrl = '';
  String navUrl = '';
  String executeUrl = '';
  String accessToken = '';
  bool loading = true;
  bool pageLoading = true;
  bool loadingError = false;
  late PaypalServices services;
  int pressed = 0;

  Map getOrderParams() {
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": widget.transactions,
      "note_to_payer": widget.note,
      "redirect_urls": {"return_url": widget.returnURL, "cancel_url": widget.cancelURL}
    };
    return temp;
  }

  loadPayment() async {
    setState(() {
      loading = true;
    });
    try {
      Map getToken = await services.getAccessToken();
      if (getToken['token'] != null) {
        accessToken = getToken['token'];
        final transactions = getOrderParams();
        final res = await services.createPaypalPayment(transactions, accessToken);
        if (res["approvalUrl"] != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"].toString();
            navUrl = res["approvalUrl"].toString();
            executeUrl = res["executeUrl"].toString();
            loading = false;
            pageLoading = false;
            loadingError = false;
            late final PlatformWebViewControllerCreationParams params;
            if (WebViewPlatform.instance is WebKitWebViewPlatform) {
              params = WebKitWebViewControllerCreationParams(
                allowsInlineMediaPlayback: true,
                mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
              );
            } else {
              params = const PlatformWebViewControllerCreationParams();
            }
            final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
            controller
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse(checkoutUrl))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (progress) {
                    if (kDebugMode) {
                      print(progress);
                    }
                  },
                  onPageFinished: (String url) {},
                  onNavigationRequest: (NavigationRequest request) async {
                    if (request.url.startsWith('https://www.youtube.com/')) {
                      return NavigationDecision.prevent;
                    }
                    if (request.url.contains(widget.returnURL)) {
                      if (kDebugMode) {
                        print("Access Token: $accessToken");
                        print("ExecuteUrl:$executeUrl");
                        print("Service:$services");
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompletePaymentState(url: request.url, services: services, executeUrl: executeUrl, accessToken: accessToken, onSuccess: widget.onSuccess, onCancel: widget.onCancel, onError: widget.onError),
                        ),
                      );
                    }
                    if (request.url.contains(widget.cancelURL)) {
                      final uri = Uri.parse(request.url);
                      await widget.onCancel(uri.queryParameters);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              );
            _controller = controller;
          });
        } else {
          widget.onError(res);
          setState(() {
            loading = false;
            pageLoading = false;
            loadingError = true;
          });
        }
      } else {
        widget.onError("${getToken['message']}");

        setState(() {
          loading = false;
          pageLoading = false;
          loadingError = true;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Load Payment error");
      }
      widget.onError(e);
      setState(() {
        loading = false;
        pageLoading = false;
        loadingError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    services = PaypalServices(
      sandboxMode: widget.sandboxMode,
      clientId: widget.clientId,
      secretKey: widget.secretKey,
    );
    setState(() {
      navUrl = widget.sandboxMode ? 'https://api.sandbox.paypal.com' : 'https://www.api.paypal.com';
    });
    loadPayment();
  }

  Future<bool> onWillPop() {
    if (pressed < 2) {
      setState(() {
        pressed++;
      });
      final snackBar = SnackBar(content: Text('Press back ${3 - pressed} more times to cancel transaction'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) => onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF272727),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: Uri.parse(navUrl).hasScheme ? Colors.green : Colors.blue,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          navUrl,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(width: pageLoading ? 5 : 0),
                      pageLoading ? const SpinKitCircle(color: AppColors.primaryColor) : const SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: loading
              ? const Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SpinKitCircle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                )
              : loadingError
                  ? const Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text("Something Wrong"),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: WebViewWidget(
                            controller: _controller!,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
