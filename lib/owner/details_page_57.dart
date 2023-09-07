import 'package:laspigadoro/client/model/FoodCat.dart';
import 'package:laspigadoro/owner/common_widget/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/owner/home_page_45.dart';
import 'package:laspigadoro/owner/profile_page_pro_menu.dart';
import 'package:laspigadoro/owner/publier_une_offre_deatails_page_56.dart';
import 'package:laspigadoro/owner/publier_une_offre_page_52.dart';
import 'package:sizer/sizer.dart';

import 'controller/details_page_controller.dart';
import 'controller/liste_controller.dart';
import '../helper/helper_function.dart';
import 'model/Allergy.dart';
import 'model/Food.dart';
import 'model/FoodCat.dart' as FoodCat;

class DetailsPageAdmin extends StatefulWidget {
  Food targetedFood;

  DetailsPageAdmin({Key? key, required this.targetedFood}) : super(key: key);

  @override
  State<DetailsPageAdmin> createState() => _DetailsPageAdminState();
}

class _DetailsPageAdminState extends State<DetailsPageAdmin> {
  final DetailsPageControllerOwner controller_foodDetailsPage =
      Get.put(DetailsPageControllerOwner());

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
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: curentIndex,
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
}
