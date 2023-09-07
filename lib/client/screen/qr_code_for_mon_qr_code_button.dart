import 'package:laspigadoro/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import '../controllar/cart_controller.dart';

import '../../helper/helper_function.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../controllar/order_history_controller.dart';
import 'home_page.dart';
import 'dart:typed_data';
import 'dart:io' as io;
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';


class QRCodePageMonQrCodeButton extends StatefulWidget {

  QRCodePageMonQrCodeButton({Key? key}) : super(key: key);
  @override
  State<QRCodePageMonQrCodeButton> createState() => _QRCodePageMonQrCodeButtonState();
}
class _QRCodePageMonQrCodeButtonState extends State<QRCodePageMonQrCodeButton> {

  GlobalKey _qrKey = GlobalKey();
  final OrderHistoryController orderHistoryClientController  = Get.put(OrderHistoryController());

  @override
  void initState() {
    super.initState();

    orderHistoryClientController.getOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(() =>
    orderHistoryClientController.showLoader.value  == true
        ? Container(
          color: bottomShetColor,
          child: loaderSquare,
        )
        : Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bottomShetColor,
        elevation: 1,
        title: Text("Mon QR code",
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: whiteTextColor))),
        leading:  Padding(
          padding: EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 13),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: mainTextColorwithOpachity,
            child: Padding(
              padding: EdgeInsets.only(left: 4),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: whiteTextColor,
                    )),
              ),
            ),
          ),
        ),


      ),
      backgroundColor: bottomShetColor,
      body:
      orderHistoryClientController.orders.length == 0 || orderHistoryClientController.orders[0].orderStatus == 4
          ?
            Center(
                child: Text("Aucun code QR n'est disponible",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor)))
              )
        : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image(
                image: NetworkImage(
                  "${orderHistoryClientController.image[0]}",
                ),
                fit: BoxFit.cover,
                height: size.height*0.3,
                width: size.width,
              ),
            ),
            SizedBox(height: 16,),
            Text("${orderHistoryClientController.foodName[0]}",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:whiteTextColor))),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "image/order_status.svg",
                  height:15,
                  width: 15,
                  color: Colors.white,
                ),
                SizedBox(width: 7,),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(
                          text: orderHistoryClientController.orders[0].orderStatus == 1
                              ? "Nouveau "
                              : orderHistoryClientController.orders[0].orderStatus== 2
                              ? "En cours de traitement "
                              : orderHistoryClientController.orders[0].orderStatus == 3
                              ? "Prêt à être \nrécupéré"
                              : orderHistoryClientController.orders[0].orderStatus == 4
                              ? "Livré"
                              : orderHistoryClientController.orders[0].orderStatus == 5
                              ? "Remboursée"
                              : orderHistoryClientController.orders[0].orderStatus == 6
                              ? "Annulée"
                              : "Unknown",
                          style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                      )
                    ]
                )),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "image/clock (1).svg",
                  height:15,
                  width: 15,
                  color: Colors.white,
                ),
                SizedBox(width: 7,),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Pick up:", style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white))
                      ),
                      TextSpan(
                          text: " ${orderHistoryClientController.orders[0].pickupTime}", style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                      )
                    ]
                )),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "image/clock (1).svg",
                  height:15,
                  width: 15,
                  color: Colors.white,
                ),
                SizedBox(width: 7,),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Heure choisie pour le pick up:", style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white))
                      ),
                      TextSpan(
                          text: " ${orderHistoryClientController.orders[0].customerPickupTimeFrom}", style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                      )
                    ]
                )),
              ],
            ),

            SizedBox(height: 21,),
            RepaintBoundary(
              key: _qrKey,
              child: QrImage(
                backgroundColor: Colors.white,
                data: 'OrderHereLaSpigad\'Oro${orderHistoryClientController.orders[0].id!}',
                version: QrVersions.auto,
                size: 190.0,
                gapless: false,
                foregroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 21,),
            GestureDetector(
                onTap: () {
                  HelperFunction.saveQrCode(_qrKey);
                },
                child:  Container(
                  height: 55,
                  width: 330,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: mainTextColor),
                  child: Center(
                    child: Text("Télécharger mon QR code",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color:whiteTextColor))),
                  ),
                )
            ),
            SizedBox(height: 21,),

            GestureDetector(
                onTap: () async {
                  final String? store_id = await getStoreId();

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePageClient(boutique_id: store_id!)),
                        (route) => false, // This condition ensures all pages are removed from the stack
                  );
                },
                child: Container(
                  height: 55,
                  width: 330,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: mainTextColor),
                  child: Center(
                    child: Text("Retour à la boutique",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color:whiteTextColor))),
                  ),
                )
            ),
            SizedBox(height: 21,),
          ],
        ),
      ),
    )



    );






  }




}
