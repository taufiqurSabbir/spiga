
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../model/Boutique.dart';
import '../model/Food.dart';

class PublishAndDraftControllerOwner extends GetxController {
  final showLoader = true.obs;

  // //Rx<Profile?> profile = Rx<Profile?>(null);
  // Rx<Food?>publishAndDrafArrayWithDateTimeObj = Rx<Food?>(null);

  final boutiqueArray = <Boutique>[].obs;
  List<Food> publishAndDrafArray = <Food>[].obs;
  List<FoodWithCreatedAtUpdatedAtInDateTimeObj> publishAndDrafArrayWithDateTimeObj = <FoodWithCreatedAtUpdatedAtInDateTimeObj>[].obs;



  getPublishAndDrafList() async {
    await Future.delayed(Duration.zero);

    publishAndDrafArray = [];
    publishAndDrafArrayWithDateTimeObj = [];

    boutiqueArray.value = [];

    showLoader.value = true;

    var response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      print(data);
      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          if(data[i]["is_delete"] == 0) {
            publishAndDrafArray.add(Food.fromJson(data[i]));
          }
        }

        print("Data Length: ${publishAndDrafArray.length}");

        for (var i = 0; i < publishAndDrafArray.length; i++) {
          Food food = publishAndDrafArray[i];
          DateTime? createdAt = food.createdAt != null ? DateTime.parse(food.createdAt!) : null;
          DateTime? updatedAt = food.updatedAt != null ? DateTime.parse(food.updatedAt!) : null;

          FoodWithCreatedAtUpdatedAtInDateTimeObj foodWithDateTime = FoodWithCreatedAtUpdatedAtInDateTimeObj.fromJson(food.toJson());
          foodWithDateTime.createdAt = createdAt;
          foodWithDateTime.updatedAt = updatedAt;

          publishAndDrafArrayWithDateTimeObj.add(foodWithDateTime);
        }

        publishAndDrafArrayWithDateTimeObj.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));



        response = await ApiGetCalls.getApiResponse(Api.boutiqueApi);
        if (response.statusCode == 200) {
          // Handle the response JSON data as needed

          final String? store_id = await getStoreId();

          var data = json.decode(response.body);

          if (data["data"].length > 0) {
            for (var i = 0; i < data["data"].length; i++) {
              boutiqueArray.add(Boutique.fromJson(data["data"][i]));
            }



          }
        }
      }
      else {
        print("Status Code: ${response.statusCode}");
      }


      showLoader.value = false;
    }
  }

}