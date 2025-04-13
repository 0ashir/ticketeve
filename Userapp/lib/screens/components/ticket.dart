import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

class Ticket extends StatelessWidget {
  final Widget data;
  const Ticket({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return TicketWidget(
      width: 150,
      height: 350,
      isCornerRounded: true,
      padding: const EdgeInsets.all(16),
      child: data,
    );
  }
}
