
import 'dart:convert';

import 'package:get/get.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';

class FoodStockController extends GetxController {
  int foodStock = -1.obs;
  final showLoader = true.obs;



  getFoodStock(int foodId) async{
    showLoader.value = true;

    var response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          if (data[i]["id"] == foodId) {
            foodStock =  data[i]["food_stock"];
            break;
          }
        }

        showLoader.value = false;
      }
      else{
        showLoader.value = false;
      }
    }
    else{
      showLoader.value = false;
    }
  }


}