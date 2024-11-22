import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:bohemia/dto/response/event_lists_response_dto.dart';
import 'package:bohemia/services/business/interfaces/i_event_list_service.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:get/get.dart';

class EventDetailsPageModel {
  final IEventListService _eventListService = Get.find();
  final IUserService _userService = Get.find();

  EventDetailsPageModel() {
    final user = _userService.getUser();
    isAdmin.value = user?.isAdmin ?? false;
    isPromoter.value = user?.isPromoter ?? false;
  }

  Rx<EventListsResponseDTO?> eventList = Rx(null);

  RxBool canCreateLists() {
    return RxBool(
        _userService.getUser()!.isPromoter || _userService.getUser()!.isAdmin);
  }

  void setIsAdmin() {
    var value = _userService.getUser()!.isAdmin;
    isAdmin.value = value;
    isAdmin.refresh();
  }

  void setIsPromoter() {
    var value = _userService.getUser()!.isPromoter;
    isPromoter.value = value;
    isPromoter.refresh();
  }

  RxBool isAdmin = false.obs;
  RxBool isPromoter = false.obs;

  RxBool canCreateNewList = RxBool(false);

  bool isSubscribed = false;

  bool checkSubscription() {
    return isSubscribed;
  }

  Future<EventListsResponseDTO> getEventLists(String eventId) async {
    final result = await _eventListService.getEventListsByEventId(eventId);
    eventList.value = result;
    return result;
  }

  Future<bool> subscribeToList(String listId) async {
    await _eventListService.subscribeToList(listId);
    isSubscribed = true;

    Get.back();
    return true;
  }

  Future<void> createNewList(String eventId) async {
    var name = _userService.getUser()!.name;
    var surname = _userService.getUser()!.surname;
    var listName = 'Lista di $name $surname';
    await _eventListService.createNewList(eventId, listName);

    // Fetch updated event lists and update the observable
    eventList.value = await _eventListService.getEventListsByEventId(eventId);

    // Update the canCreateNewList value
    canCreateNewList.value = false;
  }

  Future<RxBool> canCreateNewLists(String eventId) async {
    var ownEventLists = await _eventListService.getOwnEventLists();

    for (var list in ownEventLists.eventLists!) {
      if (list.event_id == eventId) {
        canCreateNewList.value = false;
        return canCreateNewList;
      }
    }

    canCreateNewList.value = true;
    return canCreateNewList;
  }

  Future<void> init(String eventId) async {
    await getEventLists(eventId);
  }

  final Rx<Color> textColor = Colors.white.obs;

  Future<void> updateTextColor(ImageProvider imageProvider) async {
    try {
      final completer = Completer<ui.Image>();
      final stream = imageProvider.resolve(ImageConfiguration());

      final listener = ImageStreamListener((info, _) {
        if (!completer.isCompleted) {
          completer.complete(info.image);
        }
      });

      stream.addListener(listener);
      await completer.future;
      stream.removeListener(listener);
    } catch (e) {
      debugPrint('Error updating text color: $e');
    }
  }
}
