import 'package:bohemia/pages/my_list_page/my_lists_page_model.dart';
import 'package:bohemia/pages/qr_code_page/qr_code_page.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:bohemia/widgets/event_list_tile/event_list_tile.dart';
import 'package:bohemia/widgets/future_builder/api_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyListsPage extends GetView<MyListsPageModel> {
  const MyListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getInitialData();
        },
        child: Column(
          children: [
            Expanded(
              child: ApiFutureBuilder(
                future: controller.getInitialData(),
                onComplete: (data) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(
                      () {
                        if (controller.isAdmin) {
                          final groupedLists = controller.groupListsByEvent();

                          return ListView.builder(
                            itemCount: groupedLists.length,
                            itemBuilder: (context, index) {
                              final eventId =
                                  groupedLists.keys.elementAt(index);
                              final lists = groupedLists[eventId]!;
                              final totalUsers = lists.fold<int>(
                                0,
                                (sum, list) => sum + (list.user_count ?? 0),
                              );

                              return Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  backgroundColor: Colors.transparent,
                                  collapsedBackgroundColor: Colors.transparent,
                                  title: Text(
                                    lists.first.event_name ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text('Utenti Totali: $totalUsers'),
                                  children: lists
                                      .map(
                                        (list) => ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                list.name ?? '',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                'Utenti: ${list.user_count}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            itemCount: controller.subscribedLists.value
                                    ?.eventLists?.length ??
                                0,
                            itemBuilder: (context, index) {
                              final list = controller
                                  .subscribedLists.value?.eventLists![index];
                              return EventListTile(
                                userCount: controller.isPromoter
                                    ? list?.user_count.toString() ?? ''
                                    : null,
                                eventName: controller.isPromoter
                                    ? list?.name ?? ''
                                    : list?.event_name ?? '',
                                onTap: () {
                                  if (list?.status != 'confirmed' &&
                                      !controller.isPromoter) {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      transitionAnimationController:
                                          AnimationController(
                                        vsync: Navigator.of(context),
                                        duration:
                                            const Duration(milliseconds: 300),
                                      ),
                                      builder: (context) => QrCodeBottomSheet(
                                        eventName: list?.event_name ?? '',
                                        listId: list?.id ?? '',
                                        eventId: list?.event_id ?? '',
                                      ),
                                    );
                                  } else {
                                    if (!controller.isPromoter) {
                                      CustomSnackbar.show(
                                        title: 'Errore',
                                        message:
                                            'Questa lista è già confermata',
                                      );
                                    }
                                  }
                                },
                                name: controller.isPromoter
                                    ? list?.event_name ?? ''
                                    : list?.name ?? '',
                                showIcon: !controller.isPromoter,
                                isVerified: list?.status == 'confirmed',
                              );
                            },
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
