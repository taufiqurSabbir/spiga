import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getFcmId() async {
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  return prefs.getString('fcm_id');
}