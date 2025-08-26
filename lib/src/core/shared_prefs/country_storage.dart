import 'package:fresh_dio/fresh_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kUserCountryKey = 'user_country';

class CountryStorage implements TokenStorage<String> {
  @override
  Future<void> delete() async {
    SharedPreferences.getInstance().then((sp) => sp.remove(kUserCountryKey));
  }

  @override
  Future<String?> read() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getString(kUserCountryKey));
  }

  @override
  Future<void> write(v) async {
    SharedPreferences.getInstance()
        .then((sp) => sp.setString(kUserCountryKey, v));
  }
}
