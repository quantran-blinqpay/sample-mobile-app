import 'package:fresh_dio/fresh_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kProfileKey = 'profile';

class ProfileStorage implements TokenStorage<String> {
  @override
  Future<void> delete() async {
    SharedPreferences.getInstance().then((sp) => sp.remove(kProfileKey));
  }

  @override
  Future<String?> read() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getString(kProfileKey));
  }

  @override
  Future<void> write(token) async {
    SharedPreferences.getInstance()
        .then((sp) => sp.setString(kProfileKey, token));
  }
}
