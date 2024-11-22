import 'package:bohemia/widgets/bottom_sheets/promoter_codes_bottom_sheet_model.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:bohemia/widgets/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class PromoterCodesBottomSheet extends StatelessWidget {
  final PromoterCodesBottomSheetModel _model = PromoterCodesBottomSheetModel();

  PromoterCodesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    controller: _model.codeController,
                    hintText: 'Enter promoter code',
                    obscureText: false,
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() => IconButton(
                      onPressed: (_model.isLoading.value ||
                              !_model.canCreateCode.value)
                          ? null
                          : _model.createCode,
                      icon: _model.isLoading.value
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(
                              Icons.add,
                              color: _model.canCreateCode.value
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.38),
                            ),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => _model.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _model.filteredCodes.length,
                      itemBuilder: (context, index) {
                        final code = _model.filteredCodes[index];
                        return Dismissible(
                          resizeDuration: const Duration(milliseconds: 500),
                          key: ValueKey(code.ID),
                          background: Container(
                            color: Theme.of(context).colorScheme.primary,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.copy,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red[400],
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red[900],
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              await Clipboard.setData(
                                  ClipboardData(text: code.Code));
                              CustomSnackbar.show(
                                title: 'Success',
                                message: 'Code copied to clipboard',
                              );
                              return false;
                            }
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Code'),
                                  content: const Text(
                                      'Are you sure you want to delete this code?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              _model.deleteCode(code.ID);
                            }
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            title: Text(code.Code),
                            subtitle: Text(code.Used ? 'Used' : 'Available'),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
