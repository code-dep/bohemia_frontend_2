import 'package:bohemia/dto/response/event_lists_response_dto.dart';
import 'package:bohemia/dto/response/common_api_response.dart';
import 'package:bohemia/helpers/method_wrappers.dart';
import 'package:bohemia/services/api/interfaces/i_base_api_service.dart';
import 'package:bohemia/services/api/interfaces/i_event_list_service.dart';
import 'package:get/get.dart';

class EventListApiService implements IEventListApiService {
  final IBaseApiService _baseApiService = Get.find();

  @override
  Future<EventListsResponseDTO> getEventListsByEventId(String eventId) async {
    return await apiMethodWrapper(() async {
      var res = await _baseApiService.get('/lists/$eventId');

      var dict = res.data as Map<String, dynamic>;

      return EventListsResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<CommonApiResponse> subscribeToList(String listId) {
    return apiMethodWrapper(() async {
      var res = await _baseApiService.post('/lists/$listId/subscribe', {});

      var dict = res.data as Map<String, dynamic>;

      return CommonApiResponse.fromJson(dict);
    });
  }

  @override
  Future<EventListsResponseDTO> getSubscribedLists() {
    return apiMethodWrapper(() async {
      var res = await _baseApiService.get('/lists/subscribed');

      var dict = res.data as Map<String, dynamic>;

      return EventListsResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<CommonApiResponse> createNewList(String eventId, String listName) {
    return apiMethodWrapper(() async {
      var res = await _baseApiService.post('/promoter/lists', {
        'eventId': eventId,
        'name': listName,
      });

      var dict = res.data as Map<String, dynamic>;

      return CommonApiResponse.fromJson(dict);
    });
  }

  @override
  Future<EventListsResponseDTO> getOwnEventLists() {
    return apiMethodWrapper(() async {
      var res = await _baseApiService.get('/promoter/my-lists');

      var dict = res.data as Map<String, dynamic>;

      return EventListsResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<EventListsResponseDTO> getAllLists() {
    return apiMethodWrapper(() async {
      var res = await _baseApiService.get('/promoter/lists');

      var dict = res.data as Map<String, dynamic>;

      return EventListsResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<CommonApiResponse> verifyQrCode(
      String listId, String eventId, String userId) {
    return apiMethodWrapper(() async {
      var res = await _baseApiService.post('/lists/validate-qr', {
        'eventId': eventId,
        'userId': userId,
        'listId': listId,
      });

      var dict = res.data as Map<String, dynamic>;

      return CommonApiResponse.fromJson(dict);
    });
  }
}
