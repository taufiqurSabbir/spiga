import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getCartFoodId() async {
SharedPreferences prefs =  await SharedPreferences.getInstance();
return prefs.getString('cart_food_id');
}

Future<String?> getCartPaymentStatus() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('cart_payment_status');
}

Future<String?> getCartOrderId() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('cart_order_id');
}

Future<String?> getCartFoodImage() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('cart_food_image');
}

Future<String?> getCartFoodName() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('cart_food_name');
}

Future<String?> getCartPickUpTime() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('cart_pickUp_time');
}

Future<String?> getCartQuantity() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('cart_quantity');
}

Future<String?> getCartPrice() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('cart_price');
}

Future<String?> getCartTotalPrice() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('cart_totalPrice');
}
