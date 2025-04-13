import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'paypal_services.dart';

class CompletePaymentState extends StatefulWidget {
  final Function onSuccess, onCancel, onError;
  final PaypalServices services;
  final String url, executeUrl, accessToken;

  const CompletePaymentState({
    super.key,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
    required this.services,
    required this.url,
    required this.executeUrl,
    required this.accessToken,
  });

  @override
  State<CompletePaymentState> createState() => _CompletePaymentStateState();
}

class _CompletePaymentStateState extends State<CompletePaymentState> {
  bool loading = true;
  bool loadingError = false;

  // ignore: prefer_typing_uninitialized_variables
  var data;

  complete() async {
    final uri = Uri.parse(widget.url);
    final payerID = uri.queryParameters['PayerID'];
    if (payerID != null) {
      Map params = {
        "payerID": payerID,
        "paymentId": uri.queryParameters['paymentId'],
        "token": uri.queryParameters['token'],
      };
      setState(() {
        loading = true;
        loadingError = false;
      });

      Map resp = await widget.services.executePayment(widget.executeUrl, payerID, widget.accessToken);
      if (resp['error'] == false) {
        params['status'] = 'success';
        params['data'] = resp['data'];
        await widget.onSuccess(params);
        setState(() {
          data = params;
          if (kDebugMode) {
            print(data);
          }
          loading = false;
          loadingError = false;
        });
      } else {
        if (resp['exception'] != null && resp['exception'] == true) {
          widget.onError({"message": resp['message']});
          setState(() {
            loading = false;
            loadingError = true;
          });
        } else {
          await widget.onError(resp['data']);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        }
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    complete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF536471),
      body: Container(
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
            : loadingError == true
                ? const Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text("Something went wrong"),
                        ),
                      ),
                    ],
                  )
                : Dialog(
                    backgroundColor: const Color(0xFF536471).withAlpha(80),
                    insetPadding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Payment Sucess",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Translation Id: ${data["token"].toString()}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.inputTextColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Payment Method"),
                                          Text("Paypal"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Amount"),
                                          Text(
                                            SharedPreferenceHelper.getString(Preferences.currencySymbol) + (data['data']["transactions"][0]["amount"]['total']).toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        child: const Text(
                                          "Continue",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
