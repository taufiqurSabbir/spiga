import 'dart:convert';

import 'package:laspigadoro/api/api.dart';
import 'package:laspigadoro/api/api_get_calls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../api/api_post_calls.dart';
import '../../dialogue/Dialogue.dart';
import '../model/Profile_Client.dart';

class ProfileClientController extends GetxController {

  final showLoader = true.obs;



 // final  profileArray = <ProfileClient>[].obs;
 //  Rx<Profile?> profile = Rx<Profile?>(null);
  final push_notification = true.obs;
  Rx<ProfileClient?> profile = Rx<ProfileClient?>(null);


  getClientProfile() async {
    await Future.delayed(Duration.zero);

    showLoader.value = true;


    var response = await ApiGetCalls.getApiResponse(Api.clintProfileApi);
    if (response.statusCode == 200) {


      // Handle the response JSON data as needed


      var data = json.decode(response.body);
      push_notification.value= profile.value?.pushNotification==0 ?false :true;

      showLoader.value = false;
      print(data);
      if (data != null) {
        profile.value = ProfileClient.fromJson(data);
      } else {
        print('Response data is null!');
      }



      showLoader.value = false;
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }



  }

  postClientProfile(bool showTost, [ bool goBackScreen=true ]) async {
    Dialogue.showLoadingDialog();

    var response = await ApiPostCalls.postApiResponse(Api.clintProfileApi, profile.value?.toJson());

    var data = json.decode(response.body);

    print("response.statusCode => ${response.statusCode}");
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

      // profile.value = Profile.fromJson(data["data"][0]);
      //showLoader.value = false;

      if(goBackScreen == true) {
        getClientProfile();
        Get.back();
      }

      print('Response data: ${response.body}');
    } else {
      // print('Request failed with status: ${response.statusCode}.');
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