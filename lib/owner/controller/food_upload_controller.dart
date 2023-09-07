import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:laspigadoro/const/const.dart';
import 'dart:io' as i;
import 'package:path/path.dart' as Path;

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../dialogue/Dialogue.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../../sharePreference/sharePreference_getToken.dart';
import '../home_page_45.dart';
import '../model/Allergy.dart';
import '../model/Boutique.dart';
import '../model/FoodCat.dart' as FoodCat;
import '../model/Mystery.dart';
import '../../dialogue/Dialogue.dart' as MyDialogue;


class FoodUploadControllerOwner extends GetxController {

  // Offer Type
  // Flat = 1 & Surprise  =  2
  final offerType = "0".obs;

  final storeId = [].obs;
  final foodName = "".obs;
  final foodDescription = "".obs;
  final foodStock = "0".obs;
  final foodPricePrix = "".obs;
  final foodDiscountPricePrix = "".obs;
  final mysteryId = 0.obs;
  final foodCatId = 0.obs;



  // Pick Up date
  // Today & Tomorrow
  // 0 means  nothing
  // 1 means  Today
  // 2  means Tomorrow
  final pickUpDate = 0.obs;

  Rx<String?> pickUpTimeFrom = Rx<String?>(null);
  Rx<String?> pickUpTimeTo = Rx<String?>(null);

  final showLoader = false.obs;


  // This  is  for  detail  image
  Rx<File?> imageFile = Rx<File?>(null);

  // List image
  Rx<File?> listImageFile = Rx<File?>(null);


  // Thumbnail image
  Rx<File?> thumbImageFile = Rx<File?>(null);


  String? imagePath;
  ImagePicker imagePicker = ImagePicker();

  final boutiqueArray = <Boutique>[].obs;
  final allergyArray = <Allergy>[].obs;
  final surpriseTypeArray = <Mystery>[].obs;

  final foodCatArray = <FoodCat.Data>[].obs;

  final tags = <Allergy>[].obs;
  final catTags = <FoodCat.Data>[].obs;


  getBoutique() async {
    await Future.delayed(Duration.zero);

    MyDialogue.Dialogue.showLoadingDialog();

    var response = await ApiGetCalls.getApiResponse(Api.boutiqueApi);
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed


      var data = json.decode(response.body);

      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
          boutiqueArray.add(Boutique.fromJson(data["data"][i]));
        }
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

    var response = await ApiGetCalls.getApiResponse(Api.allergyApi);
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed


      var data = json.decode(response.body);

      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
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

  getSurpriseType() async {
    await Future.delayed(Duration.zero);

    MyDialogue.Dialogue.showLoadingDialog();

    var response = await ApiGetCalls.getApiResponse(Api.surpriseApi);
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed


      var data = json.decode(response.body);

      if (data[0].length > 0) {
        for (var i = 0; i < data[0].length; i++) {
          print(data[0][i]);
          surpriseTypeArray.add(Mystery.fromJson(data[0][i]));
        }

        showLoader.value = false;
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

    var response = await ApiGetCalls.getApiResponse(Api.foodCatApi);
    if (response.statusCode == 200) {
      // Handle the response JSON data as needed


      var data = json.decode(response.body);

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


  resetAllValue() async {
    offerType.value = "0";
    storeId.value = [];
    foodName.value = "";
    foodDescription.value = "";
    foodStock.value = "0";
    foodPricePrix.value = "";
    foodDiscountPricePrix.value = "";
    mysteryId.value = 0;
    foodCatId.value = 0;
    pickUpDate.value = 0;
    pickUpTimeFrom.value = null;
    pickUpTimeTo.value = null;
    imageFile.value = null;
    listImageFile.value = null;
    thumbImageFile.value = null;
    imagePath = null;
    boutiqueArray.clear();
    allergyArray.clear();
    surpriseTypeArray.clear();
    tags.clear();
    catTags.clear();
  }

  postFoods() async {
    showLoader.value = true;

    final url = Uri.parse(Api.listeSurprisApi);

    print("Url: ${url}");

    var request = new http.MultipartRequest("POST", url);

    final String? bearerToken = await getToken();
    request.headers.addAll({'Authorization': 'Bearer $bearerToken'});


    request.fields['food_type'] = offerType.value;
    request.fields['food_name'] = foodName.value;
    request.fields['food_description'] = foodDescription.value;

    if (imageFile.value != null) {
      var stream = new http.ByteStream(
          (i.File(imageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(imageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile(
          'food_image', stream, length, filename: Path.basename(i
          .File(imageFile.value!.path)
          .path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if (listImageFile.value != null) {
      var stream = new http.ByteStream(
          (i.File(listImageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(listImageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile(
          'list_image', stream, length, filename: Path.basename(i
          .File(listImageFile.value!.path)
          .path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if (thumbImageFile.value != null) {
      var stream = new http.ByteStream(
          (i.File(thumbImageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(thumbImageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile(
          'thumbnail_image', stream, length, filename: Path.basename(i
          .File(thumbImageFile.value!.path)
          .path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    String tagetFilter = "";
    DateTime now = DateTime.now();

    String today = DateTime.now().toString();
    String tomorrow = DateTime(now.year, now.month, now.day + 1).toString();


    if (pickUpDate == 1) {
      tagetFilter = today;
    }
    else if (pickUpDate == 2) {
      tagetFilter = tomorrow;
    }

    request.fields['mystery_type_id'] = mysteryId.value.toString();
    request.fields['food_stock'] = foodStock.value;
    request.fields['price'] = foodDiscountPricePrix.value;
    request.fields['discount_price'] = foodPricePrix.value;
    request.fields['prefix'] = '€';
    request.fields['boutique_id'] = storeId.value.join(",");
    request.fields['pickup_date_from'] = tagetFilter.split(" ")[0];
    request.fields['pickup_date_to'] = tagetFilter.split(" ")[0];
    request.fields['pickup_time_from'] = pickUpTimeFrom.value!;
    request.fields['pickup_time_to'] = pickUpTimeTo.value!;


    List<int> selected_allergy_id = [];

    tags.value.forEach((Allergy allergy) {
      selected_allergy_id.add(allergy.id!);
    });

    List<int> selected_food_cat_id = [];
    catTags.value.forEach((FoodCat.Data cat) {
      selected_food_cat_id.add(cat.id!);
    });



    request.fields['allergy_ids'] = selected_allergy_id.join(",");
    request.fields['food_cat_id'] = selected_food_cat_id.join(",");
    request.fields['hide_show'] = '1';


    // send
    var response = await request.send();

    // Print the response status code and body
    print('Response status code: ${response.statusCode}');

    response.stream.transform(utf8.decoder).listen((value) async {
      var data = json.decode(value);
      print(data["status"]);

      if (data["status"] == "Successfull") {
        final String? store_id = await getStoreId();
        Get.to(HomePageAdmin(boutique_id: store_id!));

        //resetAllValue();


        showLoader.value = false;

        Fluttertoast.showToast(
          msg: "Nourriture importée avec succès.",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
        );

      }
      else {
        showLoader.value = false;

        Fluttertoast.showToast(
          msg: "Quelque chose s'est mal passé.",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    });
  }

  draftFoods() async {
    showLoader.value = true;

    final url = Uri.parse(Api.listeSurprisApi);

    print("Url: ${url}");

    var request = new http.MultipartRequest("POST", url);

    final String? bearerToken = await getToken();
    request.headers.addAll({'Authorization': 'Bearer $bearerToken'});


    request.fields['food_type'] = offerType.value;
    request.fields['food_name'] = foodName.value;
    request.fields['food_description'] = foodDescription.value;

    if (imageFile.value != null) {
      var stream = new http.ByteStream(
          (i.File(imageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(imageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile(
          'food_image', stream, length, filename: Path.basename(i
          .File(imageFile.value!.path)
          .path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if (listImageFile.value != null) {
      var stream = new http.ByteStream(
          (i.File(listImageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(listImageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile(
          'list_image', stream, length, filename: Path.basename(i
          .File(listImageFile.value!.path)
          .path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if (thumbImageFile.value != null) {
      var stream = new http.ByteStream(
          (i.File(thumbImageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(thumbImageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile(
          'thumbnail_image', stream, length, filename: Path.basename(i
          .File(thumbImageFile.value!.path)
          .path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    String tagetFilter = "";
    DateTime now = DateTime.now();

    String today = DateTime.now().toString();
    String tomorrow = DateTime(now.year, now.month, now.day + 1).toString();


    if (pickUpDate == 1) {
      tagetFilter = today;
    }
    else if (pickUpDate == 2) {
      tagetFilter = tomorrow;
    }

    request.fields['mystery_type_id'] = mysteryId.value.toString();
    request.fields['food_stock'] = foodStock.value;
    request.fields['price'] = foodDiscountPricePrix.value;
    request.fields['discount_price'] = foodPricePrix.value;
    request.fields['prefix'] = '€';
    request.fields['boutique_id'] = storeId.value.join(",");
    request.fields['pickup_date_from'] = tagetFilter.split(" ")[0];
    request.fields['pickup_date_to'] = tagetFilter.split(" ")[0];
    request.fields['pickup_time_from'] = pickUpTimeFrom.value!;
    request.fields['pickup_time_to'] = pickUpTimeTo.value!;


    List<int> selected_allergy_id = [];

    tags.value.forEach((Allergy allergy) {
      selected_allergy_id.add(allergy.id!);
    });

    List<int> selected_food_cat_id = [];
    catTags.value.forEach((FoodCat.Data cat) {
      selected_food_cat_id.add(cat.id!);
    });



    request.fields['allergy_ids'] = selected_allergy_id.join(",");
    request.fields['food_cat_id'] = selected_food_cat_id.join(",");
    request.fields['hide_show'] = '0';

    // send
    var response = await request.send();

    // Print the response status code and body
    print('Response status code: ${response.statusCode}');

    response.stream.transform(utf8.decoder).listen((value) async {
      var data = json.decode(value);
      print(data["status"]);

      if (data["status"] == "Successfull") {
        final String? store_id = await getStoreId();
        Get.to(HomePageAdmin(boutique_id: store_id!));

        //resetAllValue();

        showLoader.value = false;

        Fluttertoast.showToast(
          msg: "Nourriture importée avec succès.",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
        );
      }
      else {
        showLoader.value = false;

        Fluttertoast.showToast(
          msg: "Quelque chose s'est mal passé.",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    });
  }



  void takePhoto(ImageSource source, int imageType) async {
    Dialogue.showLoadingDialog();

    try {
      final picarImageFile = await imagePicker.pickImage(
          source: source, imageQuality: 50);

      if (picarImageFile == null) {
        // User canceled the picker
        return;
      }
      else{
        cropImage(picarImageFile, imageType);
      }



    } catch (e) {
      // Handle any errors here
      print('Failed to pick image: $e');
      Dialogue.dismissLoadingDialog();
      Fluttertoast.showToast(
          msg: "Quelque chose s'est mal passé.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0
      );

    }
  }

  void  cropImage(XFile? pickedFile, int imageType) async {
    CroppedFile? _croppedFile;

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 2),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Faites glisser l\'image et mettez-la en position',
              toolbarColor: bottomShetColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Faites glisser l\'image et mettez-la en position',
          ),
        ],
      );
      if (croppedFile != null) {
          _croppedFile = croppedFile;
          final file = File(_croppedFile.path);

          if (imageType == 1) {
            imageFile.value = file;
            Dialogue.dismissLoadingDialog();

          }
          else if (imageType == 2) {
            listImageFile.value = file;
            Dialogue.dismissLoadingDialog();

          }
          else if (imageType == 3) {
            thumbImageFile.value = file;
            Dialogue.dismissLoadingDialog();

          }
      }
    }
  }

}