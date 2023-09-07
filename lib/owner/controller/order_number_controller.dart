import 'dart:convert';

import 'package:get/get.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../dialogue/Dialogue.dart' as MyDialogue;


class OrderNumberController extends GetxController {
  final order_number = 0.obs;

  getOrderNumber() async{
    await Future.delayed(Duration.zero);
    MyDialogue.Dialogue.showLoadingDialog();

    order_number.value = 0;
    var response = await ApiGetCalls.getApiResponse(Api.orderApi);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      for(var i=0; i<data[0].length; i++){
        if(data[0][i]["order_status"] < 4){
          order_number.value ++;
        }
      }

    }

    MyDialogue.Dialogue.dismissLoadingDialog();

  }
}