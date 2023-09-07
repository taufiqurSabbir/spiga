import 'dart:convert';

import 'package:laspigadoro/api/api.dart';
import 'package:laspigadoro/api/api_get_calls.dart';
import 'package:laspigadoro/client/model/Food.dart';
import 'package:laspigadoro/client/model/Order_history.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

class NotificationClientOnOrderStatusChangeControllerController extends GetxController {
  final showLoader = true.obs;
  // Rx<Order_History?> orderHistory = Rx(null);
  Order_History? order_history;

  List<OrdersWithOrderDateInDateTimeObj> orders = <OrdersWithOrderDateInDateTimeObj>[];
  List<Food> foodArry = <Food>[];
  List<String> foodName = <String>[];
  List<dynamic> price = <dynamic>[];
  List<String> image = <String>[];




  getOrderHistoryById(int  foodId)async{

    showLoader.value = true;
    orders = <OrdersWithOrderDateInDateTimeObj>[];
    foodArry = <Food>[];
    foodName = <String>[];
    price = <dynamic>[];
    image = <String>[];



    var response1 = await ApiGetCalls.getApiResponse(Api.clintOrderHistoryApi);
    if (response1.statusCode == 200) {
      // Handle the response JSON data as needed

      var data = json.decode(response1.body);

      if (data != null) {
        order_history = Order_History.fromJson(data);
      }


      print('Response data: ${response1.body}');
      for(int i=0;i<order_history!.orders!.length;i++){
        if(order_history!.orders![i].id == foodId){
          orders.add(OrdersWithOrderDateInDateTimeObj(
            order_history!.orders![i].id,
            order_history!.orders![i].foodId,
            order_history!.orders![i].customerName,
            order_history!.orders![i].paymentStatus,
            order_history!.orders![i].pickupTime,
            DateTime.parse(order_history!.orders![i].orderDate!),
            order_history!.orders![i].createdAt,
            order_history!.orders![i].updatedAt,
            order_history!.orders![i].quantity,
            order_history!.orders![i].userId,
            order_history!.orders![i].transactionId,
            order_history!.orders![i].orderStatus,
            order_history!.orders![i].order,
            order_history!.orders![i].netPrice,
            order_history!.orders![i].totalPrice,
            order_history!.orders![i].customerPickupTimeFrom,
            order_history!.orders![i].customerPickupTimeTo,
            order_history!.orders![i].refundId
          ));

          break;
        }

      }


      orders.sort((a, b) => b.orderDate!.compareTo(a.orderDate!));



      var response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.length > 0) {
          for (var i = 0; i < data.length; i++) {
            foodArry.add(Food.fromJson(data[i]));
          }
        }
        for (var i = 0; i < orders.length; i++) {
          for (var j = 0; j < foodArry.length; j++) {
            if (foodArry[j].id == orders[i].foodId) {
              foodName.add(foodArry[j].foodName!);
              price.add(foodArry[j].price!);
              image.add(foodArry[j].foodImage!);
            }
          }
        }

        showLoader.value = false;

      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }


}