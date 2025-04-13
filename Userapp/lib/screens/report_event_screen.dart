import 'package:eventright_pro_user/constant/app_const_font.dart';
import 'package:eventright_pro_user/constant/app_constant.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:eventright_pro_user/constant/common_function.dart';
import 'package:eventright_pro_user/constant/pref_constants.dart';
import 'package:eventright_pro_user/constant/preferences.dart';
import 'package:eventright_pro_user/localization/localization_constant.dart';
import 'package:eventright_pro_user/provider/events_provider.dart';
import 'package:eventright_pro_user/screens/components/button.dart';
import 'package:eventright_pro_user/screens/components/field.dart';
import 'package:eventright_pro_user/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ReportEvent extends StatefulWidget {
  const ReportEvent({super.key});

  @override
  State<ReportEvent> createState() => _ReportEventState();
}

class _ReportEventState extends State<ReportEvent> {
  late EventProvider eventProvider;

  List<String> reasons = [
    'Canceled Event',
    'Copyright or Trademark Infringement',
    'Fraudulent of Unauthorized Event',
    'Offensive or Illegal Event',
    'Spam'
  ];

  String selectedIndex = 'Canceled Event';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String reason = 'Other';

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    _emailController.text = SharedPreferenceHelper.getString(Preferences.email);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          getTranslated(context, AppConstant.reportEvent).toString(),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
            fontFamily: AppFontFamily.poppinsMedium,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: eventProvider.reportLoader,
        progressIndicator: const SpinKitCircle(color: AppColors.primaryColor),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Field(
                  controller: _emailController,
                  label:
                      getTranslated(context, AppConstant.emailTitle).toString(),
                  icon: const Icon(Icons.email_outlined),
                  isPassword: false,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      _modalBottomSheetMenu();
                      setState(() {});
                    });
                  },
                  child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: reason.toLowerCase() == 'other'
                              ? const Text('Select Reason',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.blackColor,
                                      fontFamily: AppFontFamily.poppinsMedium))
                              : Text(reason),
                        ),
                      )),
                ),
                const SizedBox(height: 10),
                Text(
                  getTranslated(context, AppConstant.message).toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontFamily: AppFontFamily.poppinsMedium,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(width: 0.2, color: AppColors.inputTextColor),
                  ),
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: AppFontFamily.poppinsMedium,
                    ),
                    controller: _messageController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8)),
                  ),
                ),
                const SizedBox(height: 50),
                InkWell(
                    onTap: () {
                      if (_emailController.text.isEmpty) {
                        CommonFunction.toastMessage("Please Enter Email");
                      } else if (reason == "") {
                        CommonFunction.toastMessage("Please Select Reason");
                      } else if (_messageController.text.isEmpty) {
                        CommonFunction.toastMessage("Please Enter Message");
                      } else {
                        Map<String, dynamic> body = {
                          "event_id": eventProvider.eventId,
                          "email": _emailController.text,
                          "reason": reason,
                          "message": _messageController.text
                        };
                        eventProvider.callApiForReportEvent(body);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomeScreen(index: 0)));
                      }
                    },
                    child: Button(
                        text: getTranslated(context, AppConstant.sendMessage)
                            .toString())),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, myState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    myState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    height: 45.0,
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Text(
                          getTranslated(context, AppConstant.done).toString(),
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 18,
                            fontFamily: AppFontFamily.poppinsMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: reasons.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          myState(() {
                            selectedIndex = reasons[index];
                            reason = reasons[index];
                            myState(() {});
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 05),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: selectedIndex == reasons[index]
                                      ? AppColors.inputTextColor
                                      : Colors.transparent)),
                          alignment: Alignment.center,
                          child: Text(
                            reasons[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFontFamily.poppinsMedium,
                              color: selectedIndex == reasons[index]
                                  ? AppColors.blackColor
                                  : AppColors.inputTextColor,
                              fontWeight: selectedIndex == reasons[index]
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    })
              ],
            );
          });
        });
  }
}
