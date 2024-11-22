import 'package:bohemia/dto/common/event_list_dto.dart';
import 'package:bohemia/dto/response/event_lists_response_dto.dart';
import 'package:bohemia/services/business/interfaces/i_event_list_service.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyListsPageModel extends GetxController {
  final IEventListService _eventListService = Get.find();
  final IUserService _userService = Get.find();
  final Rx<EventListsResponseDTO?> subscribedLists =
      Rx<EventListsResponseDTO?>(null);

  Rx<EventListsResponseDTO?> getSubscribedLists =
      Rx<EventListsResponseDTO?>(null);
  bool get isAdmin => _userService.getUser()?.isAdmin ?? false;
  bool get isPromoter => _userService.getUser()?.isPromoter ?? false;

  @override
  void onInit() {
    super.onInit();

    getInitialData();
  }

  Map<String, List<EventListDTO>> groupListsByEvent() {
    final Map<String, List<EventListDTO>> grouped = {};

    for (var list in subscribedLists.value?.eventLists ?? []) {
      if (list.event_id != null) {
        if (!grouped.containsKey(list.event_id)) {
          grouped[list.event_id!] = [];
        }
        grouped[list.event_id]!.add(list);
      }
    }

    return grouped;
  }

  Future<void> getInitialData() async {
    try {
      EventListsResponseDTO response;
      if (isAdmin) {
        response = await _eventListService.getAllLists();
      } else if (isPromoter) {
        response = await _eventListService.getOwnEventLists();
      } else {
        response = await _eventListService.getSubscribedLists();
      }
      subscribedLists.value = response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
