import 'package:bohemia/dto/response/event_lists_response_dto.dart';
import 'package:get/get.dart';

class EventListsDataController extends GetxController {
  final Rx<EventListsResponseDTO?> eventLists =
      Rx<EventListsResponseDTO?>(null);
  final Rx<EventListsResponseDTO?> ownEventLists =
      Rx<EventListsResponseDTO?>(null);

  void updateEventLists(EventListsResponseDTO newLists) {
    eventLists.value = newLists;
  }

  void updateOwnEventLists(EventListsResponseDTO newLists) {
    ownEventLists.value = newLists;
  }
}
