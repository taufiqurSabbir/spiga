import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getStoreId() async {
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  return prefs.getString('saved_boutique_id');
}

Future<String?> getStoreName() async {
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  return prefs.getString('saved_boutique_name');
}


Future<String?> getStoreOpeningTime() async {
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  return prefs.getString('saved_boutique_opening_time');
}

Future<String?> getStoreClosingTime() async {
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  return prefs.getString('saved_boutique_closing_time');
}


Future<String?> getStoreAddress() async {
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  return prefs.getString('saved_boutique_address');
}