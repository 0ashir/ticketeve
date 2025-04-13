import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/tax_provider.dart';
import 'package:eventright_organizer/screens/settings/edit_tax_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constant/font_constant.dart';

class TaxOptions extends StatefulWidget {
  const TaxOptions({super.key});

  @override
  State<TaxOptions> createState() => _TaxOptionsState();
}

class _TaxOptionsState extends State<TaxOptions> {
  late TaxProvider taxProvider;

  Future<void> refresh() async {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        taxProvider.callApiForTax();
      },
    );
  }

  List<String> taxType = ['Percentage', 'Amount'];
  String selectedTax = '';
  int? value;

  bool checkedValue = false;

  @override
  void initState() {
    taxProvider = Provider.of<TaxProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      taxProvider.callApiForTax();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taxProvider = Provider.of<TaxProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(getTranslated(context, 'tax_options').toString(),
            style: const TextStyle(
                fontSize: 16,
                color: whiteColor,
                fontFamily: AppFontFamily.poppinsMedium)),
      ),
      body: ModalProgressHUD(
        inAsyncCall: taxProvider.taxLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43,
            MediaQuery.of(context).size.height * 0.35),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: taxProvider.tax.isNotEmpty
                ? ListView.builder(
                    itemCount: taxProvider.tax.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(taxProvider.tax[index].name!,
                                    style: const TextStyle(
                                        fontSize: 16, color: blackColor),
                                    maxLines: 1),
                                Text(taxProvider.tax[index].price!.toString(),
                                    style: const TextStyle(
                                        fontSize: 14, color: inputTextColor),
                                    maxLines: 1),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              // InkWell(
                              //     onTap: () {
                              //       setState(() {
                              //         taxProvider.callApiForChangeTaxStatus(
                              //             taxProvider.tax[index].id!, taxProvider.tax[index].status == 0 ? 1 : 0);
                              //         refresh();
                              //         setState(() {});
                              //       });
                              //     },
                              //     child: Text(
                              //       taxProvider.tax[index].status != 0
                              //           ? getTranslated(context, 'disable').toString()
                              //           : getTranslated(context, 'enable').toString(),
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           color: taxProvider.tax[index].status != 0 ? Colors.red : blueColor),
                              //     )),
                              Switch(
                                value: taxProvider.tax[index].status == 0
                                    ? false
                                    : true,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    taxProvider
                                        .callApiForChangeTaxStatus(
                                            taxProvider.tax[index].id!,
                                            taxProvider.tax[index].status == 0
                                                ? 1
                                                : 0)
                                        .then((value) => refresh()
                                            .then((value) => setState(() {})));
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              PopupMenuButton(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      getTranslated(context, 'edit_this_tax')
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: inputTextColor),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: Text(
                                      getTranslated(context, 'remove_tax')
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.red),
                                    ),
                                  )
                                ],
                                onSelected: (dynamic values) async {
                                  switch (values) {
                                    case 1:
                                      taxProvider
                                          .callApiForTaxDetails(
                                              taxProvider.tax[index].id!)
                                          .then(
                                        (value) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AddOrEditTaxScreen(
                                                          isEditing: true)));
                                        },
                                      );
                                      break;
                                    case 2:
                                      await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              "${getTranslated(context, 'delete_tax')}?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(getTranslated(
                                                      context, 'cancel')
                                                  .toString()),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                taxProvider
                                                    .callApiForDeleteTax(
                                                        taxProvider
                                                            .tax[index].id!)
                                                    .then(
                                                  (value) {
                                                    refresh();
                                                  },
                                                );
                                              },
                                              child: Text(getTranslated(
                                                      context, 'delete')
                                                  .toString()),
                                            ),
                                          ],
                                        ),
                                      );
                                      break;
                                  }
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 05),
                          Divider(
                            color: Colors.grey.withOpacity(0.4),
                          )
                        ],
                      );
                    })
                : Center(
                    child: Text(
                        getTranslated(context, 'no_data_found').toString()),
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const AddOrEditTaxScreen(isEditing: false),
              ),
            );
          },
          child: const Icon(Icons.add, color: whiteColor)),
    );
  }
}
