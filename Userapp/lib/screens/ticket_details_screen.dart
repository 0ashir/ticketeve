import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/ticket_provider.dart';
import 'package:eventright_pro_user/screens/ticket_sub_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketDetails extends StatefulWidget {
  final String startDate;
  final String endDate;
  const TicketDetails(
      {super.key, required this.startDate, required this.endDate});

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  late TicketProvider ticketProvider;

  @override
  void initState() {
    ticketProvider = Provider.of<TicketProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 18,
          ),
        ),
        title: Text(
          getTranslated(context, AppConstant.ticketDetails).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: ticketProvider.eventTicketLoader,
        progressIndicator: const SpinKitCircle(color: AppColors.primaryColor),
        child: ticketProvider.ticketData.isNotEmpty
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      ticketProvider.eventName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.blackColor,
                        fontFamily: AppFontFamily.poppinsMedium,
                      ),
                    ),
                    Text(
                      "${getTranslated(context, AppConstant.by)} ${ticketProvider.organizerName}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.blueColor,
                        fontFamily: AppFontFamily.poppinsMedium,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          shrinkWrap: true,
                          itemCount: ticketProvider.ticketData.length,
                          padding: const EdgeInsets.only(bottom: 10),
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  ticketProvider
                                      .callApiForTicketDetails(
                                          ticketProvider.ticketData[index].id)
                                      .then((value) {
                                    if (value.data!.success == true) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TicketSubDetails(
                                            ticketType: ticketProvider
                                                .ticketData[index].type!,
                                            isSeatMapModuleInstalled:
                                                ticketProvider.module != null &&
                                                        ticketProvider.module!
                                                                .isInstall !=
                                                            null
                                                    ? ticketProvider
                                                        .module!.isInstall!
                                                        .toInt()
                                                    : 0,
                                            seatMapId: ticketProvider
                                                        .ticketData[index]
                                                        .seatMapId !=
                                                    null
                                                ? ticketProvider
                                                    .ticketData[index]
                                                    .seatMapId!
                                                    .toInt()
                                                : 0,
                                            eventStartDate: widget.startDate,
                                            eventEndDate: widget.endDate,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: TicketWidget(
                                    height: 230,
                                    width: 200,
                                    isCornerRounded: true,
                                    color:
                                        AppColors.primaryColor.withOpacity(0.7),
                                    padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 18),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .primaryColor),
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: Center(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Text(
                                                        ticketProvider
                                                            .ticketData[index]
                                                            .type!
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .whiteColor),
                                                      )),
                                                )),
                                            const SizedBox(height: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${getTranslated(context, AppConstant.ticketNo)!.toUpperCase()} ",
                                                  style: const TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                                Text(
                                                  ticketProvider
                                                      .ticketData[index]
                                                      .ticketNumber!
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${getTranslated(context, AppConstant.quantity)!.toUpperCase()} ",
                                                  style: const TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                                Text(
                                                  ticketProvider
                                                      .ticketData[index]
                                                      .quantity
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${getTranslated(context, AppConstant.time)!.toUpperCase()} ",
                                                  style: const TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                                Text(
                                                  formatDateTime(ticketProvider
                                                      .ticketData[index]
                                                      .startTime
                                                      .toString()),
                                                  style: const TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              SharedPreferenceHelper.getString(
                                                      Preferences
                                                          .currencySymbol) +
                                                  ticketProvider
                                                      .ticketData[index].price!
                                                      .toString()
                                                      .toUpperCase(),
                                              style: const TextStyle(
                                                color: AppColors.whiteColor,
                                                fontSize: 14,
                                                fontFamily: AppFontFamily
                                                    .poppinsSemiBold,
                                              ),
                                            ),
                                            const SizedBox(height: 25),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "TICKET NAME",
                                                  style: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                                Text(
                                                  ticketProvider
                                                      .ticketData[index].name!
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "IS AVAILABLE",
                                                  style: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                                Text(
                                                  ticketProvider
                                                              .ticketData[index]
                                                              .quantity
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'false'
                                                      ? 'YES'
                                                      : 'NO',
                                                  style: const TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "END TIME",
                                                  style: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                                Text(
                                                  formatDateTime(ticketProvider
                                                      .ticketData[index].endTime
                                                      .toString()),
                                                  style: const TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontSize: 14,
                                                    fontFamily: AppFontFamily
                                                        .poppinsMedium,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )));
                          }),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  getTranslated(context, AppConstant.noDataFound).toString(),
                ),
              ),
      ),
    );
  }
}

class RowEntry extends StatelessWidget {
  final String label1;
  final String text1;
  final String label2;
  final String text2;
  const RowEntry(
      {super.key,
      required this.label1,
      required this.text1,
      required this.label2,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label1,
              style: const TextStyle(
                color: AppColors.blackColor,
                fontSize: 14,
                fontFamily: AppFontFamily.poppinsMedium,
              ),
            ),
            Text(
              text1,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 14,
                fontFamily: AppFontFamily.poppinsMedium,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label2,
              style: const TextStyle(
                color: AppColors.blackColor,
                fontSize: 14,
                fontFamily: AppFontFamily.poppinsMedium,
              ),
            ),
            Text(
              text2,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 14,
                fontFamily: AppFontFamily.poppinsMedium,
              ),
            ),
          ],
        )
      ]),
    );
  }
}

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedTime = DateFormat('h:mm a, d MMM').format(dateTime);
  return formattedTime;
}
