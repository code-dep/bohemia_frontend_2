// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

const String EVENT_TAB_IDENTIFIER = "EVENT_TAB_IDENTIFIER";
const String EVENTLISTS_TAB_IDENTIFIER = "EVENTLISTS_TAB_IDENTIFIER";

class BottomNavigationTabPageModel {
  final String? tabId;
  final IconData? icon;
  final Widget? page;
  final String? title;
  final bool? isQrCodeButtonVisible;
  final bool? isCreateEventButtonVisible;

  const BottomNavigationTabPageModel({
    this.tabId,
    this.icon,
    this.page,
    this.title,
    this.isQrCodeButtonVisible,
    this.isCreateEventButtonVisible,
  });
}
