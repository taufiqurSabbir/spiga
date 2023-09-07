import 'package:laspigadoro/client/controllar/details_page_controller.dart';
import 'package:laspigadoro/client/model/Allergy.dart';
import 'package:laspigadoro/client/model/Food.dart';
import 'package:laspigadoro/client/screen/common_widget/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';

import 'package:sizer/sizer.dart';

import '../../helper/helper_function.dart';
import '../controllar/cart_controller.dart';
import 'add_to_cart_page.dart';
import '../model/FoodCat.dart' as FoodCat;

class DetailsPageClient extends StatefulWidget {
  Food targetedFood;

  DetailsPageClient({Key? key, required this.targetedFood}) : super(key: key);

  @override
  State<DetailsPageClient> createState() => _DetailsPageClientState();
}

class _DetailsPageClientState extends State<DetailsPageClient> {
  final DetailsPageController controller_foodDetailsPage =
      Get.put(DetailsPageController());

  final CartController controller_cartController = Get.put(CartController());

  var curentIndex = -1;

  var botomIcon = [
    "image/shop.svg",
    "image/qr-code-scan.svg",
    "image/scientist-svgrepo-com.svg"
  ];

  @override
  void initState() {
    super.initState();

    controller_foodDetailsPage.getStoreDetails();

    if (HelperFunction.isValid(widget.targetedFood.allergyIds) == true)
      controller_foodDetailsPage.getAllergy(widget.targetedFood.allergyIds!);
    if (HelperFunction.isValid(widget.targetedFood.foodCatId) == true)
      controller_foodDetailsPage.getFoodCatName(widget.targetedFood.foodCatId!);

    controller_cartController.temp_price.value =
        widget.targetedFood.price!.toDouble();
    controller_cartController.loadData();
    controller_cartController.payment_status.value = null;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final hasHtmlTag = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false)
        .hasMatch(widget.targetedFood.foodDescription!);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Obx(() => controller_foodDetailsPage.showLoader == true
        ? loaderSquare
        : Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Color(0xffF9F9F8).withOpacity(1),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                height: 83,
                width: size.width,
                color: whiteTextColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.targetedFood.foodStock != 0) {
                          showBottomSheet();
                        } else {
                          emptyStock();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 260,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27),
                            color: mainTextColorwithOpachity),
                        child: Center(
                          child: Text("Ajouter au panier",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: whiteTextColor))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          if (widget.targetedFood.foodStock != 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddToCartPage()));
                          } else {
                            emptyStock();
                          }
                        },
                        child: Stack(children: [
                          SizedBox(height: 60, width: 60),
                          Positioned(
                            top: 5,
                            right: 4,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: mainTextColorwithOpachity),
                              child: Center(
                                child: Center(
                                  child: SvgPicture.asset(
                                    "image/noun_basket_821481.svg",
                                    height: 22,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: widget.targetedFood.foodStock != 0 &&
                                  controller_cartController.quantity.value != 0,
                              child: Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xffBDD516),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      "${controller_cartController.quantity.value.toString()}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor)),
                                    ),
                                  ),
                                ),
                              ))
                        ])

                        // Container(
                        //   height: 56,
                        //   width: 56,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(100),
                        //       color: mainTextColorwithOpachity
                        //   ),
                        //   child: Center(
                        //     child:Center(child:SvgPicture.asset(
                        //       "image/noun_basket_821481.svg",
                        //       height: 22,
                        //       width: 20,
                        //     ),) ,
                        //   ),
                        // ),
                        )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF).withOpacity(01)),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 30.h,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.targetedFood.foodImage!),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: 60,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
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
                                      width:
                                          MediaQuery.of(context).size.width * 1,
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
                                            color:
                                                Color(0xffFFFF).withOpacity(1),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                size: 22,
                                                color: Color(0xff209602)
                                                    .withOpacity(1),
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
                                                "${widget.targetedFood.foodName}",
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(0xffFFFFFF)
                                                            .withOpacity(1))))),
                                        Container(
                                            height: 24,
                                            width: 86,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(11),
                                                  bottomLeft:
                                                      Radius.circular(11),
                                                  topRight: Radius.circular(11),
                                                  topLeft: Radius.circular(11)),
                                            ),
                                            child: widget.targetedFood
                                                        .foodStock !=
                                                    0
                                                ? Center(
                                                    child: Text(
                                                        "${widget.targetedFood.foodStock} Dispos",
                                                        style: GoogleFonts.openSans(
                                                            textStyle: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                        0xf44680E)
                                                                    .withOpacity(
                                                                        1)))))
                                                : Center(
                                                    child: Text("épuisé",
                                                        style: GoogleFonts.openSans(
                                                            textStyle: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                        0xffE25E41)
                                                                    .withOpacity(
                                                                        1)))),
                                                  ))
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          flex: 8,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                "image/clock (1).svg",
                                                height: 16,
                                                width: 16,
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Pick up:",
                                                    style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black))),
                                                TextSpan(
                                                    text:
                                                        " ${widget.targetedFood.pickupTimeFrom} - ${widget.targetedFood.pickupTimeTo}",
                                                    style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black))),
                                              ])),
                                              SizedBox(
                                                width: 1.w,
                                              ),
                                              // Container(
                                              //     height: 21,
                                              //     width: 65,
                                              //     decoration: BoxDecoration(color: Color(0xffDFE7D6),
                                              //       borderRadius: BorderRadius.only(
                                              //           bottomRight: Radius.circular(11),
                                              //           bottomLeft: Radius.circular(11),
                                              //           topRight: Radius.circular(11),
                                              //           topLeft: Radius.circular(11)),
                                              //     ),
                                              //     child: Padding(
                                              //       padding:  EdgeInsets.all(3.0),
                                              //       child:
                                              //
                                              //       Center(child: Text("Aujourd'hui",
                                              //           style: GoogleFonts.openSans(
                                              //               textStyle: TextStyle(
                                              //                   fontSize: 10,
                                              //                   fontWeight: FontWeight.bold,
                                              //                   color: Color(0xf44680E).withOpacity(1)))),
                                              //       ),
                                              //     )
                                              // ),

                                              Container(
                                                height: 21,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffDFE7D6),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(11)),
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
                                                        "${HelperFunction.getTodayTomorrowOrDate(widget.targetedFood.pickupDateFrom!)}",
                                                        style: GoogleFonts
                                                            .openSans(
                                                          textStyle: TextStyle(
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                    0xf44680E)
                                                                .withOpacity(1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                width: 1.w,
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              Text(
                                                  "${HelperFunction.stringToCurrency(widget.targetedFood.discountPrice.toString(), "€")}",
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 12,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Color(0xf000000)
                                                                  .withOpacity(
                                                                      1)))),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                    "${HelperFunction.stringToCurrency(widget.targetedFood.price.toString(), "€")}",
                                                    style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                    0xf44680E)
                                                                .withOpacity(
                                                                    1)))),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Visibility(
                                      visible: HelperFunction.isValid(
                                          widget.targetedFood.foodCatId),
                                      child: Wrap(
                                        direction: Axis
                                            .horizontal, // use this to change the direction of wrap
                                        alignment: WrapAlignment.start,
                                        spacing:
                                            3.0, // gap between adjacent chips
                                        runSpacing:
                                            5, // use this to change the alignment of items
                                        children: getCatColumn(),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      HelperFunction.launchGoogleMaps(
                          '${controller_foodDetailsPage.storeAddress} ${controller_foodDetailsPage.storeName}');
                      // Get.toNamed(Routes.STORE_DETAILS_PAGE, arguments: widget.targetedFood.storeId);
                    },
                    child: Container(
                      height: 58,
                      color: whiteTextColor,
                      child: InkWell(
                        onTap: () => HelperFunction.launchGoogleMaps(
                            '${controller_foodDetailsPage.storeAddress} ${controller_foodDetailsPage.storeName}'),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 20.0, left: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  size: 20.56,
                                  weight: 10.49,
                                  color: mainTextColorwithOpachity),
                              SizedBox(
                                  width:
                                      8), // Adjust the width to control the gap between the icon and the title
                              Expanded(
                                child: Text(
                                  "${controller_foodDetailsPage.storeAddress} ${controller_foodDetailsPage.storeName}",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.underline,
                                      color: mainTextColorwithOpachity,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  size: 20.56,
                                  weight: 10.49,
                                  color: mainTextColorwithOpachity),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 8),
                      child: Text("Description",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: mainTextColorwithOpachity))),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Container(
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(children: [
                                hasHtmlTag
                                    ? Html(
                                        data:
                                            "${widget.targetedFood.foodDescription}",
                                        style: {
                                          "*": Style(
                                            fontFamily: 'Open Sans',
                                            fontSize: FontSize(10.sp),
                                            color: Colors.black,
                                          ),
                                          "body": Style(
                                              padding: EdgeInsets.zero,
                                              margin: EdgeInsets.zero)
                                        },
                                      )
                                    : Text(
                                        '${widget.targetedFood.foodDescription}',
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          color: bottomShetColor,
                                        )),
                                      ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                    tileColor: whiteTextColor,
                  ),
                  Visibility(
                      visible:
                          controller_foodDetailsPage.allergyArray.isNotEmpty,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 139,
                            width: size.width,
                            color: whiteTextColor,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 22),
                                    child: Text("Allergènes",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    mainTextColorwithOpachity))),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: Wrap(
                                      spacing:
                                          8.0, // gap between adjacent chips
                                      runSpacing: 4.0, // gap between lines
                                      children: getAllergyColumn(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ));
  }

  getAllergyColumn() {
    RxList<Allergy> allergyArray = controller_foodDetailsPage.allergyArray;
    List<Widget> column = [];

    allergyArray.forEach((Allergy allergy) {
      column.add(Container(
        height: 27,
        decoration: BoxDecoration(
          color: Color(0xffDFE7D6),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
          child: IntrinsicWidth(
            child: Center(
              child: Text(
                "${allergy.name}",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xf44680E).withOpacity(1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ));
    });

    return column;
  }

  getCatColumn() {
    RxList<FoodCat.Data> allergyArray = controller_foodDetailsPage.foodCatArray;
    List<Widget> column = [];

    column.add(Container(
      height: 27,
      child: Padding(
        padding: EdgeInsets.only(right: 8.0, left: 0.0, top: 4.0, bottom: 4.0),
        child: IntrinsicWidth(
          child: Center(
            child: Text(
              "Category : ",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
    allergyArray.forEach((FoodCat.Data cat) {
      column.add(Container(
        height: 27,
        decoration: BoxDecoration(
          color: Color(0xffDFE7D6),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
          child: IntrinsicWidth(
            child: Center(
              child: Text(
                "${cat.name}",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xf44680E).withOpacity(1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ));
    });

    return column;
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Obx(() => Container(
                  height: 375,
                  decoration: BoxDecoration(
                      color: bottomShetColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {},
                      //
                      //   child: Icon(Icons.clear_rounded,size: 15,color: whiteTextColor,),
                      //   style: ElevatedButton.styleFrom(
                      //
                      //     shape: CircleBorder(),
                      //     o
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, right: 16),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              height: 27,
                              width: 27,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: mainTextColorwithOpachity),
                              child: Center(
                                  child: Icon(
                                Icons.clear_rounded,
                                size: 15,
                                color: whiteTextColor,
                              )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Choisir une quantité",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                      Divider(
                        height: 15,
                        thickness: 3,
                        endIndent: 160,
                        indent: 160,
                        color: mainTextColorwithOpachity,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller_cartController
                                      .temp_quantity.value ==
                                  1) {
                                controller_cartController.getTmpTotalPrice();

                                // controller_cartController.saveInSharePreffered(widget.targetedFood.id.toString(), "", "", widget.targetedFood.foodImage.toString(), widget.targetedFood.foodName.toString(), widget.targetedFood.pickupTimeFrom.toString()+" - "+widget.targetedFood.pickupTimeTo.toString());
                                return;
                              }

                              controller_cartController.temp_quantity.value--;

                              controller_cartController.getTmpTotalPrice();
                              //controller_cartController.saveInSharePreffered(widget.targetedFood.id.toString(), "", "", widget.targetedFood.foodImage.toString(), widget.targetedFood.foodName.toString(), widget.targetedFood.pickupTimeFrom.toString()+" - "+widget.targetedFood.pickupTimeTo.toString());
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whiteTextColor),
                              child: Center(
                                  child: Icon(
                                Icons.remove,
                                size: 18,
                                color: mainTextColorwithOpachity,
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          (() {
                            if (controller_cartController.temp_quantity.value ==
                                0) {
                              return Text("01",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor)));
                            } else {
                              return Text(
                                  controller_cartController.temp_quantity.value
                                      .toString()
                                      .padLeft(2, '0'),
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor)));
                            }
                          }()),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              if (controller_cartController
                                      .temp_quantity.value ==
                                  widget.targetedFood.foodStock) {
                                controller_cartController.getTmpTotalPrice();
                                //controller_cartController.saveInSharePreffered(widget.targetedFood.id.toString(), "", "", widget.targetedFood.foodImage.toString(), widget.targetedFood.foodName.toString(), widget.targetedFood.pickupTimeFrom.toString()+" - "+widget.targetedFood.pickupTimeTo.toString());
                                return;
                              }

                              controller_cartController.temp_quantity.value++;

                              controller_cartController.getTmpTotalPrice();
                              //controller_cartController.saveInSharePreffered(widget.targetedFood.id.toString(), "", "", widget.targetedFood.foodImage.toString(), widget.targetedFood.foodName.toString(), widget.targetedFood.pickupTimeFrom.toString()+" - "+widget.targetedFood.pickupTimeTo.toString());

                              //  setState(() {
                              //    onChangeIcon();
                              //  });
                              // print(changeButtonColor);
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: mainTextColor),
                              child: Center(
                                  child: Icon(Icons.add,
                                      size: 18, color: whiteTextColor)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Text(
                            "En ajoutant ce produit au panier, vous accepter les conditions de vente de La Spiga d'Oro",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: whiteTextColor))),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 48, right: 48),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                            SizedBox(
                              width: 15,
                            ),

                            (() {
                              if (controller_cartController
                                      .temp_totalPrice.value ==
                                  0) {
                                return Text(
                                    "${HelperFunction.stringToCurrency(widget.targetedFood.price.toString(), "\€")}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor)));
                              } else {
                                return Text(
                                    "${HelperFunction.stringToCurrency(controller_cartController.temp_totalPrice.toString(), "\€")}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor)));
                              }
                            }()),

                            // Text("${HelperFunction.stringToCurrency(controller_cartController.temp_totalPrice .toString(), "\€")}",
                            //     style: GoogleFonts.openSans(
                            //         textStyle: TextStyle(
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.bold,
                            //             color: whiteTextColor))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller_cartController.temp_quantity.value ==
                              0) {
                            controller_cartController.temp_quantity.value = 1;
                            controller_cartController.getTmpTotalPrice();
                          }
                          controller_cartController.quantity.value =
                              controller_cartController.temp_quantity.value;
                          controller_cartController.price.value =
                              widget.targetedFood.price.toDouble();
                          controller_cartController.totalPrice.value =
                              controller_cartController.temp_totalPrice.value;
                          controller_cartController.food_id.value =
                              widget.targetedFood.id!;
                          controller_cartController.food_name.value =
                              widget.targetedFood.foodName!;
                          controller_cartController.food_image.value =
                              widget.targetedFood.foodImage!;
                          controller_cartController.thumbnail_image.value =
                              widget.targetedFood.thumbnailImage!;
                          controller_cartController.list_image.value =
                              widget.targetedFood.listImage!;
                          controller_cartController.pickUp_date.value =
                              widget.targetedFood.pickupDateFrom.toString();

                          controller_cartController.pickUp_time.value =
                              widget.targetedFood.pickupTimeFrom.toString() +
                                  " - " +
                                  widget.targetedFood.pickupTimeTo.toString();

                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 54,
                          width: 270,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(27),
                              color: mainTextColorwithOpachity),
                          child: Center(
                            child: Text("Ajouter au panier",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ));
          });
        });
  }

  emptyStock() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(21), topLeft: Radius.circular(21))),
        builder: (BuildContext context) {
          return Container(
            height: 280,
            decoration: BoxDecoration(
                color: bottomShetColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () {},
                //
                //   child: Icon(Icons.clear_rounded,size: 15,color: whiteTextColor,),
                //   style: ElevatedButton.styleFrom(
                //
                //     shape: CircleBorder(),
                //     o
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainTextColorwithOpachity),
                        child: Center(
                            child: Icon(
                          Icons.clear_rounded,
                          size: 15,
                          color: whiteTextColor,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Oups!",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor))),
                Divider(
                  height: 15,
                  thickness: 3,
                  endIndent: 160,
                  indent: 160,
                  color: mainTextColorwithOpachity,
                ),
                SizedBox(
                  height: 26,
                ),
                SvgPicture.asset(
                  "image/noun_basket_821481.svg",
                  height: 28,
                  width: 28,
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Ce produit est épuisé!",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor))),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (_)=>PaiementValiderPage()));
                    },
                    child: Container(
                        height: 45,
                        width: 330,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: mainTextColor),
                        child: Center(
                          child: Text("Retour en arrière",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: whiteTextColor))),
                        )),
                  ),
                )
              ],
            ),
          );
        });
  }
}
