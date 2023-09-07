
import 'dart:convert';

import 'package:laspigadoro/api/api.dart';
import 'package:laspigadoro/api/api_get_calls.dart';

import 'package:laspigadoro/owner/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../api/api_post_calls.dart';
import '../../dialogue/Dialogue.dart';

class ProfilePageControllerOwner extends GetxController {

  final showLoader = true.obs;

  final order_notification = true.obs;
  final out_of_stock_notification = true.obs;

//  final  profileArray = <Profile>[].obs;
  Rx<Profile?> profile = Rx<Profile?>(null);


  getProfile() async {
    await Future.delayed(Duration.zero);

    showLoader.value = true;
    var response = await ApiGetCalls.getApiResponse(Api.profileApi);
    if (response.statusCode == 200) {


      // Handle the response JSON data as needed


      var data = json.decode(response.body);

      profile.value = Profile.fromJson(data["data"]);
      order_notification.value= profile.value?.orderNotification==0 ?false :true;
      out_of_stock_notification.value= profile.value?.outOfStockNotification==0 ?false :true;
      showLoader.value = false;
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }


  }
  postProfile(bool showTost, [ bool goBackScreen=true ]) async {
    Dialogue.showLoadingDialog();


    var response = await ApiPostCalls.postApiResponse(Api.profileApi +"/"+profile.value!.id.toString(), profile.value?.toJson());
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed
      Dialogue.dismissLoadingDialog();


      if(showTost==true) {
        Fluttertoast.showToast(
          msg: 'Une erreur s\'est produite',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
        );


      }
      else{

      }


      // var data = json.decode(response.body);
      //
      // // profile.value = Profile.fromJson(data["data"][0]);
      // print(data);
      // showLoader.value = false;

      if(goBackScreen == true) {
        getProfile();
        Get.back();
      }

      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');

      Dialogue.dismissLoadingDialog();

      Fluttertoast.showToast(
        msg: 'Désolé, quelque chose s\'est mal passé, veuillez réessayer',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }


  }


}