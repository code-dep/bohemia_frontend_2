import 'dart:io';

import 'package:bohemia/dto/common/event_dto.dart';
import 'package:bohemia/dto/response/events_response_dto.dart';

abstract class IEventsApiService {
  Future<EventsResponseDTO> fetchEvents();
  Future<EventDTO> createEvent(String name, String description,
      String dateOfEvent, String endListsOpens, File image);
  Future deleteEvent(String eventId);
}
