import 'dart:convert';
import 'dart:ui';

import 'package:laspigadoro/api/api.dart';
import 'package:laspigadoro/api/api_get_calls.dart';
import 'package:laspigadoro/api/api_post_calls.dart';
import 'package:laspigadoro/owner/model/Food.dart';
import 'package:laspigadoro/owner/model/Order.dart';
import 'package:laspigadoro/owner/model/UserOrder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../dialogue/Dialogue.dart';
import '../mes_commandes_page_44.dart';


class OrderDetailsController extends GetxController {

  final showLoader = true.obs;
  // List<UserOrder> userArray = <UserOrder>[];
  Rx<UserOrder?> userOrder = Rx<UserOrder?>(null);
  Rx<Order?> myOrder = Rx<Order?>(null);
  // Order order = new Order();

  final isClicked = [false, false, false, false].obs;
  final clickedColors = [Colors.yellow, Colors.green, Colors.red, Colors.blue].obs;


  getOrders(int id) async{
    isClicked.value = [false, false, false, false].obs;
    clickedColors.value = [Colors.yellow, Colors.green, Colors.red, Colors.blue].obs;

    showLoader.value = true;

    var response = await ApiGetCalls.getApiResponse(Api.userOrderDetailsApi+id.toString());

    if(response.statusCode==200){
      var data = json.decode(response.body);

      userOrder.value= UserOrder.fromJson(data[0]);
      int index = userOrder.value!.orderStatus!;

      if(userOrder.value!.orderStatus!<=4) isClicked.value[userOrder.value!.orderStatus! - 1] = true;

      var food_offers_response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);
      if(food_offers_response.statusCode==200){
        var food_data = jsonDecode(food_offers_response.body);

        for(int i = 0; i< food_data.length; i++){
          if(food_data[i]['id']== userOrder.value?.foodId!){
            userOrder.value?.foodName = food_data[i]['food_name'];
            userOrder.value?.foodImage = food_data[i]['food_image'];
            userOrder.value?.pickupDateFrom = food_data[i]['pickup_date_from'];
            userOrder.value?.foodStock = food_data[i]['food_stock'].toString();


            print("pick up date => ${userOrder.value?.pickupDateFrom}");

            break;
          }
        }


      }


      showLoader.value = false;

    }else{
      print(response.statusCode);
    }
  }




  postOrders(bool showTost,int id, int? paymentStatus, int? orderStatus, int isClickedIndex) async {

    Dialogue.showLoadingDialog();

    var response = await ApiPostCalls.postApiResponse(Api.orderApi +"/update/status/"+id.toString(),
        {"payment_status": paymentStatus, "order_status": orderStatus});



    if (response.statusCode == 200) {
      // Handle the response JSON data as needed

      if(showTost==true) {
        Fluttertoast.showToast(
          msg: 'Le statut de la commande a changé.',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
        );
      }else{





      }


      var data = json.decode(response.body);


      print(data);
      //showLoader.value = false;
      print("object-----------------------------------------------------");
      print('Response data: ${response.body}');

      Dialogue.dismissLoadingDialog();

      if(isClickedIndex == 0){
        isClicked.value[0] = true;
        isClicked.value[1] = false;
        isClicked.value[2] = false;
        isClicked.value[3] = false;

      }else if(isClickedIndex == 1){
        isClicked.value[0] = true;
        isClicked.value[1] = true;
        isClicked.value[2] = false;
        isClicked.value[3] = false;
      }
      else if(isClickedIndex == 2){
        isClicked.value[0] = true;
        isClicked.value[1] = true;
        isClicked.value[2] = true;
        isClicked.value[3] = false;
      }
      else if(isClickedIndex == 3){
        isClicked.value[0] = true;
        isClicked.value[1] = true;
        isClicked.value[2] = true;
        isClicked.value[3] = true;
      }


    }
    else {
      Dialogue.dismissLoadingDialog();

      Fluttertoast.showToast(
        msg: "Quelque chose s'est mal passé",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );

    }


  }


  refund(int orderId) async{
    Dialogue.showLoadingDialog();

    try{
      var response = await ApiGetCalls.getApiResponse(Api.refundApi +"/"+orderId.toString());

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if(data['success']=='Order have been refunded successfully'){
          Fluttertoast.showToast(
              msg: "La commande a été remboursée avec succès.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0
          );

            }
        else if(data['error']!=null){
          Fluttertoast.showToast(
              msg: data['error'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 14.0
          );
        }
        else{
          Fluttertoast.showToast(
              msg: 'Quelque chose de mal s\'est produit.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 14.0
          );
        }
      }

    }
    catch(e){
      Fluttertoast.showToast(
          msg: 'Quelque chose de mal s\'est produit.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }


    Dialogue.dismissLoadingDialog();
  }


  cancle(int id, int? paymentStatus, int? orderStatus) async {

    Dialogue.showLoadingDialog();

    var response = await ApiPostCalls.postApiResponse(Api.orderApi +"/update/status/"+id.toString(),
        {"payment_status": paymentStatus, "order_status": orderStatus});



    if (response.statusCode == 200) {
      // Handle the response JSON data as needed


        Fluttertoast.showToast(
          msg: 'Le statut de la commande a changé.',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
        );


      print('Response data: ${response.body}');

      Dialogue.dismissLoadingDialog();


    }
    else {
      Dialogue.dismissLoadingDialog();

      Fluttertoast.showToast(
        msg: "Quelque chose s'est mal passé",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );

    }


  }


}