import 'package:bohemia/dto/common/event_dto.dart';
import 'package:bohemia/pages/home_page/home_page_model.dart';
import 'package:bohemia/widgets/event_card/event_card.dart';
import 'package:bohemia/widgets/future_builder/api_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageModel> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.getInitialData(),
        child: Obx(() {
          if (controller.isLoading.value &&
              controller.eventsData.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = controller.eventsData.value?.events ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return GestureDetector(
                onLongPress: () {
                  if (controller.isAdmin) {
                    _showBottomSheet(context, event);
                  }
                },
                child: OpenContainer(
                  transitionDuration: const Duration(milliseconds: 500),
                  openBuilder: (context, action) {
                    return ApiFutureBuilder(
                      future: controller.goToEventDetailsPage(
                        event.ID!,
                        event.Name!,
                        event.DateOfEvent.toString(),
                        event.Images?.isNotEmpty == true
                            ? event.Images![0].ImageURL!
                            : 'https://via.placeholder.com/300x200/#e0e0e0/#000000?text=Placeholder',
                      ),
                      onComplete: (p0) => p0,
                    );
                  },
                  closedBuilder: (context, openContainer) => EventCard(
                    onTap: openContainer,
                    name: event.Name!,
                    imageUrl: event.Images?.isNotEmpty == true
                        ? event.Images![0].ImageURL!
                        : 'https://via.placeholder.com/300x200/#e0e0e0/#000000?text=Placeholder',
                    date: event.DateOfEvent.toString(),
                  ),
                  closedElevation: 0,
                  closedColor: Colors.transparent,
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, EventDTO event) {
    showModalBottomSheet(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Modifica evento'),
              onTap: () {
                Navigator.pop(context);
                controller.editEvent(event);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Elimina evento',
                  style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    title: const Text('Elimina evento'),
                    content: const Text(
                        'Sei sicuro di voler eliminare questo evento?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Annulla'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          controller.deleteEvent(event.ID!);
                        },
                        child: const Text('Elimina',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
