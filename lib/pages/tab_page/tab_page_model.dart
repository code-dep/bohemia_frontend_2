import 'package:bohemia/pages/home_page/home_page.dart';
import 'package:bohemia/pages/my_list_page/my_lists_page.dart';
import 'package:bohemia/pages/tab_page/bottom_navigation_tab_page_model.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabPageModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final IUserService _userService = Get.find();

  Rx<int> currentIndex = Rx(0);
  Rx<bool> isQrCodeButtonVisible = Rx(false);
  Rx<bool> isCreateEventButtonVisible = Rx(false);
  Rx<List<BottomNavigationTabPageModel>> pages = Rx([]);

  final Map<String, BottomNavigationTabPageModel> _bottomNavigationTabs =
      <String, BottomNavigationTabPageModel>{};

  TabPageModel() {
    loadDefaultPages();
  }

  RxBool get isAdmin => _userService.getUser()!.isAdmin ? true.obs : false.obs;

  void loadDefaultPages() {
    _bottomNavigationTabs[EVENT_TAB_IDENTIFIER] = BottomNavigationTabPageModel(
      tabId: EVENT_TAB_IDENTIFIER,
      icon: Icons.library_music_outlined,
      page: HomePage(),
      title: "Eventi",
      isQrCodeButtonVisible: _userService.getUser()!.isAdmin,
      isCreateEventButtonVisible: _userService.getUser()!.isAdmin,
    );
    _bottomNavigationTabs[EVENTLISTS_TAB_IDENTIFIER] =
        BottomNavigationTabPageModel(
      tabId: EVENTLISTS_TAB_IDENTIFIER,
      icon: Icons.list_alt_outlined,
      page: MyListsPage(),
      title: isAdmin.value ? "Contabilità" : "Le Mie Liste",
      isQrCodeButtonVisible: false,
      isCreateEventButtonVisible: false,
    );

    pages.value = _bottomNavigationTabs.values.toList();
    pages.refresh();
  }

  void setNewCurrentIndex(int index) {
    isQrCodeButtonVisible.refresh();
    isCreateEventButtonVisible.refresh();

    FocusScope.of(Get.context!).requestFocus(FocusNode());
    currentIndex.value = index;
    currentIndex.refresh();
  }

  Widget getWidgetForCurrentIndex() {
    return pages.value[currentIndex.value].page!;
  }
}
