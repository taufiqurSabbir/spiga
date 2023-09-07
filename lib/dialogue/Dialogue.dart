import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../const/const.dart';

class Dialogue{
  Dialogue();

  static  void showLoadingDialog() {
    Get.dialog(
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: 150.0,
          height: 150.0,
          child: SpinKitDoubleBounce(
            color: mainTextColor,
            size: 60.0,
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  static void dismissLoadingDialog() {
    Get.back();
  }

}