import 'dart:io' show Platform;
import 'package:event_right_scanner/DeviceUtil/fonts.dart';
import 'package:event_right_scanner/Models/scanner_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';
import 'package:event_right_scanner/DeviceUtil/app_string.dart';
import 'package:event_right_scanner/DeviceUtil/palette.dart';
import 'package:event_right_scanner/Providers/event_provider.dart';
import 'package:event_right_scanner/localization/localization_constant.dart';
import 'package:event_right_scanner/Screen/Event/event_detail_screen.dart';

class ScannerScreen extends StatefulWidget {
  final int? id;

  const ScannerScreen({
    super.key,
    this.id,
  });

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  Barcode? result;
  QRViewController? controller;

  late EventProvider eventProviderRef;

  @override
  void initState() {
    eventProviderRef = Provider.of<EventProvider>(context, listen: false);
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  Future<bool> onWillPop() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetail(id: widget.id),
      ),
    );
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (_, eventProviderRef, __) {
        return ModalProgressHUD(
          inAsyncCall: eventProviderRef.eventLoader,
          opacity: 0.5,
          progressIndicator: const SpinKitPulse(
            color: Palette.primary,
            size: 50.0,
          ),
          child: Scaffold(
            key: _globalKey,
            backgroundColor: Palette.white,
            appBar: AppBar(
              backgroundColor: Palette.primary,
              centerTitle: true,
              title: const Text(
                'Scanner',
                style: TextStyle(
                    color: Palette.white,
                    fontFamily: AppFontFamily.poppinsMedium,
                    fontSize: 16),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Palette.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetail(id: widget.id),
                    ),
                  );
                },
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h, bottom: 3.h),
                  child: Text(
                    // scanTicketQR,
                    getTranslated(context, scanTicketQR).toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: AppFontFamily.poppinsMedium,
                        color: Palette.black),
                  ),
                ),
                Container(
                  height: 40.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScannerScreen(
                          id: widget.id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Palette.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      // checkAttendees,
                      getTranslated(context, refresh).toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            color: Palette.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isScan = false;

  void _onQRViewCreated(QRViewController controller) {
    if (kDebugMode) {
      print("...............................................");
    }
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (isScan == false) {
          isScan = true;
          result = scanData;
          if (kDebugMode) {
            print("$result...............................................");
          }
          if (result != null) {
            if (kDebugMode) {
              print("$result...............................................");

              eventProviderRef
                  .callApiScan(result!.code!, widget.id, context)
                  .then((value) {
                if (value.data?.success == false) {
                  invalidQrCodeAlertdialog(context, value.data!.msg ?? "");
                } else if (value.data!.success == true) {
                  if (value.data!.data!.paymentType == "LOCAL") {
                    collectAmountAlertdialog(
                        context,
                        value.data!.data!.amount!,
                        value.data!.data!.ticket!.name ?? "",
                        value.data!.data!.ticket!.ticketNumber ?? "",
                        value.data!.data!.remainingCheckins!,
                        value.data!.data!.seatDetails);
                  } else {
                    ticketSuccessAlertdialog(
                        context,
                        value.data!.data!.amount!,
                        value.data!.data!.ticket!.name ?? "",
                        value.data!.data!.ticket!.ticketNumber ?? "",
                        value.data!.data!.remainingCheckins!,
                        value.data!.data!.seatDetails);
                  }
                }
              });
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  invalidQrCodeAlertdialog(context, String message) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.cancel_outlined,
                size: 100,
                color: Palette.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Palette.darkGrey,
                      fontFamily: AppFontFamily.poppinsMedium)),
            ),
          ],
        ),
        content: const Text("Please try again.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: Palette.darkGrey,
                fontFamily: AppFontFamily.poppinsRegular)),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text("Ok",
                style: TextStyle(
                    fontSize: 18,
                    color: Palette.primary,
                    fontFamily: AppFontFamily.poppinsMedium)),
          ),
        ],
      ),
    );
  }

  collectAmountAlertdialog(
      context,
      String amount,
      String ticketName,
      String ticketNumber,
      String remainingCheckins,
      List<SeatDetail>? seatDetails) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                size: 100,
                color: Palette.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text("Ticket Name: $ticketName",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Palette.darkGrey,
                      fontFamily: AppFontFamily.poppinsMedium)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text("Ticket Code: $ticketNumber",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Palette.darkGrey,
                      fontFamily: AppFontFamily.poppinsMedium)),
            ),
            const SizedBox(height: 8),
            if (seatDetails != null && seatDetails.isNotEmpty) ...[
              const Text("Seats:",
                  style: TextStyle(
                      fontSize: 14,
                      color: Palette.darkGrey,
                      fontFamily: AppFontFamily.poppinsMedium)),
              Wrap(
                children: [
                  for (var player in seatDetails)
                    Text(
                      "${player.row}-${player.seat}${seatDetails.last == player ? "" : ", "} ",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Palette.darkGrey,
                          fontFamily: AppFontFamily.poppinsMedium),
                    ),
                ],
              )
            ],
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "Cash to Collect:  \$ $amount",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    color: Palette.darkGrey,
                    fontFamily: AppFontFamily.poppinsMedium),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: null,
            child: Text(
              "Remaining Check-ins: $remainingCheckins",
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFontFamily.poppinsRegular,
                color: remainingCheckins == "1" ? Palette.red : Palette.black,
                // fontFamily: ConstString.fontMontserratMedium,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetail(
                    id: widget.id,
                  ),
                ),
              );
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                  fontSize: 18,
                  color: Palette.darkGrey,
                  fontFamily: AppFontFamily.poppinsMedium),
            ),
          ),
        ],
      ),
    );
  }

  ticketSuccessAlertdialog(
      context,
      String amount,
      String ticketName,
      String ticketNumber,
      String remainingCheckins,
      List<SeatDetail>? seatDetails) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                size: 100,
                color: Palette.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text("Ticket Name: $ticketName",
                  style: const TextStyle(
                      color: Palette.darkGrey,
                      fontFamily: AppFontFamily.poppinsMedium,
                      fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text("Ticket Code: $ticketNumber",
                  style: const TextStyle(
                      color: Palette.darkGrey,
                      fontFamily: AppFontFamily.poppinsMedium,
                      fontSize: 14)),
            ),
            if (seatDetails != null && seatDetails.isNotEmpty) ...[
              const Text("Seats:",
                  style: TextStyle(
                      color: Palette.darkGrey,
                      fontFamily: AppFontFamily.poppinsMedium,
                      fontSize: 14)),
              Wrap(
                children: [
                  for (var player in seatDetails)
                    Text(
                        "${player.row}-${player.seat}${seatDetails.last == player ? "" : ", "} ",
                        style: const TextStyle(
                            color: Palette.darkGrey,
                            fontFamily: AppFontFamily.poppinsMedium,
                            fontSize: 14)),
                ],
              )
            ],
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: null,
            child: Text(
              "Remaining Check-ins: $remainingCheckins",
              style: TextStyle(
                fontSize: 14, fontFamily: AppFontFamily.poppinsRegular,
                color: remainingCheckins == "1" ? Palette.red : Palette.black,
                // fontFamily: ConstString.fontMontserratMedium,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScannerScreen(
                    id: widget.id,
                  ),
                ),
              );
            },
            child: const Text("Ok",
                style: TextStyle(
                    color: Palette.primary,
                    fontFamily: AppFontFamily.poppinsMedium,
                    fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
