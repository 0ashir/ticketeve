import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/model/wallet_model.dart';
import 'package:eventright_pro_user/provider/wallet_provider.dart';
import 'package:eventright_pro_user/screens/settings/wallet_deposit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late WalletProvider walletProvider;

  @override
  void initState() {
    walletProvider = Provider.of<WalletProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      walletProvider.callApiForWallet();
    });
    super.initState();
  }

  Future<void> refresh() async {
    setState(() {
      Future.delayed(
        const Duration(seconds: 0),
        () {
          walletProvider.callApiForWallet();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 16,
          ),
        ),
        centerTitle: true,
         title:  Text(
           getTranslated(context, AppConstant.myWallet).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: walletProvider.walletLoader,
        progressIndicator: const SpinKitCircle(
          color: AppColors.primaryColor,
        ),
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: refresh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    getTranslated(context, AppConstant.walletTransactions).toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFontFamily.poppinsMedium,
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (walletProvider.walletData != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${getTranslated(context, AppConstant.walletBalance)}: ${SharedPreferenceHelper.getString(Preferences.currencySymbol)}${walletProvider.walletData!.data!.balance}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.inputTextColor,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const WalletDepositScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 07),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              getTranslated(context, AppConstant.add).toString(),
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: AppFontFamily.poppinsMedium,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    walletProvider.walletLoader == true
                        ? const SizedBox()
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: walletProvider.walletData!.data!.transactions!.length,
                            itemBuilder: (context, index) {
                              Transactions txn = walletProvider.walletData!.data!.transactions![index];
                              return ListTile(
                                dense: true,
                                title: Text(
                                  txn.type == "withdraw" ? "Withdraw by Purchase" : "Deposit with ${txn.meta?.paymentMode ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                  ),
                                  maxLines: 1,
                                ),
                                // contentPadding: EdgeInsets.zero,
                                subtitle: txn.meta?.token == null
                                    ? null
                                    : Text(
                                        txn.meta!.token!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: AppFontFamily.poppinsMedium,
                                        ),
                                        maxLines: 1,
                                      ),
                                trailing: Text(
                                  "${txn.amount}",
                                  style: TextStyle(
                                    color: txn.type == "deposit" ? Colors.green : Colors.red,
                                    fontFamily: AppFontFamily.poppinsMedium,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
