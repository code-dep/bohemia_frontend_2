import 'package:bohemia/dto/response/event_lists_response_dto.dart';
import 'package:bohemia/services/business/interfaces/i_event_list_service.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final IEventListService _eventListService = Get.find();
  final RxMap<String, bool> eventSubscriptionStatus = <String, bool>{}.obs;
  final Rx<EventListsResponseDTO?> subscribedLists =
      Rx<EventListsResponseDTO?>(null);

  Future<void> loadSubscribedLists() async {
    if (subscribedLists.value == null) {
      final lists = await _eventListService.getSubscribedLists();
      subscribedLists.value = lists;

      // Cache subscription status for each event
      for (var list in lists.eventLists ?? []) {
        if (list.event_id != null) {
          eventSubscriptionStatus[list.event_id!] = true;
        }
      }
    }
  }

  bool isSubscribed(String eventId) {
    return eventSubscriptionStatus[eventId] ?? false;
  }

  void updateSubscriptionStatus(String eventId, bool status) {
    eventSubscriptionStatus[eventId] = status;
  }
}
