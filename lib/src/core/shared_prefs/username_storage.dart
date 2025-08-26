import 'package:fresh_dio/fresh_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kUsernameKey = 'user_name';

class UsernameStorage implements TokenStorage<String> {
  @override
  Future<void> delete() async {
    SharedPreferences.getInstance().then((sp) => sp.remove(kUsernameKey));
  }

  @override
  Future<String?> read() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getString(kUsernameKey));
  }

  @override
  Future<void> write(token) async {
    SharedPreferences.getInstance()
        .then((sp) => sp.setString(kUsernameKey, token));
  }
}
