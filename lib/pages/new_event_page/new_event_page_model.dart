import 'dart:io';
import 'package:bohemia/controllers/events_data_controller.dart';
import 'package:bohemia/services/business/interfaces/i_event_service.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewEventPageModel {
  final IEventService _eventService = Get.find<IEventService>();

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final Rx<DateTime?> dateOfEvent = Rx<DateTime?>(null);
  final Rx<DateTime?> endListsOpens = Rx<DateTime?>(null);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      CustomSnackbar.show(
        title: 'Errore',
        message: 'Errore durante il caricamento dell\'immagine',
      );
      debugPrint(e.toString());
    }
  }

  Future<void> pickEventDate(BuildContext context) async {
    if (!context.mounted) return;

    final DateTime? picked = await showDatePicker(
      fieldHintText: "Scegli la data dell'evento",
      fieldLabelText: "Data dell'evento",
      helpText: "Scegli la data dell'evento",
      confirmText: "Conferma",
      cancelText: "Annulla",
      context: context,
      initialDate: dateOfEvent.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && context.mounted) {
      final TimeOfDay? time = await showTimePicker(
        helpText: "Scegli l'ora dell'evento",
        confirmText: "Conferma",
        cancelText: "Annulla",
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(dateOfEvent.value ?? DateTime.now()),
      );

      if (time != null && context.mounted) {
        dateOfEvent.value = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
      }
    }
  }

  Future<void> pickEndListsOpensDate(BuildContext context) async {
    if (!context.mounted) return;

    final DateTime? picked = await showDatePicker(
      fieldHintText: "Scegli la data di Chiusura delle liste",
      fieldLabelText: "Data di Chiusura delle liste",
      helpText: "Scegli la data di Chiusura delle liste",
      confirmText: "Conferma",
      cancelText: "Annulla",
      context: context,
      initialDate: endListsOpens.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && context.mounted) {
      final TimeOfDay? time = await showTimePicker(
        helpText: "Scegli l'ora di Chiusura delle liste",
        confirmText: "Conferma",
        cancelText: "Annulla",
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(endListsOpens.value ?? DateTime.now()),
      );

      if (time != null && context.mounted) {
        endListsOpens.value = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
      }
    }
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.toString().split(' ')[0]} ${TimeOfDay.fromDateTime(dateTime).format(Get.context!)}';
  }

  Future<void> createEvent() async {
    if (selectedImage.value == null ||
        dateOfEvent.value == null ||
        endListsOpens.value == null) {
      return;
    }

    try {
      await _eventService.createEvent(
        eventNameController.text,
        eventDescriptionController.text,
        dateOfEvent.value!,
        endListsOpens.value!,
        selectedImage.value!,
      );

      Get.find<EventsDataController>()
          .updateEvents(await _eventService.fetchEvents());
      Get.back();
    } catch (e) {
      CustomSnackbar.show(
        title: 'Errore',
        message: 'Errore durante la creazione dell\'evento',
      );
      rethrow;
    }
  }
}
