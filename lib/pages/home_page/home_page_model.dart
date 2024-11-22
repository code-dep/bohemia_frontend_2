import 'package:bohemia/controllers/events_data_controller.dart';
import 'package:bohemia/controllers/subscription_controller.dart';
import 'package:bohemia/dto/common/event_dto.dart';
import 'package:bohemia/dto/common/event_list_dto.dart';
import 'package:bohemia/dto/response/events_response_dto.dart';
import 'package:bohemia/pages/event_details_page/event_details_page.dart';
import 'package:bohemia/pages/new_event_page/new_event_page.dart';
import 'package:bohemia/services/business/interfaces/i_event_list_service.dart';
import 'package:bohemia/services/business/interfaces/i_event_service.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:get/get.dart';

class HomePageModel extends GetxController {
  final IEventService _eventService = Get.find();
  final IEventListService _eventListService = Get.find();
  final IUserService _userService = Get.find();

  bool get isAdmin => _userService.getUser()!.isAdmin;
  final RxBool isSubscribed = false.obs;

  // Observable for events data
  final Rx<EventsResponseDTO?> eventsData = Rx<EventsResponseDTO?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getInitialData();

    ever(Get.find<EventsDataController>().events, (_) {
      getInitialData();
    });
  }

  Future<void> getInitialData() async {
    try {
      isLoading.value = true;
      final events = await _eventService.fetchEvents();
      eventsData.value = events;
    } catch (e) {
      CustomSnackbar.show(
        title: 'Error',
        message: 'Errore durante il caricamento degli eventi',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _eventService.deleteEvent(eventId);
      CustomSnackbar.show(
        title: 'Success',
        message: 'Evento eliminato con successo',
      );
      await getInitialData();
    } catch (e) {
      CustomSnackbar.show(
        title: 'Error',
        message: 'Errore durante l\'eliminazione dell\'evento',
      );
    }
  }

  Future<void> editEvent(EventDTO event) async {
    final result = await Get.to(() => NewEventPage(event: event));
    if (result == true) {
      await getInitialData();
    }
  }

  Future<EventDetailsPage> goToEventDetailsPage(
    String eventId,
    String eventName,
    String eventDate,
    String eventImage,
  ) async {
    final subscriptionController = Get.find<SubscriptionController>();
    await subscriptionController.loadSubscribedLists();

    final isSubscribed = subscriptionController.isSubscribed(eventId);
    EventListDTO? currentEventList;

    if (isSubscribed) {
      currentEventList = subscriptionController
          .subscribedLists.value?.eventLists
          ?.firstWhere((list) => list.event_id == eventId);
    }

    return EventDetailsPage(
      eventId: eventId,
      name: eventName,
      date: eventDate,
      imageUrl: eventImage,
      isAlreadySubscribed: RxBool(isSubscribed),
      eventList: currentEventList,
    );
  }
}
