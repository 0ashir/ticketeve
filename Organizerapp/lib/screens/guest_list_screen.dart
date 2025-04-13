import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/constant/font_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/model/guest_list_model.dart';
import 'package:eventright_organizer/provider/event_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class GuestList extends StatefulWidget {
  const GuestList({super.key});

  @override
  State<GuestList> createState() => _GuestListState();
}

class _GuestListState extends State<GuestList> {
  late EventProvider eventProvider;

  List<GuestData> searchResult = [];

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "${getTranslated(context, 'guest_list')} (${eventProvider.guest.length})",
          style: const TextStyle(fontSize: 16, color: whiteColor, fontFamily: AppFontFamily.poppinsMedium)
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
            size: 18,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: eventProvider.guestLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43, MediaQuery.of(context).size.height * 0.35),
        child: eventProvider.guest.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: _searchController,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: getTranslated(context, 'search_guest_name').toString(),
                          hintStyle: const TextStyle(color: inputTextColor, fontSize: 16),
                          suffixIcon: _searchController.text.isEmpty
                              ? const Icon(Icons.search_sharp, size: 25)
                              : InkWell(
                                  onTap: () {
                                    _searchController.clear();
                                    searchResult.clear();
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.clear, size: 25),
                                ),
                        ),
                        onChanged: onSearchTextChanged,
                      ),
                    ),
                    _searchController.text.isNotEmpty
                        ? searchResult.isNotEmpty
                            ? SingleChildScrollView(
                                controller: _scrollController2,
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: DataTable(
                                    columns: [
                                      const DataColumn(
                                        label: Text(''),
                                      ),
                                      DataColumn(
                                          label: Text(
                                        getTranslated(context, 'ticket_number').toString(),
                                        style: const TextStyle(fontSize: 14, color: blackColor),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        getTranslated(context, 'guest_name').toString(),
                                        style: const TextStyle(fontSize: 14, color: blackColor),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        getTranslated(context, 'tickets').toString(),
                                        style: const TextStyle(fontSize: 14, color: blackColor),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        getTranslated(context, 'email_title').toString(),
                                        style: const TextStyle(fontSize: 14, color: blackColor),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        getTranslated(context, 'phone_no').toString(),
                                        style: const TextStyle(fontSize: 14, color: blackColor),
                                      )),
                                    ],
                                    rows: searchResult
                                        .map(
                                          ((guestData) => DataRow(
                                                cells: <DataCell>[
                                                  const DataCell(
                                                    Icon(CupertinoIcons.delete, size: 20, color: Colors.red),
                                                  ),
                                                  DataCell(
                                                    InkWell(
                                                      onTap: () {
                                                        _modalBottomSheetTicketDetails(guestData);
                                                      },
                                                      child: Text(
                                                        guestData.ticket!.ticketNumber!,
                                                        style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      guestData.customer!.name!,
                                                      style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      guestData.quantity.toString(),
                                                      style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      guestData.customer!.email!,
                                                      style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      guestData.customer!.phone!,
                                                      style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )
                                        .toList(),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: height * 0.02),
                                    child: Text(getTranslated(context, 'no_data_found').toString()),
                                  ),
                                ))
                        : SingleChildScrollView(
                            controller: _scrollController2,
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    getTranslated(context, 'ticket_number').toString(),
                                    style: const TextStyle(fontSize: 14, color: blackColor),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    getTranslated(context, 'guest_name').toString(),
                                    style: const TextStyle(fontSize: 14, color: blackColor),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    getTranslated(context, 'tickets').toString(),
                                    style: const TextStyle(fontSize: 14, color: blackColor),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    getTranslated(context, 'email_title').toString(),
                                    style: const TextStyle(fontSize: 14, color: blackColor),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    getTranslated(context, 'phone_no').toString(),
                                    style: const TextStyle(fontSize: 14, color: blackColor),
                                  )),
                                ],
                                rows: eventProvider.guest
                                    .map(
                                      ((guestData) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(
                                                InkWell(
                                                  onTap: () {
                                                    _modalBottomSheetTicketDetails(guestData);
                                                  },
                                                  child: Text(
                                                    guestData.ticket!.ticketNumber!,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: primaryColor,
                                                        decoration: TextDecoration.underline),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  guestData.customer!.name!,
                                                  style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  guestData.quantity.toString(),
                                                  style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  guestData.customer!.email!,
                                                  style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  guestData.customer!.phone!,
                                                  style: const TextStyle(fontSize: 14, color: inputTextColor),
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                    .toList(),
                              ),
                            ),
                          )
                  ],
                ),
              )
            : Center(
                child: Text(getTranslated(context, 'no_data_found').toString()),
              ),
      ),
    );
  }

  void _modalBottomSheetTicketDetails(GuestData guestData) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, myState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 60.0,
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Ticket Details",
                          style: TextStyle(color: whiteColor, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  guestData.ticket!.ticketNumber!,
                                  style: const TextStyle(fontSize: 14, color: inputTextColor),
                                ),
                                Text(
                                  guestData.customer!.name ?? "No Name Found",
                                  style: const TextStyle(fontSize: 18, color: blackColor),
                                ),
                              ],
                            ),
                            const Icon(CupertinoIcons.delete, color: Colors.red)
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Tickets",
                              style: TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                            Text(
                              guestData.quantity.toString(),
                              style: const TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 05),
                        const Divider(),
                        const SizedBox(height: 05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                            Text(
                              guestData.customer!.email ?? "No Email Found",
                              style: const TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 05),
                        const Divider(),
                        const SizedBox(height: 05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Contact Number",
                              style: TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                            Text(
                              guestData.customer!.phone ?? "No Phone Found",
                              style: const TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 05),
                        const Divider(),
                        const SizedBox(height: 05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Ticket Purchase Date",
                              style: TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                            Text(
                              guestData.createdAt,
                              style: const TextStyle(fontSize: 14, color: inputTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 05),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (var guestList in eventProvider.guest) {
      if (guestList.customer!.name!.toLowerCase().contains(
                text.toLowerCase(),
              ) ||
          guestList.ticket!.ticketNumber!.toLowerCase().contains(
                text.toLowerCase(),
              )) {
        searchResult.add(guestList);
      }
    }
    setState(() {});
  }
}
