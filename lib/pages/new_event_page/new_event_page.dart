import 'package:bohemia/dto/common/event_dto.dart';
import 'package:bohemia/pages/new_event_page/new_event_page_model.dart';
import 'package:bohemia/widgets/button/custom_button.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:bohemia/widgets/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewEventPage extends StatelessWidget {
  final EventDTO? event;
  final NewEventPageModel _model = NewEventPageModel();

  NewEventPage({super.key, this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crea Evento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _model.formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: _model.pickImage,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Obx(
                      () => _model.selectedImage.value != null
                          ? Image.file(
                              _model.selectedImage.value!,
                              fit: BoxFit.cover,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate_outlined,
                                    size: 50),
                                SizedBox(height: 8),
                                Text('Aggiungi immagine evento'),
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: _model.eventNameController,
                  obscureText: false,
                  hintText: 'Event Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Event Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: _model.eventDescriptionController,
                  obscureText: false,
                  hintText: 'Event Description',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Event Description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CustomTextfield(
                    controller: TextEditingController(
                        text: _model.formatDateTime(_model.dateOfEvent.value)),
                    obscureText: false,
                    hintText: 'Data dell\'evento',
                    onTap: () => _model.pickEventDate(context),
                    validator: (value) {
                      if (_model.dateOfEvent.value == null) {
                        return 'Date of Event is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CustomTextfield(
                    controller: TextEditingController(
                        text:
                            _model.formatDateTime(_model.endListsOpens.value)),
                    obscureText: false,
                    hintText: 'Data di Chiusura delle liste',
                    onTap: () => _model.pickEndListsOpensDate(context),
                    validator: (value) {
                      if (_model.endListsOpens.value == null) {
                        return 'End Lists Opens is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () async {
                          if (_model.formKey.currentState!.validate() &&
                              _model.selectedImage.value != null) {
                            await _model.createEvent();
                          } else if (_model.selectedImage.value == null) {
                            CustomSnackbar.show(
                              title: 'Errore',
                              message: 'Please select an image',
                            );
                          }
                        },
                        text: 'Create Event',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
