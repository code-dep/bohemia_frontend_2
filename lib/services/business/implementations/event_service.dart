import 'dart:io';

import 'package:bohemia/dto/common/event_dto.dart';
import 'package:bohemia/dto/response/events_response_dto.dart';
import 'package:bohemia/helpers/method_wrappers.dart';
import 'package:bohemia/services/api/interfaces/i_events_api_service.dart';
import 'package:bohemia/services/business/interfaces/i_event_service.dart';
import 'package:get/get.dart';

class EventService implements IEventService {
  final IEventsApiService _eventsApiService = Get.find();

  @override
  Future<EventsResponseDTO> fetchEvents() {
    return serviceMethodWrapper(() async {
      var res = await _eventsApiService.fetchEvents();

      return res;
    });
  }

  @override
  Future<EventDTO> createEvent(String name, String description,
      DateTime dateOfEvent, DateTime endListsOpens, File image) {
    return serviceMethodWrapper(() async {
      final dateOfEventString =
          dateOfEvent.toUtc().toIso8601String().replaceAll('.000', '');
      final endListsOpensString =
          endListsOpens.toUtc().toIso8601String().replaceAll('.000', '');

      var res = await _eventsApiService.createEvent(
          name, description, dateOfEventString, endListsOpensString, image);

      return res;
    });
  }

  @override
  Future<void> deleteEvent(String eventId) {
    return serviceMethodWrapper(() async {
      await _eventsApiService.deleteEvent(eventId);
    });
  }

  @override
  Future<EventDTO> updateEvent(String eventId, String name, String description,
      DateTime dateOfEvent, DateTime endListsOpens, File image) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }
}
