import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../../api/api_post_calls.dart';
import '../../login_page/login_page.dart';
import '../model/Boutique.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';


class ChoisirVotreClientController extends GetxController {

  final showLoader = true.obs;
  final  boutiqueArray = <Boutique>[].obs;


  getBoutique() async {
    await Future.delayed(Duration.zero);

    showLoader.value = true;
    boutiqueArray.value = [];

    var response = await ApiGetCalls.getApiResponse(Api.boutiqueApi);

    try{
      if (response.statusCode == 200) {
        // Handle the response JSON data as needed
        var data = jsonDecode(response.body);

        if (data["data"].length > 0) {
          for (var i = 0; i < data["data"].length; i++) {
            boutiqueArray.add(Boutique.fromJson(data["data"][i]));
          }
        }

        showLoader.value = false;
      }
      else{
        print('Request failed with status: ${response.statusCode}.');

      }
    }
    catch(e){
      print(e);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', "");


      Get.offAll(() => LoginPage());

    }

  }

  updateTutorialStep() async{

    var tutorial_step_ipdate = await ApiPostCalls.postApiResponse(Api.tutorialUpdateApi, {"tutorial_steps": 1});


    if(tutorial_step_ipdate.statusCode == 200){
      print('Response data: ${tutorial_step_ipdate.body}');
    }else{
      print('Request failed with status: ${tutorial_step_ipdate.statusCode}.');
    }


  }
}