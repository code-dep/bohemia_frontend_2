import 'package:animations/animations.dart';
import 'package:bohemia/pages/new_event_page/new_event_page.dart';
import 'package:bohemia/pages/profile_page/profile_page.dart';
import 'package:bohemia/pages/qr_code_scanner_page/qr_code_scanner_page.dart';
import 'package:bohemia/pages/tab_page/tab_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TabPage extends StatelessWidget {
  final TabPageModel _model = TabPageModel();

  TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: SvgPicture.asset(
          Theme.of(context).brightness == Brightness.dark
              ? "assets/images/Logo_dark.svg"
              : "assets/images/Logo_light.svg",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ProfilePage());
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Obx(
        () => PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _model.getWidgetForCurrentIndex(),
        ),
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: _model.isAdmin.value,
          child: Stack(
            children: [
              Positioned(
                bottom: 16,
                right: 0,
                child: FloatingActionButton(
                  heroTag: 'add',
                  onPressed: () {
                    Get.to(() => NewEventPage());
                  },
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Icon(Icons.add,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
              Positioned(
                bottom: 85,
                right: 0,
                child: FloatingActionButton(
                  heroTag: 'qr',
                  onPressed: () {
                    Get.to(() => QrCodeScannerPage());
                  },
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Icon(Icons.qr_code,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) => _model.setNewCurrentIndex(index),
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0,
          showUnselectedLabels: false,
          unselectedIconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.secondary),
          currentIndex: _model.currentIndex.value,
          items: _model.pages.value.map((el) {
            return BottomNavigationBarItem(
              icon: Icon(el.icon),
              label: el.title,
            );
          }).toList(),
        ),
      ),
    );
  }
}
