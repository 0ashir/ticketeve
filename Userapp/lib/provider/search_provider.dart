import 'package:eventright_pro_user/provider/events_provider.dart';
import 'package:flutter/material.dart';

import '../model/all_events_model.dart';

class SearchProvider extends ChangeNotifier {
  /// Search events by query (matching event name or tags)
  searchEventsByQuery(List<Events> events, String query) {
    if (query.isEmpty) return events;

    EventProvider().eventsData = events.where((event) {
      final eventName = event.name?.toLowerCase() ?? "";
      // final eventTags = event.hasTag?.map((tag) => tag.toLowerCase()).toList() ?? [];
      final lowerQuery = query.toLowerCase();

      // return eventName.contains(lowerQuery) || eventTags.any((tag) => tag.contains(lowerQuery));
      return eventName.contains(lowerQuery);
    }).toList();
    notifyListeners();
  }

  /// Filter events by date
  List<Events> filterEventsByDate(List<Events> events, String date) {
    return events.where((event) => event.startTime == date).toList();
  }
}
