import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laspigadoro/owner/long.dart';
import 'package:laspigadoro/owner/profile_page_pro_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/owner/publier_une_offre_page_52.dart';
import 'package:sizer/sizer.dart';

import '../owner/Public_Draft_Edit_Delete/draft_and_public_edit.dart';
import 'controller/notification_owner_out_of_stock_controller.dart';





class NotificationOwnerOutOfStock extends StatefulWidget {
  int id;
  NotificationOwnerOutOfStock({Key? key, required this.id}) : super(key: key);

  @override
  State<NotificationOwnerOutOfStock> createState() => _NotificationOwnerOutOfStockState();
}

class _NotificationOwnerOutOfStockState extends State<NotificationOwnerOutOfStock> {
  final NotificationOwnerOutOfStockController notificationOwnerOutOfStockController = Get
      .put(NotificationOwnerOutOfStockController());


  @override
  void initState() {
    super.initState();
    notificationOwnerOutOfStockController.getPublishAndDrafList(widget.id);
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(() =>
    notificationOwnerOutOfStockController.showLoader.value == true
        ? loaderSquareWithWhiteBackground
        : Draft_and_public(target_food: notificationOwnerOutOfStockController.publishAndDrafArrayWithDateTimeObj!)
    );
  }

}