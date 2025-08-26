import 'package:fresh_dio/fresh_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAccessTokenKey = 'access_token';

class AccessTokenStorage implements TokenStorage<String> {
  @override
  Future<void> delete() async {
    SharedPreferences.getInstance().then((sp) => sp.remove(kAccessTokenKey));
  }

  @override
  Future<String?> read() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getString(kAccessTokenKey));
  }

  @override
  Future<void> write(token) async {
    SharedPreferences.getInstance()
        .then((sp) => sp.setString(kAccessTokenKey, token));
  }
}
