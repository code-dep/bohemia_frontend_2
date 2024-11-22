import 'package:bohemia/dto/response/event_lists_response_dto.dart';
import 'package:bohemia/dto/response/common_api_response.dart';

abstract class IEventListApiService {
  Future<EventListsResponseDTO> getEventListsByEventId(String eventId);
  Future<CommonApiResponse> subscribeToList(String listId);
  Future<EventListsResponseDTO> getSubscribedLists();
  Future<CommonApiResponse> createNewList(String eventId, String listName);
  Future<EventListsResponseDTO> getOwnEventLists();
  Future<EventListsResponseDTO> getAllLists();
  Future<CommonApiResponse> verifyQrCode(
      String listId, String eventId, String userId);
}
