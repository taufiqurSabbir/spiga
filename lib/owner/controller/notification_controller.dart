import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../api/api_post_calls.dart';
import '../../dialogue/Dialogue.dart' as MyDialogue;
import '../model/User.dart';


class NotificationControllerOwner extends GetxController {
    final isAll = true.obs;
    List<User> users = [];
    final RxList<MultiSelectItem<User>> items = RxList<MultiSelectItem<User>>();


    getUsers() async {
      await Future.delayed(Duration.zero);

      MyDialogue.Dialogue.showLoadingDialog();

      var response = await ApiGetCalls.getApiResponse(Api.userListApi);
      if (response.statusCode == 200) {
        // Handle the response JSON data as needed


        var data = json.decode(response.body);

        if (data.length > 0) {
          for (var i = 0; i < data.length; i++) {
            users.add(User.fromJson(data[i]));
          }
        }

        print('Response data: ${response.body}');


        items.addAll(users.map((user) => MultiSelectItem<User>(user, user.name!)).toList());
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }

      MyDialogue.Dialogue.dismissLoadingDialog();

    }

    sendNotification(String notificationTitle, String notificationBody, String role, List<int> user_id_list) async{
      MyDialogue.Dialogue.showLoadingDialog();

      try{
        var response = await ApiPostCalls.postApiResponse(Api.notificationApi,{'type':role,'user_id':user_id_list,'body':notificationBody,'title':notificationTitle});
        if (response.statusCode == 200) {
          // Handle the response JSON data as needed


          var data = json.decode(response.body);

          if(data['success']=='Notification sent successfully'){
            Fluttertoast.showToast(
                msg: "Notification envoyée avec succès.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 14.0
            );
          }else{
            Fluttertoast.showToast(
                msg: "Quelque chose s'est mal passé.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 14.0
            );
          }


        }
        else {
          Fluttertoast.showToast(
              msg: "Quelque chose s'est mal passé.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 14.0
          );
        }
      }catch(e){
        Fluttertoast.showToast(
            msg: "Quelque chose s'est mal passé.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0
        );
      }


      MyDialogue.Dialogue.dismissLoadingDialog();
    }
}