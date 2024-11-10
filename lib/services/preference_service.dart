import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  PreferenceService._privateConstructor();
  static final PreferenceService _instance = PreferenceService._privateConstructor();

  factory PreferenceService() {
    return _instance;
  }

  String isFirstLaunchKey = 'isFirstLaunch';

  Future<bool> isFirstLaunch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = preferences.getBool(isFirstLaunchKey) ?? true;
    return isFirstLaunch;
  }

  Future<void> setFirstLaunchCompleted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(isFirstLaunchKey, false);
  }
}
