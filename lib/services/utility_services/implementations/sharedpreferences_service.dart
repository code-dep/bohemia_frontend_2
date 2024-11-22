import 'package:bohemia/services/utility_services/interfaces/i_sharedpreferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferencesService implements ISharedpreferencesService {
  @override
  Future<String?> getToken() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('token');
    });
  }

  @override
  Future storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Future resetUserStoredCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
