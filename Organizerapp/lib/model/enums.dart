enum EventTypes {
  online,
  offline,
}

EventTypes getEventTypesFromString(String eventTypesAsString) {
  for (EventTypes element in EventTypes.values) {
    if (element.name.toString().toLowerCase() == eventTypesAsString.toLowerCase()) {
      return element;
    }
  }
  return EventTypes.offline;
}

enum Status {
  active,
  inactive,
}

Status getStatusFromInt(int statusAsInt) {
  switch (statusAsInt) {
    case 0:
      return Status.inactive;
    case 1:
      return Status.active;
    default:
      return Status.active;
  }
}

int getStatusAsInt(Status status) {
  switch (status) {
    case Status.inactive:
      return 0;
    case Status.active:
      return 1;
    default:
      return 1;
  }
}
