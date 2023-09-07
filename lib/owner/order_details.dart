import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:laspigadoro/const/const.dart';

import 'package:laspigadoro/owner/controller/order_details_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

import '../helper/helper_function.dart';
import 'controller/order_number_controller.dart';
import 'mes_commandes_page_44.dart';

class OwnerOrderDetails extends StatefulWidget {
  int id;
  OwnerOrderDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OwnerOrderDetails> createState() => _OwnerOrderDetailsState();
}

class _OwnerOrderDetailsState extends State<OwnerOrderDetails> {
  final OrderDetailsController userOrderController =
      Get.put(OrderDetailsController());
  final OrderNumberController orderCountController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userOrderController.getOrders(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Obx(() => (() {
          if (userOrderController.showLoader.value == true) {
            return Container(
              color: bottomShetColor,
              child: loaderSquare,
            );
          } else {
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: bottomShetColor,
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 30.h,
                            width: size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(userOrderController
                                      .userOrder.value!.foodImage
                                      .toString()),
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
                            top: 42,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  //Navigator.pop(context);
                                  // Navigator.popUntil(context, (route) => route.isFirst);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MesCommandesPageAdmin()));
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
                                          color:
                                              Color(0xff209602).withOpacity(1),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                          "${userOrderController.userOrder.value!.foodName}",
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffFFFFFF)
                                                      .withOpacity(1))))),
                                ],
                              ))
                        ],
                      ),

                      SizedBox(
                        height: 21,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(children: [
                          Expanded(
                            child: Center(
                              child: Text("Pickup date",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor))),
                            ),
                          ),
                          Expanded(
                              child: Center(
                            child: Text("Pickup Horaire",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          )),
                        ]),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    side: MaterialStatePropertyAll(
                                        BorderSide(color: Color(0xff5B5B5B))),
                                  ),
                                  onPressed: null,
                                  child: Text(
                                      " ${HelperFunction.convertDateFormatWithYear(userOrderController.userOrder.value!.pickupDateFrom.toString())}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor)))),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    side: MaterialStatePropertyAll(
                                        BorderSide(color: Color(0xff5B5B5B)))),
                                onPressed: null,
                                child: Text(
                                  " ${userOrderController.userOrder.value!.customerPickupTimeFrom!}",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(children: [
                          Expanded(
                            child: Center(
                              child: Text("Date de commande",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor))),
                            ),
                          ),
                          Expanded(
                              child: Center(
                            child: Text("Quantité",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          )),
                        ]),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStatePropertyAll(BorderSide(
                                          color: Color(0xff5B5B5B)))),
                                  onPressed: null,
                                  child: Text(
                                      "${HelperFunction.convertDateFormatWithYear(userOrderController.userOrder.value!.orderDate.toString())}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor)))),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStatePropertyAll(BorderSide(
                                          color: Color(0xff5B5B5B)))),
                                  onPressed: null,
                                  child: Text(
                                      "${userOrderController.userOrder.value!.quantity}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor)))),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(children: [
                          Expanded(
                            child: Center(
                              child: Text("Status de paiement",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor))),
                            ),
                          ),
                          Expanded(
                              child: Center(
                            child: Text("Stock",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          )),
                        ]),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      side: MaterialStatePropertyAll(BorderSide(
                                          color: Color(0xff5B5B5B)))),
                                  onPressed: null,
                                  child: Text(
                                      userOrderController.userOrder.value!.paymentStatus == 0
                                          ? "Espèces"
                                          : (userOrderController.userOrder.value!.paymentStatus == 1
                                              ? "Payé"
                                              : (userOrderController.userOrder.value!.paymentStatus == 2
                                                  ? "Livré"
                                                  : (userOrderController.userOrder.value!.paymentStatus == 3
                                                      ? "Ticket Resto"
                                                      : "Unknown"))),
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor)))),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStatePropertyAll(BorderSide(
                                          color: Color(0xff5B5B5B)))),
                                  onPressed: null,
                                  child: Text(
                                      "${userOrderController.userOrder.value!.foodStock}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor)))),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      //Transaction ID (Stripe)
                      Visibility(
                        visible: userOrderController
                                .userOrder.value!.transactionId !=
                            null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(children: [
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text("Transaction ID",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor))),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 6,
                              child: GestureDetector(
                                onLongPress: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: userOrderController
                                          .userOrder.value!.transactionId));
                                  Fluttertoast.showToast(
                                    msg:
                                        "L'identifiant de transaction à été copié",
                                    toastLength: Toast.LENGTH_SHORT,
                                    fontSize: 14.0,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                  );
                                },
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: Color(0xff5B5B5B)))),
                                  onPressed: null,
                                  child: Text(
                                      "${userOrderController.userOrder.value!.transactionId}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor))),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),

                      //Refund Id (Stripe)
                      Visibility(
                          visible:
                              userOrderController.userOrder.value!.refundId !=
                                  null,
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(children: [
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text("ID de remboursement",
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: whiteTextColor))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: GestureDetector(
                                      onLongPress: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: userOrderController
                                                .userOrder.value!.refundId));
                                        Fluttertoast.showToast(
                                          msg:
                                              "L'identifiant de transaction à été copié",
                                          toastLength: Toast.LENGTH_SHORT,
                                          fontSize: 14.0,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.green,
                                        );
                                      },
                                      child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    color: Color(0xff5B5B5B)))),
                                        onPressed: null,
                                        child: Text(
                                            "${userOrderController.userOrder.value!.refundId}",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: whiteTextColor))),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          )),

                      //Status de la commande change
                      Visibility(
                          visible: userOrderController
                                      .userOrder.value!.orderStatus !=
                                  5 &&
                              userOrderController
                                      .userOrder.value!.orderStatus !=
                                  6,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(children: [
                                  Expanded(
                                    child: Center(
                                      child: Text("Status de la commande",
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: whiteTextColor))),
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                userOrderController.isClicked
                                                            .value[0] ||
                                                        userOrderController
                                                            .isClicked
                                                            .value[1] ||
                                                        userOrderController
                                                            .isClicked
                                                            .value[2] ||
                                                        userOrderController
                                                            .isClicked.value[3]
                                                    ? userOrderController
                                                        .clickedColors[0]
                                                    : Colors.transparent,
                                              ),
                                              side: MaterialStatePropertyAll(
                                                  BorderSide(
                                                      color:
                                                          Color(0xff5B5B5B))),
                                            ),
                                            onPressed: () {
                                              orderCountController
                                                  .getOrderNumber();

                                              userOrderController.postOrders(
                                                  true,
                                                  widget.id,
                                                  userOrderController.userOrder
                                                      .value!.paymentStatus,
                                                  1,
                                                  0);
                                            },
                                            child: Text('Nouveau ',
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            whiteTextColor))),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                userOrderController.isClicked
                                                            .value[1] ||
                                                        userOrderController
                                                            .isClicked
                                                            .value[2] ||
                                                        userOrderController
                                                            .isClicked.value[3]
                                                    ? userOrderController
                                                        .clickedColors[1]
                                                    : Colors.transparent,
                                              ),
                                              side: MaterialStatePropertyAll(
                                                  BorderSide(
                                                      color:
                                                          Color(0xff5B5B5B))),
                                            ),
                                            onPressed: () {
                                              orderCountController
                                                  .getOrderNumber();

                                              userOrderController.postOrders(
                                                  true,
                                                  widget.id,
                                                  userOrderController.userOrder
                                                      .value!.paymentStatus,
                                                  2,
                                                  1);

                                              // userOrderController.isClicked.value[1] = true;
                                            },
                                            child: Text(
                                                'En cours de traitement',
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            whiteTextColor))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                userOrderController.isClicked
                                                            .value[2] ||
                                                        userOrderController
                                                            .isClicked.value[3]
                                                    ? userOrderController
                                                        .clickedColors[2]
                                                    : Colors.transparent,
                                              ),
                                              side: MaterialStatePropertyAll(
                                                  BorderSide(
                                                      color:
                                                          Color(0xff5B5B5B))),
                                            ),
                                            onPressed: () {
                                              orderCountController
                                                  .getOrderNumber();

                                              userOrderController.postOrders(
                                                  true,
                                                  widget.id,
                                                  userOrderController.userOrder
                                                      .value!.paymentStatus,
                                                  3,
                                                  2);
                                            },
                                            child: Text('Prêt à être récupéré',
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            whiteTextColor))),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                userOrderController
                                                        .isClicked.value[3]
                                                    ? userOrderController
                                                        .clickedColors[3]
                                                    : Colors.transparent,
                                              ),
                                              side: MaterialStatePropertyAll(
                                                  BorderSide(
                                                      color:
                                                          Color(0xff5B5B5B))),
                                            ),
                                            onPressed: () {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.info,
                                                animType: AnimType.rightSlide,
                                                title: 'Êtes-vous sûr ?',
                                                // desc: 'Dialog description here.............',

                                                btnCancelText: "Non",
                                                btnCancelOnPress: () {},
                                                btnOkText: "Oui",
                                                btnOkOnPress: () {
                                                  orderCountController
                                                      .getOrderNumber();

                                                  userOrderController
                                                      .postOrders(
                                                          true,
                                                          widget.id,
                                                          userOrderController
                                                              .userOrder
                                                              .value!
                                                              .paymentStatus,
                                                          4,
                                                          3);
                                                },
                                              ).show();

                                              // userOrderController.isClicked.value[3] = true;
                                            },
                                            child: Text('Livré',
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            whiteTextColor))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),

                      //This  order is refunded
                      Visibility(
                          visible: userOrderController
                                  .userOrder.value!.orderStatus ==
                              5,
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Center(
                                  child: Text("Cette commande est remboursée.",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: whiteTextColor))),
                                ),
                              )
                            ],
                          )),

                      //This  order is cancelled
                      Visibility(
                          visible: userOrderController
                                  .userOrder.value!.orderStatus ==
                              6,
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Center(
                                  child: Text("Cette commande est annulée.",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: whiteTextColor))),
                                ),
                              )
                            ],
                          )),

                      //Refund Button
                      Visibility(
                          visible: userOrderController
                                      .userOrder.value!.paymentStatus ==
                                  1 &&
                              userOrderController
                                      .userOrder.value!.orderStatus !=
                                  5 &&
                              userOrderController
                                      .userOrder.value!.orderStatus !=
                                  6,
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  width: double
                                      .infinity, // This will make the button full width
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                    ),
                                    child: Text('Remboursement'),
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.rightSlide,
                                        title: 'Êtes-vous sûr ?',
                                        desc:
                                            'Vous allez annuler cette commande.',
                                        btnCancelText: "Non",
                                        btnCancelOnPress: () {},
                                        btnOkText: "Oui",
                                        btnOkOnPress: () async {
                                          orderCountController.getOrderNumber();
                                          await userOrderController
                                              .refund(widget.id);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MesCommandesPageAdmin()));
                                        },
                                      ).show();
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          )),

                      //Cancle button
                      Visibility(
                          visible: userOrderController
                                      .userOrder.value!.paymentStatus !=
                                  1 &&
                              userOrderController
                                      .userOrder.value!.orderStatus !=
                                  5 &&
                              userOrderController
                                      .userOrder.value!.orderStatus !=
                                  6,
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  width: double
                                      .infinity, // This will make the button full width
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                    ),
                                    child: Text('Annuler'),
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.rightSlide,
                                        title: 'Êtes-vous sûr ?',
                                        desc:
                                            'Vous allez annuler cette commande.',
                                        btnCancelText: "Non",
                                        btnCancelOnPress: () {},
                                        btnOkText: "Oui",
                                        btnOkOnPress: () async {
                                          orderCountController.getOrderNumber();
                                          await userOrderController.cancle(
                                              widget.id,
                                              userOrderController.userOrder
                                                  .value!.paymentStatus!,
                                              6);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MesCommandesPageAdmin()));
                                        },
                                      ).show();

                                      // print('Selected items: $_selectedItems');
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            );
          }
        }()));
  }
}
