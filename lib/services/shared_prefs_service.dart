import 'package:local_data_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  SharedPrefsService._internal();
  static final SharedPrefsService instance = SharedPrefsService._internal();

  static const String _userKey = 'user';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user.name);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_userKey);
    return name != null ? User(name: name) : null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
