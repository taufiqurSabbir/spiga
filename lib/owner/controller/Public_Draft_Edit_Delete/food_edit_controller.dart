import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as i;
import 'package:path/path.dart' as Path;

import '../../../api/api.dart';
import '../../../api/api_delete_calls.dart';
import '../../../api/api_get_calls.dart';
import '../../../api/api_post_calls.dart';
import '../../../api/api_post_calls.dart';
import '../../../const/const.dart';
import '../../../dialogue/Dialogue.dart';
import '../../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../../../sharePreference/sharePreference_getToken.dart';
import '../../home_page_45.dart';
import '../../mes_offers.dart';
import '../../model/Allergy.dart';
import '../../model/Boutique.dart';
import '../../model/Food.dart';
import '../../model/Mystery.dart';
import '../../model/FoodCat.dart' as FoodCat;

import '../../../dialogue/Dialogue.dart' as MyDialogue;



class FoodEditController extends GetxController {

  // Food Id
  int?  id;



  // Offer Type
  // Flat = 1 & Surprise  =  2
  final offerType  = "0".obs;

  final storeId  = 0.obs;
  final foodName = "".obs;
  final foodDescription = "".obs;
  final foodStock = "0".obs;
  final foodPricePrix = "".obs;
  final foodDiscountPricePrix = "".obs;
  final mysteryId  = 0.obs;



  //Network image
  final networkFoodImage = "".obs;
  final networkFoodListImage = "".obs;
  final networkFoodThumbnailImage = "".obs;

  // Pick Up date

  final pickUpDate = ''.obs;

  Rx<String?> pickUpTimeFrom = Rx<String?>(null);
  Rx<String?> pickUpTimeTo = Rx<String?>(null);

  final showLoader = true.obs;




  // This  is  for  detail  image
  Rx<File?> imageFile = Rx<File?>(null);

  // List image
  Rx<File?> listImageFile = Rx<File?>(null);


  // Thumbnail image
  Rx<File?> thumbImageFile = Rx<File?>(null);


  String? imagePath;
  ImagePicker imagePicker=ImagePicker();

  final  boutiqueArray = <Boutique>[].obs;
  final  allergyArray = <Allergy>[].obs;
  final  surpriseTypeArray = <Mystery>[].obs;
  final foodCatArray = <FoodCat.Data>[].obs;


  final tags=<Allergy>[].obs;
  final catTags = <FoodCat.Data>[].obs;




  getBoutique() async {
    await Future.delayed(Duration.zero);

    MyDialogue.Dialogue.showLoadingDialog();

    boutiqueArray.value = [];
    showLoader.value = true;

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

    allergyArray.value = [];
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

      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
          foodCatArray.add(FoodCat.Data.fromJson(data["data"][i]));
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    MyDialogue.Dialogue.dismissLoadingDialog();

  }



  resetAllValue() async {
    id = null;

    offerType.value = "0";
    storeId.value = 0;
    foodName.value = "";
    foodDescription.value = "";
    foodStock.value = "0";
    foodPricePrix.value = "";
    foodDiscountPricePrix.value = "";
    mysteryId.value = 0;
    pickUpDate.value = '';
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

  setAllValue(FoodWithCreatedAtUpdatedAtInDateTimeObj targeted_food) async{
    id = targeted_food.id;
    offerType.value = targeted_food.foodType.toString();
    storeId.value = targeted_food.boutiqueId!;
    foodName.value = targeted_food.foodName!;
    foodDescription.value = targeted_food.foodDescription!;
    foodStock.value = targeted_food.foodStock.toString();
    foodPricePrix.value = targeted_food.price.toString();
    foodDiscountPricePrix.value = targeted_food.discountPrice.toString();

    if(targeted_food.mysteryTypeId != null)mysteryId.value = targeted_food.mysteryTypeId!;

    networkFoodImage.value = targeted_food.foodImage!;
    networkFoodListImage.value = targeted_food.listImage!;
    networkFoodThumbnailImage.value = targeted_food.thumbnailImage!;

    pickUpDate.value = targeted_food.pickupDateFrom!;

    pickUpTimeFrom.value = targeted_food.pickupTimeFrom;
    pickUpTimeTo.value = targeted_food.pickupTimeTo;

    List<int>? targeted_food_allergy_ids = targeted_food.allergyIds?.split(",").map((e) => int.parse(e)).toList();

    print("Targeted food allergy id  =>  ${targeted_food_allergy_ids}");

    for(int i=0; i<allergyArray.length; i++){
      if(targeted_food_allergy_ids != null) {
        if (targeted_food_allergy_ids!.contains(allergyArray[i].id)) {
          tags.add(allergyArray[i]);
        }
      }
    }

    List<int>? targeted_food_cat_ids = targeted_food.foodCatId?.split(",").map((e) => int.parse(e)).toList();

    print("Targeted food cat id  =>  ${targeted_food_cat_ids}");

    for(int i=0; i<foodCatArray.length; i++){
      if(targeted_food_cat_ids != null) {
        if (targeted_food_cat_ids!.contains(foodCatArray[i].id)) {
          catTags.add(foodCatArray[i]);
        }
      }
    }

    showLoader.value = false;

  }


  postEditedFoods() async {

    showLoader.value = true;

    final url = Uri.parse(Api.listeSurprisApi+"/"+id.toString());

    print("Url: ${url}");

    var request = new http.MultipartRequest("POST", url);

    final String? bearerToken = await getToken();
    request.headers.addAll({'Authorization': 'Bearer $bearerToken'});


    request.fields['food_type'] = offerType.value;
    request.fields['food_name'] = foodName.value;
    request.fields['food_description'] = foodDescription.value;

    if(imageFile.value != null){
      var stream = new http.ByteStream((i.File(imageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(imageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('food_image', stream, length, filename: Path.basename(i.File(imageFile.value!.path).path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if(listImageFile.value != null){
      var stream = new http.ByteStream((i.File(listImageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(listImageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('list_image', stream, length, filename: Path.basename(i.File(listImageFile.value!.path).path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if(thumbImageFile.value != null){
      var stream = new http.ByteStream((i.File(thumbImageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(thumbImageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('thumbnail_image', stream, length, filename: Path.basename(i.File(thumbImageFile.value!.path).path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if(mysteryId.value != 0) request.fields['mystery_type_id'] = mysteryId.value.toString();
    request.fields['food_stock'] = foodStock.value;
    request.fields['price'] = foodDiscountPricePrix.value;
    request.fields['discount_price'] = foodPricePrix.value;
    request.fields['prefix'] = '€';
    request.fields['boutique_id'] = storeId.value.toString();
    request.fields['pickup_date_from'] = pickUpDate.value;
    request.fields['pickup_date_to'] = pickUpDate.value;
    request.fields['pickup_time_from'] = pickUpTimeFrom.value!;
    request.fields['pickup_time_to'] = pickUpTimeTo.value!;


    List<int> selected_allergy_id = [];

    tags.value.forEach((Allergy allergy) {
      selected_allergy_id.add(allergy.id!);
    });

    List<int> selected_cat_id = [];

    catTags.value.forEach((FoodCat.Data cat) {
      selected_cat_id.add(cat.id!);
    });

    request.fields['allergy_ids'] = selected_allergy_id.join(",");
    request.fields['hide_show'] = '1';
    request.fields['food_cat_id'] = selected_cat_id.join(",");

    // send
    var response = await request.send();

    // Print the response status code and body
    print('Response status code: ${response.statusCode}');

    response.stream.transform(utf8.decoder).listen((value) async {
      var data = json.decode(value);
      print(data["status"]);

      if(data["status"] == "Updated"){

        Fluttertoast.showToast(
          msg: "Modifications enregistrées avec succès",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
        );

        Get.offUntil(
          MaterialPageRoute(builder: (context) => UploadedFoodsPageAdmin()),
              (route) => route.isFirst,


        );
        // Get.offUntil(UploadedFoodsPageAdmin() as Route, (route) => false);


        // Get.offAll(() => UploadedFoodsPageAdmin());


      }
      else{
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

  draftEditedFoods() async {

    showLoader.value = true;

    final url = Uri.parse(Api.listeSurprisApi+"/"+id.toString());

    print("Url: ${url}");

    var request = new http.MultipartRequest("POST", url);

    final String? bearerToken = await getToken();
    request.headers.addAll({'Authorization': 'Bearer $bearerToken'});


    request.fields['food_type'] = offerType.value;
    request.fields['food_name'] = foodName.value;
    request.fields['food_description'] = foodDescription.value;

    if(imageFile.value != null){
      var stream = new http.ByteStream((i.File(imageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(imageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('food_image', stream, length, filename: Path.basename(i.File(imageFile.value!.path).path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if(listImageFile.value != null){
      var stream = new http.ByteStream((i.File(listImageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(listImageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('list_image', stream, length, filename: Path.basename(i.File(listImageFile.value!.path).path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if(thumbImageFile.value != null){
      var stream = new http.ByteStream((i.File(thumbImageFile.value!.path).openRead()));
      // get file length
      var length = await i.File(thumbImageFile.value!.path).length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('thumbnail_image', stream, length, filename: Path.basename(i.File(thumbImageFile.value!.path).path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    if(mysteryId.value != 0) request.fields['mystery_type_id'] = mysteryId.value.toString();
    request.fields['food_stock'] = foodStock.value;
    request.fields['price'] = foodDiscountPricePrix.value;
    request.fields['discount_price'] = foodPricePrix.value;
    request.fields['prefix'] = '€';
    request.fields['boutique_id'] = storeId.value.toString();
    request.fields['pickup_date_from'] = pickUpDate.value;
    request.fields['pickup_date_to'] = pickUpDate.value;
    request.fields['pickup_time_from'] = pickUpTimeFrom.value!;
    request.fields['pickup_time_to'] = pickUpTimeTo.value!;


    List<int> selected_allergy_id = [];

    tags.value.forEach((Allergy allergy) {
      selected_allergy_id.add(allergy.id!);
    });

    List<int> selected_cat_id = [];

    catTags.value.forEach((FoodCat.Data cat) {
      selected_cat_id.add(cat.id!);
    });

    request.fields['allergy_ids'] = selected_allergy_id.join(",");
    request.fields['hide_show'] = '0';
    request.fields['food_cat_id'] = selected_cat_id.join(",");


    // send
    var response = await request.send();

    // Print the response status code and body
    print('Response status code: ${response.statusCode}');

    response.stream.transform(utf8.decoder).listen((value) async {
      var data = json.decode(value);
      print(data["status"]);

      if(data["status"] == "Updated"){

        Fluttertoast.showToast(
          msg: "Modifications enregistrées avec succès",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
        );

        Get.offUntil(
          MaterialPageRoute(builder: (context) => UploadedFoodsPageAdmin()),
              (route) => route.isFirst,


        );
        // Get.offUntil(UploadedFoodsPageAdmin() as Route, (route) => false);


        // Get.offAll(() => UploadedFoodsPageAdmin());


      }
      else{
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

  cancleEditedFoods() async {

    showLoader.value = true;

    Get.offUntil(
        MaterialPageRoute(builder: (context) => UploadedFoodsPageAdmin()),
            (route) => route.isFirst,
    );



  }

  publishFoodOffer(int  foodId) async {
    showLoader.value = true;

    final url = Api.listeSurprisApi+"/hide-show/"+foodId.toString();

    print("Url: ${url}");
    print("---------------------------");
    print(foodId);

    var response = await ApiPostCalls.postApiResponse(url, {"hide_show": "1"});
    if(response.statusCode == 200){
      showLoader.value = false;
      Fluttertoast.showToast(
        msg: "Offre publiée",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );

      Get.offUntil(
        MaterialPageRoute(builder: (context) => UploadedFoodsPageAdmin()),
            (route) => route.isFirst,
      );

    }
    else{
      showLoader.value = false;
      Fluttertoast.showToast(
        msg: "Quelque chose s'est mal passé.",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }



  }

  draftFoodOffer(int  foodId) async {
    showLoader.value = true;

    final url = Api.listeSurprisApi+"/hide-show/"+foodId.toString();

    print("Url: ${url}");

    var response = await ApiPostCalls.postApiResponse(url, {"hide_show": "0"});
    if(response.statusCode == 200){
      showLoader.value = false;
      Fluttertoast.showToast(
        msg: "Offre rédigée",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );

      Get.offUntil(
        MaterialPageRoute(builder: (context) => UploadedFoodsPageAdmin()),
            (route) => route.isFirst,
      );

    }
    else{
      showLoader.value = false;
      Fluttertoast.showToast(
        msg: "Quelque chose s'est mal passé.",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }



  }

  deleteFoodOffer(int  foodId) async {
    showLoader.value = true;

    final url = Api.listeSurprisApi + "/" + foodId.toString();

    print("Url: ${url}");

    var response = await ApiDeleteCalls.deleteApiResponse(url);
    if (response.statusCode == 200) {
      showLoader.value = false;
      Fluttertoast.showToast(
        msg: "Votre offre à été supprimée",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );

      Get.offUntil(
        MaterialPageRoute(builder: (context) => UploadedFoodsPageAdmin()),
            (route) => route.isFirst,
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
  }

  // 1 = detail image (File? imageFile)
  // 2 = list image  (File? listImageFile)
  // 3 = list image  (File? thumbImageFile)

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