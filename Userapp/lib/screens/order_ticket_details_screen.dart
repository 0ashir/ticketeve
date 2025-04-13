import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class OrderTicketDetailsScreen extends StatefulWidget {
  const OrderTicketDetailsScreen({super.key});

  @override
  State<OrderTicketDetailsScreen> createState() => _OrderTicketDetailsScreenState();
}

class _OrderTicketDetailsScreenState extends State<OrderTicketDetailsScreen> {
  late OrderProvider orderProvider;

  @override
  void initState() {
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          getTranslated(context, AppConstant.ticketDetails).toString(),
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderProvider.tickets.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Card(
                  borderOnForeground: false,
                  color: AppColors.whiteColor,
                  elevation: 0.8,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor.withOpacity(0.2),
                            ),
                            child: const Icon(
                              Icons.airplane_ticket,
                              color: AppColors.primaryColor,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            getTranslated(context, AppConstant.ticketNumber).toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.blackColor,
                              fontFamily: AppFontFamily.poppinsMedium,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        orderProvider.tickets[index].ticketNumber!.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontFamily: AppFontFamily.poppinsMedium,
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: PrettyQrView.data(
                              data: orderProvider.tickets[index].ticketNumber!,
                              errorCorrectLevel: QrErrorCorrectLevel.M,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
