import 'dart:convert';

import 'package:laspigadoro/client/model/Mystery.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../api/api_post_calls.dart';
import '../../helper/helper_function.dart';
import '../../login_page/login_page.dart';
import '../model/Allergy.dart';
import '../model/Food.dart';
import '../model/Mystery.dart' as Mystery;

import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../model/FoodCat.dart' as FoodCat;


class PanierSurpriseControllerOwner extends GetxController {
  final showLoader = true.obs;

  List<Food> mainPanierSurpriseFoodArray = [];

  final listeFoodArray = <Food> [].obs;
  final store_name = "".obs;




  //Filter
  final showFilterLoader = true.obs;

  final  allergyArray = <Allergy>[].obs;
  final tags=<Allergy>[].obs;

  final  surpriseArray = <Mystery.Mystery>[].obs;
  final surprise_selected = 0.obs;

  final foodCat = <FoodCat.Data>[].obs;
  final selectedFoodCat = [].obs;


  // It  will  be  store open at and close at
  Rx<String?> openAt = Rx<String?>(null);
  Rx<String?> closeAt = Rx<String?>(null);

  final minValue = 0.0.obs;
  final maxValue = 100.0.obs;

  final lowerValue = 0.0.obs;
  final higherValue = 100.0.obs;

  // Pick Up date
  // Today & Tomorrow
  // 0 means  nothing
  // 1 means  Today
  // 2  means Tomorrow
  final pickUpDate = 0.obs;
  final pickUpHourText = "Toute la journée".obs;


  getPanierSurprise() async {
    await Future.delayed(Duration.zero);

    showLoader.value = true;
    listeFoodArray.value = [];

    var response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);

    final String? store_id = await getStoreId();
    store_name.value = (await getStoreName())!;

    try{
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        print(data);
        if (data.length > 0) {
          for (var i = 0; i < data.length; i++) {


            if(
            data[i]["boutique_id"] == int.parse(store_id!) &&
                data[i]["food_type"] == 2 &&
                data[i]["hide_show"] == 1 &&
                data[i]["is_delete"] == 0
            ){

              String inputDate = data[i]["pickup_date_to"];

              // Parse the input date string in "YYYY-MM-DD" format
              DateTime parsedDate = DateTime.parse(inputDate);

              DateTime currentDate = DateTime.now();
              DateTime currentDateTime = DateTime(
                currentDate.year,
                currentDate.month,
                currentDate.day,
              );

              // Compare the parsed date with the current date
              int comparisonResult = parsedDate.compareTo(currentDateTime);

              if (comparisonResult >= 0) {
                print("The pickup to date is equal or greater than today's date.");

                Map<String, dynamic> api_data = data[i];
                api_data["image_orientation"] = await HelperFunction.checkImageOrientation(data[i]["food_image"]);

                listeFoodArray.add(Food.fromJson(api_data));


              }
            }
          }

          mainPanierSurpriseFoodArray = listeFoodArray.value;
          showLoader.value = false;


        }

        showLoader.value = false;

      }
      else{
        print("Status Code: ${response.statusCode}");
      }
    }
    catch(e){
      print(e);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', "");

      var response = await ApiPostCalls.postApiResponse(Api.logoutApi, {});


      Get.offAll(() => LoginPage());

    }

  }

  searchFromPanierSurprise(String searchText){
    String mySearchText = searchText.trim();

    List<Food> listeFoodArrayForSearch = listeFoodArray.value;

    print(mySearchText.length);

    if(mySearchText.length>0){

      listeFoodArray.value = [];

      for (var i=0; i<listeFoodArrayForSearch.length; i++){
        if(listeFoodArrayForSearch[i].foodName!.contains(mySearchText)){
          listeFoodArray.value.add(listeFoodArrayForSearch[i]);
        }
      }

    }
    else{

      listeFoodArray.value = [];
      listeFoodArray.value = mainPanierSurpriseFoodArray;

      print(listeFoodArray.value.length);
    }



  }

  getDataForFilter() async {
    showFilterLoader.value = true;

    allergyArray.value = [];
    surpriseArray.value = [];
    foodCat.value = [];

    // openAt.value = (await getStoreOpeningTime())!;
    // closeAt.value = (await getStoreClosingTime())!;

    openAt.value = "00:00";
    closeAt.value = "23:59";

    minValue.value = HelperFunction.parseTime(openAt.value!).millisecondsSinceEpoch.toDouble();
    maxValue.value = HelperFunction.parseTime(closeAt.value!).millisecondsSinceEpoch.toDouble();

    lowerValue.value = HelperFunction.parseTime(openAt.value!).millisecondsSinceEpoch.toDouble();
    higherValue.value = HelperFunction.parseTime(closeAt.value!).millisecondsSinceEpoch.toDouble();


    var response = await ApiGetCalls.getApiResponse(Api.allergyApi);
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed
      var data = json.decode(response.body);

      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
          allergyArray.add(Allergy.fromJson(data["data"][i]));
        }
      }


      response = await ApiGetCalls.getApiResponse(Api.surpriseApi);
      if (response.statusCode == 200) {
        // Handle the response JSON data as needed


        var data = json.decode(response.body);

        if (data[0].length > 0) {
          for (var i = 0; i < data[0].length; i++) {
            surpriseArray.add(Mystery.Mystery.fromJson(data[0][i]));
          }


          response = await ApiGetCalls.getApiResponse(Api.foodCatApi);

          if (response.statusCode == 200) {
            var data = json.decode(response.body);

            if (data['data'].length > 0) {
              for (var i = 0; i < data['data'].length; i++) {
                foodCat.add(FoodCat.Data.fromJson(data['data'][i]));
              }

              tags.value = [];
              // openAt = Rx<String?>(null);
              // closeAt = Rx<String?>(null);
              minValue.value = HelperFunction
                  .parseTime(openAt.value!)
                  .millisecondsSinceEpoch
                  .toDouble();
              maxValue.value = HelperFunction
                  .parseTime(closeAt.value!)
                  .millisecondsSinceEpoch
                  .toDouble();

              lowerValue.value = HelperFunction
                  .parseTime(openAt.value!)
                  .millisecondsSinceEpoch
                  .toDouble();
              higherValue.value = HelperFunction
                  .parseTime(closeAt.value!)
                  .millisecondsSinceEpoch
                  .toDouble();


              pickUpDate.value = 0;
              pickUpHourText.value = "Toute la journée";

              showFilterLoader.value = false;


              showLoader.value = false;
            }
          }

        }

        print('Response data: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }


      print('Response data: ${response.body}');
    }

    else {
      print('Request failed with status: ${response.statusCode}.');
    }


  }

  resetDataForFilter() async {
    tags.value = [];
    surprise_selected.value = 0;
    selectedFoodCat.value = [];

    pickUpDate.value = 0;
    pickUpHourText.value = "Toute la journée";

    getPanierSurprise();
  }

  listDataFilter() async {

    print("Main array => ${listeFoodArray.length}");

    print(pickUpDate);
    print(pickUpDate != null);

    // Pick up date (Today/Tomorrow)
    if(pickUpDate != 0){
      List<Food> listeFoodArrayForFilter = listeFoodArray.value;

      listeFoodArray.value = [];

      DateTime now = DateTime.now();

      String today = DateTime.now().toString();
      String tomorrow  = DateTime(now.year, now.month, now.day + 1).toString();

      String tagetFilter = "";



      if(pickUpDate == 1){
        tagetFilter = today;
      }
      else if(pickUpDate == 2){
        tagetFilter = tomorrow;
      }


      for (var i=0; i<listeFoodArrayForFilter.length; i++){
        if(tagetFilter.contains(listeFoodArrayForFilter[i].pickupDateFrom!)){
          listeFoodArray.value.add(listeFoodArrayForFilter[i]);
        }
      }



    }

    print("After pick up date block array => ${listeFoodArray.length}");

    //Pick up time
    if(pickUpHourText != "Toute la journée"){

      String sliderPickUpFromTime = pickUpHourText.split("-")[0].trim();
      String sliderPickUpToTime = pickUpHourText.split("-")[1].trim();

      List<Food> listeFoodArrayForFilter = listeFoodArray.value;
      listeFoodArray.value = [];

      for (var i=0; i<listeFoodArrayForFilter.length; i++){


        if(
        HelperFunction.isTimeInRange( HelperFunction.convertTo24HourFormat(sliderPickUpFromTime), HelperFunction.convertTo24HourFormat(sliderPickUpToTime), listeFoodArrayForFilter[i].pickupTimeFrom!) &&
            HelperFunction.isTimeInRange( HelperFunction.convertTo24HourFormat(sliderPickUpFromTime), HelperFunction.convertTo24HourFormat(sliderPickUpToTime), listeFoodArrayForFilter[i].pickupTimeTo!)
        ){
          listeFoodArray.value.add(listeFoodArrayForFilter[i]);
        }

      }

    }

    print("After pick up time block array => ${listeFoodArray.length}");

    // Surprise
    if(surprise_selected.value != 0) {

      List<Food> listeFoodArrayForFilter = listeFoodArray.value;
      listeFoodArray.value = [];


      for (var i = 0; i < listeFoodArrayForFilter.length; i++) {

        print(listeFoodArrayForFilter[i].mysteryTypeId);
        print(surprise_selected.value);
        if(listeFoodArrayForFilter[i].mysteryTypeId == surprise_selected.value){
          listeFoodArray.value.add(listeFoodArrayForFilter[i]);
        }
      }
    }

    print("After surprise block array => ${listeFoodArray.length}");




    // Allergy
    if(tags.value.length > 0) {
      List<Food> listeFoodArrayForFilter = listeFoodArray.value;
      listeFoodArray.value = [];


      for (var i = 0; i < listeFoodArrayForFilter.length; i++) {
        List<int> allergyId = listeFoodArrayForFilter[i].allergyIds!
            .split(',')
            .map(int.parse)
            .toList();
        List<int> chosenAllergy = [];

        for(Allergy allergy in tags.value){
          chosenAllergy.add(allergy.id!);
        }

        // print(allergyId);
        // print(chosenAllergy);
        //
        //
        // print(HelperFunction.containsIds(allergyId, chosenAllergy));

        if(HelperFunction.containsIds(allergyId, chosenAllergy)){
          listeFoodArray.value.add(listeFoodArrayForFilter[i]);
        }
      }
    }

    print("After allergy block array => ${listeFoodArray.length}");

    if(selectedFoodCat.value.length > 0){
      List<Food> listeFoodArrayForFilter = listeFoodArray.value;
      listeFoodArray.value = [];

      for (var i=0; i<listeFoodArrayForFilter.length; i++){
        print(i);
        if(listeFoodArrayForFilter[i].foodCatId != null && listeFoodArrayForFilter[i].foodCatId != ""){
          // Convert foodCatId to an array of integers
          var foodCatIdArray = listeFoodArrayForFilter[i].foodCatId!.split(',').map((s) => int.parse(s)).toList();

          print("foodCatIdArray =>");
          print(foodCatIdArray);
          // Check if any value from selectedFoodCat.value is present in foodCatIdArray
          var intersection = selectedFoodCat.value.where((value) => foodCatIdArray.contains(value)).toList();

          // If there is any intersection, add the current item to listeFoodArray
          if(intersection.length > 0){
            listeFoodArray.add(listeFoodArrayForFilter[i]);
          }
        }
      }

    }


    print("After catagory block array => ${listeFoodArray.length}");


  }



}