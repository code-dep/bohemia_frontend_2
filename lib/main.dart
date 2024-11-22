import 'package:bohemia/app_theme.dart';
import 'package:bohemia/controllers/event_lists_data_controller.dart';
import 'package:bohemia/controllers/events_data_controller.dart';
import 'package:bohemia/controllers/subscription_controller.dart';
import 'package:bohemia/controllers/user_data_controller.dart';
import 'package:bohemia/firebase_options.dart';
import 'package:bohemia/main_models.dart';
import 'package:bohemia/pages/event_details_page/event_details_page_model.dart';
import 'package:bohemia/pages/home_page/home_page.dart';
import 'package:bohemia/pages/home_page/home_page_model.dart';
import 'package:bohemia/pages/login_page/login_page.dart';
import 'package:bohemia/pages/my_list_page/my_lists_page_model.dart';
import 'package:bohemia/pages/new_event_page/new_event_page_model.dart';
import 'package:bohemia/services/api/implementations/base_api_service.dart';
import 'package:bohemia/services/api/implementations/event_list_api_service.dart';
import 'package:bohemia/services/api/implementations/events_api_service.dart';
import 'package:bohemia/services/api/implementations/notification_api_service.dart';
import 'package:bohemia/services/api/implementations/user_api_service.dart';
import 'package:bohemia/services/api/interfaces/i_base_api_service.dart';
import 'package:bohemia/services/api/interfaces/i_event_list_service.dart';
import 'package:bohemia/services/api/interfaces/i_events_api_service.dart';
import 'package:bohemia/services/api/interfaces/i_notification_service.dart';
import 'package:bohemia/services/api/interfaces/i_user_api_service.dart';
import 'package:bohemia/services/business/implementations/event_list_service.dart';
import 'package:bohemia/services/business/implementations/event_service.dart';
import 'package:bohemia/services/business/implementations/user_service.dart';
import 'package:bohemia/services/business/interfaces/i_event_list_service.dart';
import 'package:bohemia/services/business/interfaces/i_event_service.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:bohemia/services/ui_services/implementations/loader_service.dart';
import 'package:bohemia/services/ui_services/interfaces/i_loader_service.dart';
import 'package:bohemia/services/utility_services/implementations/developer_service.dart';
import 'package:bohemia/services/utility_services/implementations/notification_service.dart';
import 'package:bohemia/services/utility_services/implementations/password_service.dart';
import 'package:bohemia/services/utility_services/implementations/sharedpreferences_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_developer_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_notification_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_password_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_sharedpreferences_service.dart';
import 'package:bohemia/services/validators/implementations/user_validator_service.dart';
import 'package:bohemia/services/validators/interfaces/i_user_validator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Register utility services
  await registerUtilityServices();
  registerControllers();
  // Register API services
  registerApiServices();

  // Register business services and controllers
  await registerServices();

  // Initialize the notification service
  await Get.find<INotificationService>().initialize();
  // Register validators and pages
  registerValidators();
  registerPages();

  // Run the app
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final MainModel _model = MainModel();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: FutureBuilder<Widget>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data ?? const Scaffold();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        future: _model.getInitialScreen(),
      ),
    );
  }
}

Future<void> registerUtilityServices() async {
  // Register all utility services here
  Get.put<IDeveloperService>(DeveloperService());

  await Get.find<IDeveloperService>().registerSharedPrefService();

  Get.put<IPasswordService>(PasswordService());
}

void registerControllers() {
  Get.put(UserDataController());
  Get.put(EventsDataController());
  Get.put(EventListsDataController());
  Get.put<IBaseApiService>(BaseApiService("https://bohemia.deplab.it"));
  Get.put<IEventListApiService>(EventListApiService());
  Get.put<IEventListService>(EventListService());
  Get.put(SubscriptionController());
}

void registerApiServices() {
  // Register all API services here

  Get.put<IUserApiService>(UserApiService());
  Get.put<IEventsApiService>(EventsApiService());

  Get.put<INotificationApiService>(NotificationApiService());
}

Future<void> registerServices() async {
  // Register all business services here

  Get.put<ILoaderService>(LoaderService());
  Get.put<ISharedpreferencesService>(SharedpreferencesService());

  Get.put<IUserService>(UserService());
  Get.put<IEventService>(EventService());

  Get.put<INotificationService>(NotificationService());
}

void registerValidators() {
  // Register all validators here

  Get.put<IUserValidatorService>(UserValidatorService());
}

void registerPages() {
  // Register all pages here

  Get.put(LoginPage());
  Get.put(HomePageModel());
  Get.put(HomePage());
  Get.put(NewEventPageModel());
  Get.put(MyListsPageModel());
  Get.put(EventDetailsPageModel());
}
