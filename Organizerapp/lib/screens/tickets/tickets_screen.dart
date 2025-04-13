import 'package:eventright_organizer/constant/color_constant.dart';
import 'package:eventright_organizer/localization/localization_constant.dart';
import 'package:eventright_organizer/provider/ticket_provider.dart';
import 'package:eventright_organizer/screens/tickets/add_ticket_screen.dart';
import 'package:eventright_organizer/screens/tickets/edit_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class TicketScreen extends StatefulWidget {
  final int eventId;

  const TicketScreen({super.key, required this.eventId});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  late TicketProvider ticketProvider;

  Future<void> refresh() async {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        ticketProvider.callApiForTickets(widget.eventId);
      },
    );
  }

  @override
  void initState() {
    ticketProvider = Provider.of<TicketProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      ticketProvider.callApiForTickets(widget.eventId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'tickets').toString(),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTicket(eventId: widget.eventId),
                  ));
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.add,size: 24, color: whiteColor),
            ),
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: ticketProvider.ticketsLoader,
        progressIndicator: const SpinKitCircle(color: primaryColor),
        offset: Offset(MediaQuery.of(context).size.width * 0.43, MediaQuery.of(context).size.height * 0.35),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.separated(
            itemCount: ticketProvider.tickets.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: const Icon(Icons.qr_code, color: primaryColor),
                title: Text(
                  ticketProvider.tickets[index].name!,
                  style: const TextStyle(color: blackColor, fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${ticketProvider.tickets[index].useTicket!} / ${ticketProvider.tickets[index].quantity!} Tickets Sold",
                      style: const TextStyle(color: inputTextColor, fontSize: 14),
                    ),
                    Text(
                      ticketProvider.tickets[index].ticketNumber!,
                      style: const TextStyle(color: inputTextColor, fontSize: 14),
                    ),
                    Text(
                      "${getTranslated(context, 'maximum_checkIns_allowed')}: ${ticketProvider.tickets[index].maximumCheckInsString}",
                      style: const TextStyle(color: inputTextColor, fontSize: 14),
                    ),
                  ],
                ),
                onTap: () {
                  ticketProvider.callApiForTicketDetails(ticketProvider.tickets[index].id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTicket(ticketId: ticketProvider.tickets[index].id!)
                      ));
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ticketProvider.tickets[index].price.toString(),
                      style: const TextStyle(fontSize: 16, color: blackColor),
                    ),
                    IconButton(
                      onPressed: () {
                        ticketProvider.callApiForDeleteTicket(ticketProvider.tickets[index].id);
                        refresh();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, indexes) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(),
              );
            },
          ),
        ),
      ),
    );
  }
}
