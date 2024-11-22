import 'package:bohemia/dto/common/event_list_dto.dart';
import 'package:bohemia/pages/event_details_page/event_details_page_model.dart';
import 'package:bohemia/widgets/button/custom_button.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:bohemia/widgets/event_list_tile/event_list_tile.dart';
import 'package:bohemia/widgets/future_builder/api_future_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';

import 'dart:ui' as ui;

class EventDetailsPage extends StatelessWidget {
  final String eventId;
  final String name;
  final String date;
  final String imageUrl;
  final Rx<bool> isAlreadySubscribed;
  final EventListDTO? eventList;

  final EventDetailsPageModel _model = EventDetailsPageModel();

  EventDetailsPage(
      {super.key,
      required this.eventId,
      required this.name,
      required this.date,
      required this.imageUrl,
      required this.isAlreadySubscribed,
      this.eventList});

  @override
  Widget build(BuildContext context) {
    _model.init(eventId);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: ClipRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: 3.0,
                          sigmaY: 3.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Obx(
                            () => Text(
                              name,
                              style: TextStyle(
                                color: _model.textColor.value,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    titlePadding: EdgeInsets.zero,
                    background: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      imageBuilder: (context, imageProvider) {
                        _model.updateTextColor(imageProvider);
                        return Image(image: imageProvider, fit: BoxFit.cover);
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Obx(
                    () {
                      if (isAlreadySubscribed.value) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                'You are already subscribed to this event'),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Liste Disponibili',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Obx(
                                  () => _model.eventList.value == null
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: _model.eventList.value
                                                  ?.eventLists?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return EventListTile(
                                              userCount: _model.isPromoter.value
                                                  ? _model
                                                      .eventList
                                                      .value!
                                                      .eventLists![index]
                                                      .user_count
                                                      .toString()
                                                  : null,
                                              showIcon:
                                                  !_model.isPromoter.value,
                                              eventName: _model
                                                  .eventList
                                                  .value!
                                                  .eventLists![index]
                                                  .event_name!,
                                              name: _model.eventList.value!
                                                  .eventLists![index].name!,
                                              onTap: () async {
                                                if (!_model.isPromoter.value) {
                                                  final confirmed =
                                                      await _showAnimatedDialog(
                                                          context);

                                                  if (confirmed == true) {
                                                    var result = await _model
                                                        .subscribeToList(_model
                                                            .eventList
                                                            .value!
                                                            .eventLists![index]
                                                            .id!);
                                                    if (result) {
                                                      CustomSnackbar.show(
                                                        title: 'Success',
                                                        message:
                                                            'Iscrizione alla lista avvenuta con successo',
                                                      );
                                                      isAlreadySubscribed
                                                          .value = true;
                                                    }
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            Obx(() {
              if (_model.canCreateLists().value) {
                return ApiFutureBuilder(
                  future: _model.canCreateNewLists(eventId),
                  onComplete: (context) => Obx(() {
                    if (context.value) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.0),
                          child: CustomButton(
                            onPressed: () {
                              _model.createNewList(eventId);
                            },
                            text: 'Create New List',
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}

Future<bool?> _showAnimatedDialog(BuildContext context) {
  return showModal<bool>(
    context: context,
    configuration: const FadeScaleTransitionConfiguration(
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 300),
      reverseTransitionDuration: Duration(milliseconds: 200),
    ),
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text('Conferma Iscrizione'),
        content: Text(
          'Vuoi iscriverti a questa lista? Non sarai più in grado di cancellare l\'iscrizione.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancella'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Iscriviti'),
          ),
        ],
      );
    },
  );
}
