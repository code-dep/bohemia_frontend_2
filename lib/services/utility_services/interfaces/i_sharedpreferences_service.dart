abstract class ISharedpreferencesService {
  Future storeToken(String token);
  Future<String?> getToken();
  Future resetUserStoredCredentials();
}
