import 'dart:convert';

import 'package:get/get.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../owner/model/Food.dart';

class NotificationOwnerOutOfStockController extends GetxController {
  final showLoader = true.obs;

  Food? publishAndDrafArray;
  FoodWithCreatedAtUpdatedAtInDateTimeObj? publishAndDrafArrayWithDateTimeObj;

  getPublishAndDrafList(int foodID) async {
    await Future.delayed(Duration.zero);

    showLoader.value = true;

    publishAndDrafArray = null;
    publishAndDrafArrayWithDateTimeObj = null;

    var response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
            if(data[i]["id"] == foodID) {
              publishAndDrafArray = Food.fromJson(data[i]);
          }
        }

        DateTime? createdAt = publishAndDrafArray!.createdAt != null ? DateTime.parse(publishAndDrafArray!.createdAt!) : null;
        DateTime? updatedAt = publishAndDrafArray!.updatedAt != null ? DateTime.parse(publishAndDrafArray!.updatedAt!) : null;

        FoodWithCreatedAtUpdatedAtInDateTimeObj foodWithDateTime = FoodWithCreatedAtUpdatedAtInDateTimeObj.fromJson(publishAndDrafArray!.toJson());
        foodWithDateTime.createdAt = createdAt;
        foodWithDateTime.updatedAt = updatedAt;

        publishAndDrafArrayWithDateTimeObj = foodWithDateTime;
      }

      showLoader.value = false;

    }
    else{
      showLoader.value = false;
    }


  }

  }