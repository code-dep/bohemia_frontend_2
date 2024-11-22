import 'package:bohemia/controllers/event_lists_data_controller.dart';
import 'package:bohemia/dto/response/event_lists_response_dto.dart';
import 'package:bohemia/dto/response/common_api_response.dart';
import 'package:bohemia/helpers/method_wrappers.dart';
import 'package:bohemia/services/api/interfaces/i_event_list_service.dart';
import 'package:bohemia/services/business/interfaces/i_event_list_service.dart';
import 'package:get/get.dart';

class EventListService implements IEventListService {
  final IEventListApiService _eventListApiService = Get.find();
  final EventListsDataController _eventListsDataController = Get.find();

  @override
  Future<EventListsResponseDTO> getEventListsByEventId(String eventId) {
    return serviceMethodWrapper(() async {
      var res = await _eventListApiService.getEventListsByEventId(eventId);

      return res;
    });
  }

  @override
  Future<CommonApiResponse> subscribeToList(String listId) {
    return serviceMethodWrapper(() async {
      var res = await _eventListApiService.subscribeToList(listId);

      return res;
    });
  }

  @override
  Future<EventListsResponseDTO> getSubscribedLists() {
    return serviceMethodWrapper(() async {
      var res = await _eventListApiService.getSubscribedLists();

      return res;
    });
  }

  @override
  Future<CommonApiResponse> createNewList(String eventId, String listName) {
    return serviceMethodWrapper(() async {
      var res = await _eventListApiService.createNewList(eventId, listName);

      return res;
    });
  }

  @override
  Future<EventListsResponseDTO> getOwnEventLists() {
    return serviceMethodWrapper(() async {
      var res = await _eventListApiService.getOwnEventLists();

      _eventListsDataController.updateOwnEventLists(res);

      return res;
    });
  }

  @override
  Future<EventListsResponseDTO> getAllLists() {
    return serviceMethodWrapper(() async {
      var res = await _eventListApiService.getAllLists();

      return res;
    });
  }

  @override
  Future<CommonApiResponse> verifyQrCode(
      String listId, String eventId, String userId) {
    return serviceMethodWrapper(() async {
      var res =
          await _eventListApiService.verifyQrCode(listId, eventId, userId);

      return res;
    });
  }
}
