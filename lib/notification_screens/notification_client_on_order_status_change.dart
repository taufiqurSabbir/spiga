import 'package:cached_network_image/cached_network_image.dart';
import 'package:laspigadoro/client/controllar/order_history_controller.dart';
import 'package:laspigadoro/client/screen/order_details.dart';
import 'package:laspigadoro/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laspigadoro/const/const.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../client/screen/choisir_votre_client.dart';


class NotificationClientOnOrderStatusChange extends StatefulWidget {
  const NotificationClientOnOrderStatusChange({Key? key}) : super(key: key);

  @override
  State<NotificationClientOnOrderStatusChange> createState() => _NotificationClientOnOrderStatusChangeState();
}

class _NotificationClientOnOrderStatusChangeState extends State<NotificationClientOnOrderStatusChange> {
  final OrderHistoryController orderHistoryClientController  = Get.put(OrderHistoryController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderHistoryClientController.getOrderHistory();


  }
  @override
  Widget build(BuildContext context) {
    print("Lenght-------------");
    // print(orderHistoryClientController.orders.length);
    var size=MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(() =>

    ((){
      if(orderHistoryClientController.showLoader.value  == true){
        return Container(
          color: bottomShetColor,
          child: loaderSquare,
        );
      }
      else{

        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: bottomShetColor,
              elevation: 1,
              title: Text("Historique de commandes",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
              leading: InkWell(
                onTap: () {
                  Get.offAll(Choisir_Scren_Client());

                },
                child: Padding(
                  padding: EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 13),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: mainTextColorwithOpachity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4),
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



            ListView.builder(
              itemCount:orderHistoryClientController.orders.length,
              shrinkWrap: true,
              primary: false,


              itemBuilder: (context, index) {


                return  SizerUtil.deviceType == DeviceType.mobile?



                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderDetails(
                      orderHistoryClientController: orderHistoryClientController,
                      index:index,


                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Column(



                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,


                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    child: Image(
                                      image: CachedNetworkImageProvider(orderHistoryClientController.image[index].toString()),

                                      //  fit: BoxFit.cover,
                                      height: 14.h,
                                      width: 22.w,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  //${orderHistoryClientController.foodName?[index]!}
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [


                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child:

                                        SizedBox(
                                          width: 42.w,

                                          child: AutoSizeText("${orderHistoryClientController.foodName?[index]!}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:whiteTextColor)),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text("\€ ${orderHistoryClientController.orders[index].totalPrice}",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color:whiteTextColor))),
                                      ),
                                      SizedBox(height: 0.8.h,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(HelperFunction.getTodayTomorrowOrDateWithYear(orderHistoryClientController.orders[index].orderDate.toString().split(" ")[0]),
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    color:Color(0xff9D9D9D)))),
                                      ),


                                      // Row(
                                      //   mainAxisAlignment:
                                      //   MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Padding(
                                      //       padding: const EdgeInsets.only(left: 8),
                                      //       child: Row(
                                      //         mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //         children: [
                                      //           GestureDetector(
                                      //             onTap: (){
                                      //
                                      //             },
                                      //             child: Container(
                                      //               height: 25,
                                      //               width: 25,
                                      //               decoration: BoxDecoration(
                                      //                   shape: BoxShape.circle,
                                      //                   border: Border.all(
                                      //                       color: mainTextColorwithOpachity)),
                                      //               child: Center(
                                      //                   child: Icon(
                                      //                     Icons.remove,
                                      //                     size: 18,
                                      //                     color: mainTextColorwithOpachity,
                                      //                   )),
                                      //             ),
                                      //           ),
                                      //           SizedBox(width: 10,),
                                      //           // IconButton(
                                      //           //     onPressed: () {},
                                      //           //     style: ButtonStyle(
                                      //           //       side: MaterialStateProperty.all(
                                      //           //         BorderSide(width: 7,color: Colors.black12)
                                      //           //       )
                                      //           //     ),
                                      //           //     color: mainTextColorwithOpachity,
                                      //           //     icon: Icon(
                                      //           //       Icons.remove,
                                      //           //       size: 32,
                                      //           //       color: mainTextColorwithOpachity,
                                      //           //     )),
                                      //           Text("01",
                                      //               style: GoogleFonts.openSans(
                                      //                   textStyle: TextStyle(
                                      //                       fontSize: 13,
                                      //                       fontWeight:
                                      //                       FontWeight.bold,
                                      //                       color:
                                      //                       mainTextColorwithOpachity))),
                                      //           SizedBox(width: 10,),
                                      //           GestureDetector(
                                      //             onTap: (){
                                      //             },
                                      //             child: Container(
                                      //               height: 25,
                                      //               width: 25,
                                      //               decoration: BoxDecoration(
                                      //                   shape: BoxShape.circle,
                                      //                   color:mainTextColorwithOpachity,
                                      //                   border: Border.all(
                                      //                       color:
                                      //                       mainTextColorwithOpachity)),
                                      //               child: Center(
                                      //                   child: Icon(
                                      //                     Icons.add,
                                      //                     size: 18,
                                      //                     color: whiteTextColor,
                                      //                   )),
                                      //             ),
                                      //           ),
                                      //           // IconButton(
                                      //           //     onPressed: () {},
                                      //           //     icon: Icon(
                                      //           //       Icons.add_circle,
                                      //           //       size: 32,
                                      //           //       color:
                                      //           //           mainTextColorwithOpachity,
                                      //           //     )),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //       width: 60,
                                      //     ),
                                      //     Row(
                                      //       children: [
                                      //         Text("\$ 5.00",
                                      //             style: GoogleFonts.openSans(
                                      //                 textStyle: TextStyle(
                                      //                     fontSize: 18,
                                      //                     fontWeight:
                                      //                     FontWeight.bold,
                                      //                     color:mainTextColorwithOpachity))),
                                      //         SizedBox(
                                      //           width: 12,
                                      //         ),
                                      //         SvgPicture.asset(
                                      //           "image/button_icon/trash3file.svg",
                                      //           height: 22,
                                      //           width: 14,
                                      //         )
                                      //       ],
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),

                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [


                                  Container(
                                    height: 5.h,
                                    width: 19.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:(orderHistoryClientController.orders[index].orderStatus  == 1)? statusColorNew:(orderHistoryClientController.orders[index].orderStatus  == 2)? statusColorprocess:(orderHistoryClientController.orders[index].orderStatus  == 3)? statusColorReady :(orderHistoryClientController.orders[index].orderStatus  == 4)? statusColordelivered: Colors.red,
                                    ),
                                    child: Center(
                                      child:Text(orderHistoryClientController.orders[index].orderStatus == 1
                                          ? "Nouveau "
                                          : (orderHistoryClientController.orders[index].orderStatus== 2
                                          ? "En cours de traitement "
                                          : (orderHistoryClientController.orders[index].orderStatus == 3
                                          ? "Prêt à être \nrécupéré"
                                          : (orderHistoryClientController.orders[index].orderStatus == 4
                                          ? "Livré"
                                          : (orderHistoryClientController.orders[index].orderStatus == 5
                                          ? "Remboursée"
                                          : (orderHistoryClientController.orders[index].orderStatus == 6
                                          ? "Annulée"
                                          : "Unknown"))))),

                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:Colors.white))),
                                    ),
                                  ),
                                  SizedBox(height: 1.5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      // SizedBox(width: 0.9.w,),
                                      SvgPicture.asset(
                                        orderHistoryClientController.orders[index].paymentStatus == 0
                                            ? "image/cash2.svg"
                                            : (orderHistoryClientController.orders[index].paymentStatus== 1
                                            ? "image/paid.svg"
                                            : (orderHistoryClientController.orders[index].paymentStatus == 2
                                            ? "image/cash2.svg"
                                            : (orderHistoryClientController.orders[index].paymentStatus == 3
                                            ? "image/meal_voucher.svg"
                                            : "Unknown"))),

                                        //"image/cash.svg",
                                        height: 2.3.h,
                                        width: 2.3.w,
                                        //color: whiteTextColor,
                                      ),
                                      SizedBox(width: 1.w,),

                                      Center(
                                        child: Text(
                                            orderHistoryClientController.orders[index].paymentStatus == 0
                                                ? "Espèces"
                                                : (orderHistoryClientController.orders[index].paymentStatus== 1
                                                ? "Payé"
                                                : (orderHistoryClientController.orders[index].paymentStatus == 2
                                                ? "Livré"
                                                : (orderHistoryClientController.orders[index].paymentStatus == 3
                                                ? "Ticket Resto"
                                                : "Unknown"))),

                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 9.sp,
                                                    // fontWeight: FontWeight.bold,
                                                    color: whiteTextColor))),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),


                        Divider(color: Colors.grey,endIndent: 10,indent: 10,),



                      ],),
                  ),
                ) :

                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderDetails(
                      orderHistoryClientController: orderHistoryClientController,
                      index: index,
                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(



                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,


                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    child: Image(
                                      image: CachedNetworkImageProvider(orderHistoryClientController.image[index].toString()),

                                      //  fit: BoxFit.cover,
                                      height: 10.h,
                                      width: 15.w,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text("${orderHistoryClientController.foodName?[index]!}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:whiteTextColor))),
                                      ),
                                      // SizedBox(height: 1.h,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text("\€ ${orderHistoryClientController.orders[index].totalPrice}",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color:whiteTextColor))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(
                                            HelperFunction.getTodayTomorrowOrDateWithYear(orderHistoryClientController.orders[index].orderDate.toString().split(" ")[0]),
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    color:Color(0xff9D9D9D)))),
                                      ),


                                    ],
                                  ),

                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5, ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [


                                    Container(
                                      height: 6.h,
                                      width: 17.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color:mainTextColor,
                                      ),
                                      child: Center(
                                        child:Text(orderHistoryClientController.orders[index].orderStatus == 1
                                            ? "Nouveau "
                                            : (orderHistoryClientController.orders[index].orderStatus== 2
                                            ? "En cours de traitement "
                                            : (orderHistoryClientController.orders[index].orderStatus == 3
                                            ? "Prêt à être \nrécupéré"
                                            : (orderHistoryClientController.orders[index].orderStatus == 4
                                            ? "Livré"
                                            : (orderHistoryClientController.orders[index].orderStatus == 5
                                            ? "Remboursée"
                                            : (orderHistoryClientController.orders[index].orderStatus == 6
                                            ? "Annulée"
                                            : "Unknown"))))),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:Colors.white))),
                                      ),
                                    ),
                                    SizedBox(height: 1.5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        // SizedBox(width: 0.9.w,),
                                        SvgPicture.asset(
                                          orderHistoryClientController.orders[index].paymentStatus == 0
                                              ? "image/cash2.svg"
                                              : (orderHistoryClientController.orders[index].paymentStatus== 1
                                              ? "image/paid.svg"
                                              : (orderHistoryClientController.orders[index].paymentStatus == 2
                                              ? "image/cash2.svg"
                                              : (orderHistoryClientController.orders[index].paymentStatus == 3
                                              ? "image/meal_voucher.svg"
                                              : "Unknown"))),

                                          //"image/cash.svg",
                                          height: 2.3.h,
                                          width: 2.3.w,
                                          //color: whiteTextColor,
                                        ),
                                        SizedBox(width: 1.w,),

                                        Center(
                                          child: Text(
                                              orderHistoryClientController.orders[index].paymentStatus == 0
                                                  ? "Espèces"
                                                  : (orderHistoryClientController.orders[index].paymentStatus== 1
                                                  ? "Payé"
                                                  : (orderHistoryClientController.orders[index].paymentStatus == 2
                                                  ? "Livré"
                                                  : (orderHistoryClientController.orders[index].paymentStatus == 3
                                                  ? "Ticket Resto"
                                                  : "Unknown"))),

                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 9.sp,
                                                      // fontWeight: FontWeight.bold,
                                                      color: whiteTextColor))),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),


                        Divider(color: Colors.grey,endIndent: 10,indent: 10,),



                      ],),
                  ),
                );
              }















              ,)




        );
      }

    }())





    );


  }
}
//
// for(var i=0; i<orderHistoryClientController.foodArry.length;i++){
// if(orderHistoryClientController.foodArry[index].id == orderHistoryClientController.orderHistory.value?.orders![index].foodId){
// String? name = orderHistoryClientController.foodArry[index].foodName;



