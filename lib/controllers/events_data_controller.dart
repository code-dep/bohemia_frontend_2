import 'package:bohemia/dto/response/events_response_dto.dart';
import 'package:get/get.dart';

class EventsDataController extends GetxController {
  final Rx<EventsResponseDTO?> events = Rx<EventsResponseDTO?>(null);

  void updateEvents(EventsResponseDTO newEvents) {
    events.value = newEvents;
  }
}
