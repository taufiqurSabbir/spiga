import 'dart:convert';

import 'package:laspigadoro/api/api.dart';
import 'package:get/get.dart';

import '../../api/api_get_calls.dart';
import '../model/Boutique.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';


class ChoisirVotreAdminControllerOwner extends GetxController {

  final showLoader = true.obs;
  final  boutiqueArray = <Boutique>[].obs;


  getBoutique() async {
    await Future.delayed(Duration.zero);

    showLoader.value = true;
    boutiqueArray.value = [];

    var response = await ApiGetCalls.getApiResponse(Api.boutiqueApi);
      if (response.statusCode == 200) {
        // Handle the response JSON data as needed

        final String? store_id = await getStoreId();

        var data = json.decode(response.body);

        if (data["data"].length > 0) {
          for (var i = 0; i < data["data"].length; i++) {
            boutiqueArray.add(Boutique.fromJson(data["data"][i]));
          }


          showLoader.value = false;

        }

        print('Response data: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }


  }
}