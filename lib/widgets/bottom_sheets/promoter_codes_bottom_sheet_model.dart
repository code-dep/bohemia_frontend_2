import 'package:bohemia/dto/common/promoter_code_dto.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoterCodesBottomSheetModel {
  final IUserService _userService = Get.find();
  final TextEditingController codeController = TextEditingController();
  final RxList<PromoterCodeDTO> codes = <PromoterCodeDTO>[].obs;
  final RxList<PromoterCodeDTO> filteredCodes = <PromoterCodeDTO>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool canCreateCode = false.obs;

  PromoterCodesBottomSheetModel() {
    loadCodes();
    _setupCodeListener();
  }

  void _setupCodeListener() {
    codeController.addListener(() {
      _filterCodes();
      _updateCanCreateCode();
    });
  }

  void _filterCodes() {
    if (codeController.text.isEmpty) {
      filteredCodes.value = codes;
      return;
    }

    filteredCodes.value = codes
        .where((code) =>
            code.Code.toLowerCase().contains(codeController.text.toLowerCase()))
        .toList();
  }

  void _updateCanCreateCode() {
    if (codeController.text.isEmpty) {
      canCreateCode.value = false;
      return;
    }

    final codeExists = codes.any(
        (code) => code.Code.toLowerCase() == codeController.text.toLowerCase());

    canCreateCode.value = !codeExists;
  }

  Future<void> loadCodes() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      final response = await _userService.getPromoterCodes();
      codes.value = response.codes;
      filteredCodes.value = response.codes;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createCode() async {
    if (codeController.text.isEmpty || isLoading.value || !canCreateCode.value)
      return;

    try {
      isLoading.value = true;
      await _userService.createPromoterCode(codeController.text);
      codeController.clear();
      await loadCodes();
      CustomSnackbar.show(
        title: 'Success',
        message: 'Promoter code created successfully',
      );
    } catch (e) {
      CustomSnackbar.show(
        title: 'Error',
        message: 'Failed to create promoter code',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCode(String codeId) async {
    throw UnimplementedError();
  }

  void dispose() {
    codeController.removeListener(_setupCodeListener);
    codeController.dispose();
  }
}
