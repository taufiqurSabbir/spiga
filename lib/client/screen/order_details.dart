import 'package:laspigadoro/client/controllar/order_history_controller.dart';
import 'package:laspigadoro/client/model/Order_history.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import 'home_page.dart';

class OrderDetails extends StatefulWidget {
  final OrderHistoryController orderHistoryClientController;
  int index;
  OrderDetails(
      {Key? key,
      required this.orderHistoryClientController,
      required this.index})
      : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  GlobalKey _qrKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bottomShetColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ClipRRect(
              //   child: Image(
              //     image: NetworkImage(
              //       widget.orderHistoryClientController.image[widget.index]
              //
              //     ),
              //     fit: BoxFit.cover,
              //     height: size.height*0.3,
              //     width: size.width,
              //   ),
              // ),
              Stack(
                children: [
                  Container(
                    height: 30.h,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget
                              .orderHistoryClientController
                              .image[widget.index]),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(0.65),
                              Colors.black.withOpacity(0.45),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.2, 0.3, 0.5, 1],
                          ),
                        ),
                      )),
                  Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.65),
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.1, 0.3, 0.4, 0.6],
                          ),
                        ),
                      )),
                  Positioned(
                    left: 20,
                    top: 31,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: AbsorbPointer(
                          child: Container(
                            height: 31,
                            width: 31,
                            decoration: BoxDecoration(
                              color: Color(0xffFFFF).withOpacity(1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 22,
                                  color: Color(0xff209602).withOpacity(1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 17,
                      right: 28,
                      bottom: 29,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${widget.orderHistoryClientController.foodName[widget.index]}",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffFFFFFF)
                                              .withOpacity(1))))),
                          Container(
                            height: 36,
                            width: 86,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                  widget
                                              .orderHistoryClientController
                                              .orders![widget.index]
                                              .orderStatus ==
                                          1
                                      ? "Nouveau "
                                      : (widget
                                                  .orderHistoryClientController
                                                  .orders![widget.index]
                                                  .orderStatus ==
                                              2
                                          ? "En cours de traitement "
                                          : (widget
                                                      .orderHistoryClientController
                                                      .orders![widget.index]
                                                      .orderStatus ==
                                                  3
                                              ? "Prêt à être \nrécupéré"
                                              : (widget
                                                          .orderHistoryClientController
                                                          .orders![widget.index]
                                                          .orderStatus ==
                                                      4
                                                  ? "Livré"
                                                  : (widget.orderHistoryClientController.orders![widget.index].orderStatus == 5
                                                      ? "Remboursée"
                                                      : (widget.orderHistoryClientController.orders![widget.index].orderStatus == 6
                                                          ? "Annulée"
                                                          : "Unknown"))))),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))),
                            ),
                          )
                        ],
                      ))
                ],
              ),

              SizedBox(
                height: 21,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 8,
                            child: Row(
                              children: [
                                SvgPicture.asset("image/clock (1).svg",
                                    height: 16,
                                    width: 16,
                                    color: whiteTextColor),
                                SizedBox(
                                  width: 5,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Pick up:",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: whiteTextColor))),
                                  TextSpan(
                                      text:
                                          " ${widget.orderHistoryClientController.orders![widget.index].pickupTime.toString()}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor))),
                                ])),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Container(
                                  height: 21,
                                  decoration: BoxDecoration(
                                    color: Color(0xffDFE7D6),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5.0,
                                        left: 5.0,
                                        top: 3.0,
                                        bottom: 3.0),
                                    child: IntrinsicWidth(
                                      child: Center(
                                        child: Text(
                                          HelperFunction.getTodayTomorrowOrDate(
                                              widget
                                                  .orderHistoryClientController
                                                  .orders![widget.index]
                                                  .orderDate
                                                  .toString()
                                                  .split(" ")[0]),
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xf44680E)
                                                  .withOpacity(1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Column(
                          children: [
                            Text(
                                "${HelperFunction.stringToCurrency(widget.orderHistoryClientController.orders![widget.index].totalPrice.toString(), "€")}",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 8,
                            child: Row(
                              children: [
                                SvgPicture.asset("image/clock (1).svg",
                                    height: 16,
                                    width: 16,
                                    color: whiteTextColor),
                                SizedBox(
                                  width: 5,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Heure choisie pour le pick up:",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: whiteTextColor))),
                                  TextSpan(
                                      text:
                                          " ${widget.orderHistoryClientController.orders![widget.index].customerPickupTimeFrom.toString()}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor))),
                                ]))
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              RepaintBoundary(
                key: _qrKey,
                child: QrImage(
                  backgroundColor: Colors.white,
                  data:
                      'OrderHereLaSpigad\'Oro${widget.orderHistoryClientController.orders![widget.index].id}',
                  version: QrVersions.auto,
                  size: 220.0,
                  gapless: false,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Align(
            alignment: Alignment.center,
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Wrap(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    GestureDetector(
                        onTap: () {
                          HelperFunction.saveQrCode(_qrKey);
                        },
                        child: Container(
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
                                        color: whiteTextColor))),
                          ),
                        )),
                    SizedBox(
                      height: 21,
                    ),
                    GestureDetector(
                        onTap: () async {
                          final String? store_id = await getStoreId();

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePageClient(boutique_id: store_id!)),
                            (route) =>
                                false, // This condition ensures all pages are removed from the stack
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
                                        color: whiteTextColor))),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
