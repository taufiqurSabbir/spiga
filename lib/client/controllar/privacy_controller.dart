import 'dart:convert';

import 'package:laspigadoro/api/api.dart';
import 'package:laspigadoro/api/api_get_calls.dart';
import 'package:laspigadoro/client/model/Privacy.dart';
import 'package:get/get.dart';

class PrivacyController extends GetxController{
  final showLoader = true.obs;
  final privacy = "".obs;

  getPrivacy() async{



    showLoader.value = true;
    var response = await ApiGetCalls.getApiResponse(Api.clintPrivacyApi);


    print(response.statusCode);

    if (response.statusCode == 200) {





      var data = json.decode(response.body);
      privacy.value = Privacy.fromJson(data).policies!;


      showLoader.value = false;
      print(data);




      showLoader.value = false;
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }




  }

  }
