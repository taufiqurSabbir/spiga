import 'dart:convert';

import 'package:get/get.dart';

import '../../api/api.dart';
import '../../api/api_get_calls.dart';
import '../model/Tutorial.dart';

class TutorialStepsController extends GetxController {

  final showLoader = true.obs;
  final images = [].obs;
  final titles = [].obs;
  final subtitles = [].obs;
  final current = 0.obs;
  final buttonText = "Suivant".obs;




  getTutorialSteps() async {
    await Future.delayed(Duration.zero);

    showLoader.value = true;
    images.value = [];
    titles.value = [];
    subtitles.value = [];

    var response = await ApiGetCalls.getApiResponse(Api.tutorialApi);

    if (response != null) {
      if (response.statusCode == 200) {

        var data = json.decode(response.body);

        List<Tutoral> tutorialList = [];
        for (var item in data[0]) {
          tutorialList.add(Tutoral.fromJson(item));
        }

        for (var item in tutorialList) {
          images.add(item.image);
          titles.add(item.tutorialTitle);
          subtitles.add(item.tutorialSubTitle);
        }


        showLoader.value = false;
      }
    }
  }


}
