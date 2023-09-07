
import 'dart:convert';

import 'package:laspigadoro/api/api_get_calls.dart';
import 'package:laspigadoro/owner/model/Allergy.dart';
import 'package:laspigadoro/owner/model/Boutique.dart';
import 'package:laspigadoro/owner/model/Food.dart';
import 'package:laspigadoro/owner/model/Mystery.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../api/api.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';

import '../model/FoodCat.dart' as FoodCat;
import '../../dialogue/Dialogue.dart' as MyDialogue;


class PublishAndDraftShowController extends GetxController {
  final showLoader = true.obs;

  // //Rx<Profile?> profile = Rx<Profile?>(null);
  // Rx<Food?>PublishAndDrafArray = Rx<Food?>(null);

  final boutiqueArray = <Boutique>[].obs;
  List<Food> PublishAndDraEditfArray = <Food>[].obs;
  final tags=<Allergy>[].obs;
  final  allergyArray = <Allergy>[].obs;
  final  surpriseTypeArray = <Mystery>[].obs;
  final catTags=<FoodCat.Data>[].obs;
  final  foodCatArray = <FoodCat.Data>[].obs;


  getSurpriseType() async {
    await Future.delayed(Duration.zero);
    MyDialogue.Dialogue.showLoadingDialog();

    surpriseTypeArray.value = [];
    var response = await ApiGetCalls.getApiResponse(Api.surpriseApi);
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed


      var data = json.decode(response.body);

      if (data[0].length > 0) {
        for (var i = 0; i < data[0].length; i++) {
          print(data[0][i]);
          surpriseTypeArray.add(Mystery.fromJson(data[0][i]));
        }

          print(surpriseTypeArray);
        showLoader.value = false;

      }

      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    MyDialogue.Dialogue.dismissLoadingDialog();

  }

  getAllergy() async {
    await Future.delayed(Duration.zero);
    MyDialogue.Dialogue.showLoadingDialog();

    allergyArray.value =[];



    var response = await ApiGetCalls.getApiResponse(Api.allergyApi);
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed


      var data = json.decode(response.body);

      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
          print("Alergy Data");
          print(data["data"][i]);
          allergyArray.add(Allergy.fromJson(data["data"][i]));
        }


      }

      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    MyDialogue.Dialogue.dismissLoadingDialog();

  }

  getFoodCat() async {
    await Future.delayed(Duration.zero);
    MyDialogue.Dialogue.showLoadingDialog();

    foodCatArray.value = [];

    var response = await ApiGetCalls.getApiResponse(Api.foodCatApi);
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed


      var data = json.decode(response.body);
      print("data => ");
      print(data);
      print(data["data"].length);

      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
          foodCatArray.add(FoodCat.Data.fromJson(data["data"][i]));
        }
      }

      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    MyDialogue.Dialogue.dismissLoadingDialog();

  }




  getPublishAndDrafList() async {
    await Future.delayed(Duration.zero);

    PublishAndDraEditfArray = [];
    boutiqueArray.value = [];

    showLoader.value = true;

    var response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      print("Data Length: ${data.length}");
      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          PublishAndDraEditfArray.add(Food.fromJson(data[i]));
        }

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

          showLoader.value = false;

        }
      }
      else {
        print("Status Code: ${response.statusCode}");
      }
    }
  }

}

// getAllergy(String allergies) async {
//
//   showLoader.value = true;
//   allergyArray.value = [];
//
//   List<int> allergyIds = allergies
//       .split(',')
//       .map((String number) => int.parse(number))
//       .toList();
//
//
//   var response = await ApiGetCalls.getApiResponse(Api.allergyApi);
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     // Handle the response JSON data as needed
//
//
//     var data = json.decode(response.body);
//     print(data);
//
//     if (data["data"].length > 0) {
//       for(var i = 0; i < allergyIds.length; i++) {
//         for (var j = 0; j < data["data"].length; j++) {
//
//           if(allergyIds[i] == data["data"][j]["id"]){
//             allergyArray.add(Allergy.fromJson(data["data"][j]));
//           }
//         }
//
//       }
//
//
//
//
//
//     }
//
//     showLoader.value = false;
//
//     print('Response data: ${response.body}');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
//
//
//   print("Allergy: $allergies");
// }
