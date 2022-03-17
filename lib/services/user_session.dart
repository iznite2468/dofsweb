import 'package:dofsweb/models/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  Future<void> setSession(UserPreferences data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('USER_ACCESS_ID', data.userAccessId!);
    await pref.setString('NAME', data.fullName!);
    await pref.setString('USERNAME', data.username!);
    await pref.setInt('USER_LEVEL_ID', data.userLevelId!);
    await pref.setString('TOKEN', data.token!);
  }

  Future<UserPreferences?> getSession() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getString('TOKEN') != null) {
      return UserPreferences(
        userAccessId: pref.getInt('USER_ACCESS_ID'),
        fullName: pref.getString('NAME'),
        username: pref.getString('USERNAME'),
        userLevelId: pref.getInt('USER_LEVEL_ID'),
        token: pref.getString('TOKEN'),
      );
    } else {
      return null;
    }
  }

  Future<void> clearSession() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('USER_ACCESS_ID');
    await pref.remove('NAME');
    await pref.remove('USERNAME');
    await pref.remove('USER_LEVEL_ID');
    await pref.remove('TOKEN');
  }
}
