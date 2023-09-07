import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart'  as storage;

import '../../api/api.dart';
import '../../api/api_post_calls.dart';
import '../model/Order.dart';
import '../screen/we_are_preparing_your_order.dart';

class CartController extends GetxController {

  //Temporary
  final temp_quantity = 0.obs;
  final temp_price = 0.0.obs;
  final temp_totalPrice = 0.0.obs;


  //Cart
  final quantity = 0.obs;
  final price = 0.0.obs;
  final totalPrice = 0.0.obs;

  final food_id = 0.obs;
  final payment_status = Rx<int?>(null);
  final order_id = Rx<int?>(null);
  final food_image = "".obs;
  final thumbnail_image = "".obs;
  final list_image = "".obs;
  final food_name = "".obs;
  final pickUp_date = "".obs;
  final pickUp_time = "".obs;
  final customer_pickUp_time = "".obs;

  final customer_pickUp_time_from = "".obs;
  final customer_pickUp_time_to = "".obs;


  @override
  void onInit() {
    super.onInit();

    // Load the data
    loadData();

    // Add listeners for each observable variable
    ever(quantity, (_) => saveData());
    ever(price, (_) => saveData());
    ever(totalPrice, (_) => saveData());
    ever(food_id, (_) => saveData());
    ever(payment_status, (_) => saveData());
    ever(order_id, (_) => saveData());
    ever(food_image, (_) => saveData());
    ever(thumbnail_image, (_) => saveData());
    ever(list_image, (_) => saveData());
    ever(food_name, (_) => saveData());
    ever(pickUp_date, (_) => saveData());
    ever(pickUp_time, (_) => saveData());
    ever(customer_pickUp_time, (_) => saveData());
    ever(customer_pickUp_time_from, (_) => saveData());
    ever(customer_pickUp_time_to, (_) => saveData());


  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('quantity', quantity.value.toString());
    prefs.setString('price', price.value.toString());
    prefs.setString('totalPrice', totalPrice.value.toString());
    prefs.setString('food_id', food_id.value.toString());
    prefs.setString('payment_status', payment_status.value?.toString() ?? "");
    prefs.setString('order_id', order_id.value?.toString() ?? "");
    prefs.setString('food_image', food_image.value);
    prefs.setString('thumbnail_image', thumbnail_image.value);
    prefs.setString('list_image', list_image.value);
    prefs.setString('food_name', food_name.value);
    prefs.setString('pickUp_date', pickUp_date.value);
    prefs.setString('pickUp_time', pickUp_time.value);
    prefs.setString('customer_pickUp_time', customer_pickUp_time.value);
    prefs.setString('customer_pickUp_time_from', customer_pickUp_time_from.value);
    prefs.setString('customer_pickUp_time_to', customer_pickUp_time_to.value);
  }



  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    quantity.value = int.parse(prefs.getString('quantity') ?? '0');
    price.value = double.parse(prefs.getString('price') ?? '0.0');
    totalPrice.value = double.parse(prefs.getString('totalPrice') ?? '0.0');
    food_id.value = int.parse(prefs.getString('food_id') ?? '0');

    String? paymentStatusString = prefs.getString('payment_status');
    payment_status.value = paymentStatusString != null && paymentStatusString.isNotEmpty ? int.parse(paymentStatusString) : null;

    String? orderIdString = prefs.getString('order_id');
    order_id.value = orderIdString != null && orderIdString.isNotEmpty ? int.parse(orderIdString) : null;

    food_image.value = prefs.getString('food_image') ?? '';
    thumbnail_image.value = prefs.getString('thumbnail_image') ?? '';
    list_image.value = prefs.getString('list_image') ?? '';
    food_name.value = prefs.getString('food_name') ?? '';
    pickUp_date.value = prefs.getString('pickUp_date') ?? '';
    pickUp_time.value = prefs.getString('pickUp_time') ?? '';
    customer_pickUp_time.value = prefs.getString('customer_pickUp_time') ?? '';
    customer_pickUp_time_from.value = prefs.getString('customer_pickUp_time_from') ?? '';
    customer_pickUp_time_to.value = prefs.getString('customer_pickUp_time_to') ?? '';
  }

  reset() async{
    temp_quantity.value =  0;
    temp_price.value =  0.0;
    temp_totalPrice.value =  0.0;



    quantity.value = 0;
    price.value = 0.0;
    totalPrice.value = 0.0;
    food_id.value = 0;
    payment_status.value = null;
    order_id.value = null;
    food_image.value = "";
    thumbnail_image.value = "";
    list_image.value = "";
    food_name.value = "";
    pickUp_date.value = "";
    pickUp_time.value = "";
    customer_pickUp_time.value = "";
    customer_pickUp_time_from.value = "";
    customer_pickUp_time_to.value = "";
  }

  resetValuesAfterPayment() async {
    temp_quantity.value = 0;
    temp_price.value = 0.0;
    temp_totalPrice.value = 0.0;


    quantity.value = 0;
    price.value = 0.0;
    totalPrice.value = 0.0;
  }

  getTmpTotalPrice() async {
    temp_totalPrice.value = temp_quantity.value.toDouble() * temp_price.value;
  }

  getTotalPrice() async {
    totalPrice.value = quantity.value.toDouble() * price.value;
  }


  placeOrderStripe(String transactionID) async {

    Data data = Data(
      foodId: food_id.value,
      quantity: quantity.value,
      paymentStatus: 1,
      transactionId: transactionID,
      customerPickUpTimeFrom: customer_pickUp_time_from.value,
      customerPickUpTimeTo: customer_pickUp_time_to.value,
    );

    Map<String, dynamic> dataMap = data.toJson();

    var response = await ApiPostCalls.postApiResponse(Api.orderPlacementApi, dataMap);

    return response;


  }


  placeOrderCash() async {

    Data data = Data(
      foodId: food_id.value,
      quantity: quantity.value,
      paymentStatus: 0,
      transactionId: null,
      customerPickUpTimeFrom: customer_pickUp_time_from.value,
      customerPickUpTimeTo: customer_pickUp_time_to.value,
    );

    print("data: ${data.toJson()}");
    Map<String, dynamic> dataMap = data.toJson();

    var response = await ApiPostCalls.postApiResponse(Api.orderPlacementApi, dataMap);

    return response;


  }

  placeOrderTicket() async {

    Data data = Data(
      foodId: food_id.value,
      quantity: quantity.value,
      paymentStatus: 3,
      transactionId: null,
      customerPickUpTimeFrom: customer_pickUp_time_from.value,
      customerPickUpTimeTo: customer_pickUp_time_to.value,
    );

    Map<String, dynamic> dataMap = data.toJson();

    var response = await ApiPostCalls.postApiResponse(Api.orderPlacementApi, dataMap);

    return response;


  }

}