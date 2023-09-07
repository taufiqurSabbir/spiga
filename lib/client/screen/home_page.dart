import 'dart:async';

import 'package:laspigadoro/client/controllar/liste_controller.dart';
import 'package:laspigadoro/client/screen/common_widget/custom_bottom_navigation.dart';
import 'package:laspigadoro/client/screen/liste_filter.dart';
import 'package:laspigadoro/client/screen/panier_surprise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:lottie/lottie.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../helper/helper_function.dart';
import '../../sharePreference/sharePreference_getCartDetails.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import 'choisir_votre_client.dart';
import 'details_page.dart';
import '../controllar/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class HomePageClient extends StatefulWidget {
  String boutique_id;
  HomePageClient({Key? key, required this.boutique_id}) : super(key: key);

  @override
  State<HomePageClient> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageClient> {
  TextEditingController searchControllar = TextEditingController();

  final ListeController controller_listeController = Get.put(ListeController());
  final CartController controller_cartController = Get.put(CartController());

  var curentIndex = 1;

  @override
  void initState() {
    super.initState();
    process();
  }

  process() async {
    await controller_listeController.getListe();
    await controller_cartController.loadData();
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   _timerLong.cancel();
  //   // Clean up resources
  //   super.dispose();
  // }

  @override
  void onPush() {
    // Do something when screen is pushed onto navigation stack
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    controller_listeController.getListe();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    controller_listeController.getListe();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: mainTextColor));

    return Obx(() => Scaffold(
        backgroundColor: Color(0xffF9F9F8).withOpacity(1),
        appBar: controller_listeController.showLoader.value == false
            ? PreferredSize(
                preferredSize: Size.fromHeight(99),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color(0xff209602).withOpacity(1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      GestureDetector(
                        onTap: () {
                          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Choisir_Scren()));
                          // Navigator.of(context).pushAndRemoveUntil(
                          //   MaterialPageRoute(builder: (context) => Choisir_Scren_Admin() ),
                          //       (route) => false, // This condition ensures all pages are removed from the stack
                          // );

                          Get.offAll(() => Choisir_Scren_Client());
                        },
                        child: Stack(
                            clipBehavior: Clip
                                .none, // <---  clipBehavior: Clip.none, // <---
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 13.56,
                                        weight: 9.49,
                                        color: Color(0xffF9F9F8),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                          "${controller_listeController.store_name}",
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xfFFFFFF)
                                                      .withOpacity(1)))),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 20.0,
                                        weight: 5,
                                        color: Colors.white,
                                      ),
                                      // SizedBox(width: MediaQuery.of(context).size.width * 0.18,),
                                      //
                                      // InkWell(
                                      //     onTap: () {
                                      //       Navigator.push(context, MaterialPageRoute(builder: (_)=>MesCommandesPageAdmin()));
                                      //     },
                                      //     child: SvgPicture.asset("image/noun_basket.svg")
                                      // ),
                                    ],
                                  )),
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 21),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                //    Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsPage()));

                                final String? store_id = await getStoreId();

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomePageClient(
                                            boutique_id: store_id!)));
                                // Navigator.of(context).pushAndRemoveUntil(
                                //   MaterialPageRoute(builder: (context) => HomePageClient(boutique_id: store_id!)),
                                //       (route) => false, // This condition ensures all pages are removed from the stack
                                // );
                              },
                              child: Container(
                                height: 38,
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    color: Color(0xffF9F9F8).withOpacity(1),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7),
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7))),
                                child: Center(
                                  child: Text(
                                    "Liste",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xf44680E)
                                                .withOpacity(1))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 13),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final String? store_id = await getStoreId();

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Panier_surprise(
                                            boutique_id: store_id!)));
                              },
                              child: Container(
                                height: 38,
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    color: Color(0xffDFE7D6).withOpacity(0.19),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7),
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7))),
                                child: Center(
                                  child: Text(
                                    "Panier surprise",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 21),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : null,
        bottomNavigationBar:
            controller_listeController.showLoader.value == false
                ? CustomBottomNavigationBar(
                    currentIndex: curentIndex,
                    quantity: controller_cartController.quantity.value,
                  )
                : null,
        body: controller_listeController.showLoader.value == true
            ? loaderSquare
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropMaterialHeader(
                  backgroundColor: mainTextColor,
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: controller_listeController.listeFoodArray.length == 0
                    ? Center(
                        child: Lottie.asset('image/empty_food_list_lady.json'),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 21, top: 21),
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width -
                                        21 -
                                        43 -
                                        15 -
                                        8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(2),
                                            topLeft: Radius.circular(2),
                                            topRight: Radius.circular(5)),
                                        border: Border.all(
                                            color: Color(0xffFFFF)
                                                .withOpacity(1))),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        primaryColor: Colors.green,
                                      ),
                                      child: TextField(
                                        cursorColor: mainTextColorwithOpachity,
                                        controller: searchControllar,
                                        onChanged: (content) {
                                          print(content);
                                          controller_listeController
                                              .searchFromListe(content);
                                        },
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: '',
                                          hintStyle: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xfCFCFCF)
                                                      .withOpacity(1))),
                                          filled: true,
                                          fillColor:
                                              Theme.of(context).cardColor,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(2),
                                                  topLeft: Radius.circular(2),
                                                  topRight: Radius.circular(5)),
                                              borderSide: BorderSide(
                                                  color: Colors.white24
                                                      .withOpacity(1))),
                                          focusColor: mainTextColorwithOpachity
                                              .withOpacity(0.4),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(2),
                                                  topLeft: Radius.circular(2),
                                                  topRight: Radius.circular(5)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color:
                                                      mainTextColorwithOpachity)),
                                          prefixIcon: GestureDetector(
                                            // onTap: _changeIconColor,
                                            child: Icon(
                                              Icons.search_rounded,
                                              size: 20,
                                              weight: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 6,),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, top: 21),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ListeFilter(
                                                    controller_listeController:
                                                        controller_listeController)));
                                      },
                                      child: Container(
                                        height: 42,
                                        width: 43,
                                        decoration: BoxDecoration(
                                            color: Color(0xffDFE7D6)
                                                .withOpacity(1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "image/sliders-solid.svg",
                                            height: 22,
                                            width: 20,
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: controller_listeController
                                    .listeFoodArray.length,
                                itemBuilder: (context, index) {
                                  print("---------------------------");
                                  print(HelperFunction.checkImageOrientation(
                                      controller_listeController
                                          .listeFoodArray[index].listImage!));
                                  return controller_listeController
                                              .listeFoodArray[index]
                                              .foodStock! >
                                          0
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => DetailsPageClient(
                                                        targetedFood:
                                                            controller_listeController
                                                                    .listeFoodArray[
                                                                index])));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Container(
                                              height: 250,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ]),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 250,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  controller_listeController
                                                                      .listeFoodArray[
                                                                          index]
                                                                      .listImage!),
                                                              fit: controller_listeController
                                                                          .listeFoodArray[
                                                                              index]
                                                                          .orientation ==
                                                                      0
                                                                  ? BoxFit.cover
                                                                  : BoxFit
                                                                      .fitHeight),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          right: 15,
                                                          top: 13,
                                                          child: Container(
                                                              height: 22,
                                                              width: 65,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  border: Border
                                                                      .all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              mainTextColor)),
                                                              child: Center(
                                                                child: Text(
                                                                    "${controller_listeController.listeFoodArray[index].foodStock} Dispos",
                                                                    style: GoogleFonts.openSans(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Color(0xf44680E).withOpacity(1)))),
                                                              )))
                                                    ],
                                                  )),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 10,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex:
                                                              8, // takes 30% of available width
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  controller_listeController
                                                                      .listeFoodArray[
                                                                          index]
                                                                      .foodName!,
                                                                  style: GoogleFonts.openSans(
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Color(0xf000000).withOpacity(1)))),
                                                              Text(
                                                                "Pick up ${HelperFunction.getTodayTomorrowOrDate(controller_listeController.listeFoodArray[index].pickupDateFrom!)} :\n${controller_listeController.listeFoodArray[index].pickupTimeFrom!} - ${controller_listeController.listeFoodArray[index].pickupTimeTo!}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                softWrap: false,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex:
                                                              2, // takes 30% of available width
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  "${HelperFunction.stringToCurrency(controller_listeController.listeFoodArray[index].discountPrice.toString(), "€")}",
                                                                  style: GoogleFonts.openSans(
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          decoration: TextDecoration
                                                                              .lineThrough,
                                                                          color:
                                                                              Color(0xf000000).withOpacity(1)))),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            5),
                                                                child: Text(
                                                                    "${HelperFunction.stringToCurrency(controller_listeController.listeFoodArray[index].price.toString(), "€")}",
                                                                    style: GoogleFonts.openSans(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color(0xf44680E).withOpacity(1)))),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => DetailsPageClient(
                                                        targetedFood:
                                                            controller_listeController
                                                                    .listeFoodArray[
                                                                index])));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Container(
                                              height: 250,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ]),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      child: Stack(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 250,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5)),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(controller_listeController
                                                                      .listeFoodArray[
                                                                          index]
                                                                      .listImage!),
                                                                  fit: controller_listeController
                                                                              .listeFoodArray[
                                                                                  index]
                                                                              .orientation ==
                                                                          0
                                                                      ? BoxFit
                                                                          .cover
                                                                      : BoxFit
                                                                          .fitHeight),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 147,
                                                            // color: Colors.white.withOpacity(0.5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Positioned(
                                                          right: 15,
                                                          top: 13,
                                                          child: Container(
                                                              height: 21,
                                                              width: 60,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                    "épuisé",
                                                                    style: GoogleFonts.openSans(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color(0xffE25E41).withOpacity(1)))),
                                                              )))
                                                    ],
                                                  )),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 10,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex:
                                                              8, // takes 30% of available width
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  controller_listeController
                                                                      .listeFoodArray[
                                                                          index]
                                                                      .foodName!,
                                                                  style: GoogleFonts.openSans(
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Color(0xf000000).withOpacity(1)))),
                                                              Text(
                                                                "Pick up ${HelperFunction.getTodayTomorrowOrDate(controller_listeController.listeFoodArray[index].pickupDateFrom!)} :\n${controller_listeController.listeFoodArray[index].pickupTimeFrom!} - ${controller_listeController.listeFoodArray[index].pickupTimeTo!}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                softWrap: false,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex:
                                                              2, // takes 30% of available width
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  "${HelperFunction.stringToCurrency(controller_listeController.listeFoodArray[index].discountPrice.toString(), "€")}",
                                                                  style: GoogleFonts.openSans(
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          decoration: TextDecoration
                                                                              .lineThrough,
                                                                          color:
                                                                              Color(0xf000000).withOpacity(1)))),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            5),
                                                                child: Text(
                                                                    "${HelperFunction.stringToCurrency(controller_listeController.listeFoodArray[index].price.toString(), "€")}",
                                                                    style: GoogleFonts.openSans(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color(0xf44680E).withOpacity(1)))),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                })
                          ],
                        ),
                      ),
              )));
  }
}
