import 'package:fresh_dio/fresh_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = 'theme_mode';

class ThemeModeStorage implements TokenStorage<bool> {
  @override
  Future<void> delete() async {
    SharedPreferences.getInstance().then((sp) => sp.remove(kThemeModeKey));
  }

  @override
  Future<bool?> read() {
    return SharedPreferences.getInstance()
        .then((sp) => sp.getBool(kThemeModeKey));
  }

  @override
  Future<void> write(isDark) async {
    SharedPreferences.getInstance()
        .then((sp) => sp.setBool(kThemeModeKey, isDark));
  }
}
