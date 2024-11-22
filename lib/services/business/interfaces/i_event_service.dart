import 'dart:io';

import 'package:bohemia/dto/common/event_dto.dart';
import 'package:bohemia/dto/response/events_response_dto.dart';

abstract class IEventService {
  Future<EventsResponseDTO> fetchEvents();
  Future<EventDTO> createEvent(String name, String description,
      DateTime dateOfEvent, DateTime endListsOpens, File image);
  Future<void> deleteEvent(String eventId);
  Future<EventDTO> updateEvent(String eventId, String name, String description,
      DateTime dateOfEvent, DateTime endListsOpens, File image);
}
