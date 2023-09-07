import 'dart:convert';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../model/Allergy.dart';
import '../model/FoodCat.dart' as FoodCat;


class DetailsPageControllerOwner extends GetxController {

  final showLoader = true.obs;

  final storeId  = "".obs;
  final storeName  = "".obs;
  final storeAddress = "".obs;

  final foodCatName = "".obs;

  final allergyArray=<Allergy>[].obs;
  final foodCatArray=<FoodCat.Data>[].obs;



  getStoreDetails() async {
      storeId.value =  (await getStoreId())!;
      storeName.value =  (await getStoreName())!;
      storeAddress.value =  (await getStoreAddress())!;

    }

    getAllergy(String allergies) async {

    if(allergies != null && allergies.isNotEmpty) {
      showLoader.value = true;
      allergyArray.value = [];

      List<int> allergyIds = allergies
          .split(',')
          .map((String number) => int.parse(number))
          .toList();


      var response = await ApiGetCalls.getApiResponse(Api.allergyApi);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Handle the response JSON data as needed


        var data = json.decode(response.body);
        print(data);

        if (data["data"].length > 0) {
          for (var i = 0; i < allergyIds.length; i++) {
            for (var j = 0; j < data["data"].length; j++) {
              if (allergyIds[i] == data["data"][j]["id"]) {
                allergyArray.add(Allergy.fromJson(data["data"][j]));
              }
            }
          }
        }

        showLoader.value = false;

        print('Response data: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }

    }


    getFoodCatName(String foodCatId) async {
      foodCatArray.clear();


      if(foodCatId != null && foodCatId.isNotEmpty) {
        List<int> catIds = foodCatId
            .split(',')
            .map((String number) => int.parse(number))
            .toList();


        var response = await ApiGetCalls.getApiResponse(Api.foodCatApi);

        if (response.statusCode == 200) {
          // Handle the response JSON data as needed


          var data = json.decode(response.body);

          if (data["data"].length > 0) {
            for (var i = 0; i < catIds.length; i++) {
              for (var j = 0; j < data["data"].length; j++) {
                if (catIds[i] == data["data"][j]["id"]) {
                  foodCatArray.add(FoodCat.Data.fromJson(data["data"][j]));
                }
              }
            }
          }

          showLoader.value = false;

          print('Response data: ${response.body}');
        }
        else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }
    }

  void launchGoogleMaps(String address) async {
    Uri  googleMapsUrl = Uri.parse('https://www.google.com/maps?q=$address');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

}