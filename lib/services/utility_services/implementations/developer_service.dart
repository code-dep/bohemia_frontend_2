import 'package:bohemia/services/utility_services/interfaces/i_developer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeveloperService implements IDeveloperService {
  late SharedPreferences prefs;

  @override
  Future registerSharedPrefService() async {
    prefs = await SharedPreferences.getInstance();
  }
}
