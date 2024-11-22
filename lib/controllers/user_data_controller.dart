import 'package:bohemia/dto/user_model.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserDataController {
  Rx<String?> userToken = Rx<String?>(null);
  Rx<UserModel?> user = Rx<UserModel?>(null);

  void decodeAndSetToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    user.value = UserModel.fromJson(payload);
  }
}
