import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesServices {
  static SharedPreferences? prefs;
  static Future<void> initPreferences() async {
    try {
      prefs = await SharedPreferences.getInstance();
      print('Shared Preferences is initialized Successfully');
    } catch (e) {
      print('Failed to initialize Shared Preferences: $e');
    }
  }

  static bool get isOnBoardingSeen =>
      prefs!.getBool('isOnBoardingSeen') ?? false;
  static set isOnBoardingSeen(bool value) =>
      prefs!.setBool('isOnBoardingSeen', value);
}
