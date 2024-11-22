import 'dart:io';
import 'package:bohemia/dto/common/event_dto.dart';
import 'package:bohemia/dto/response/events_response_dto.dart';
import 'package:bohemia/helpers/method_wrappers.dart';
import 'package:bohemia/services/api/interfaces/i_base_api_service.dart';
import 'package:bohemia/services/api/interfaces/i_events_api_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class EventsApiService implements IEventsApiService {
  final IBaseApiService _baseApiService = Get.find();

  @override
  Future<EventsResponseDTO> fetchEvents() async {
    return await apiMethodWrapper(() async {
      var res = await _baseApiService.get('/events');

      var dict = res.data as Map<String, dynamic>;

      return EventsResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<EventDTO> createEvent(String name, String description,
      String dateOfEvent, String endListsOpens, File image) async {
    return await apiMethodWrapper(() async {
      final formData = dio.FormData();

      formData.fields.addAll([
        MapEntry('name', name),
        MapEntry('description', description),
        MapEntry('dateOfEvent', dateOfEvent),
        MapEntry('closeListAt', endListsOpens),
      ]);

      final mimeType = lookupMimeType(image.path);
      if (mimeType != null && mimeType.startsWith('image/')) {
        final bytes = await image.readAsBytes();
        final file = dio.MultipartFile.fromBytes(
          bytes,
          filename: image.path.split('/').last,
          contentType: MediaType.parse(mimeType),
        );
        formData.files.add(MapEntry('images', file));
      } else {
        throw Exception('Invalid image file type');
      }

      final options = dio.Options(
        headers: {
          'Accept': 'application/json',
        },
        followRedirects: true,
        validateStatus: (status) => status! < 500,
      );

      final res = await _baseApiService.formDataWithOptions(
          '/events', formData, options);
      return EventDTO.fromJson(res.data as Map<String, dynamic>);
    });
  }

  @override
  Future deleteEvent(String eventId) async {
    return await apiMethodWrapper(() async {
      await _baseApiService.delete('/admin/events/$eventId');
    });
  }
}
