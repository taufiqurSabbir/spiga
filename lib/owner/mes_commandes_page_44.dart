import 'package:auto_size_text/auto_size_text.dart';
import 'package:laspigadoro/owner/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller/choisir_votre_admin_47_controller.dart';
import 'controller/mes_commandes_admin_controller.dart';
import 'controller/order_number_controller.dart';
import 'controller/publish&draft_controller.dart';
import '../helper/helper_function.dart';

class MesCommandesPageAdmin extends StatefulWidget {
  const MesCommandesPageAdmin({Key? key}) : super(key: key);

  @override
  State<MesCommandesPageAdmin> createState() => _MesCommandesPageAdminState();
}

class _MesCommandesPageAdminState extends State<MesCommandesPageAdmin> {
  final MesCommandesAdminControllerOwner controller_mesCommandesAdmin = Get.put(MesCommandesAdminControllerOwner());
  final OrderNumberController orderCountController = Get.find();


  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    orderCountController.getOrderNumber();
    controller_mesCommandesAdmin.getOrderList();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    orderCountController.getOrderNumber();

    controller_mesCommandesAdmin.getOrderList();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }



  Color? color;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller_mesCommandesAdmin.getOrderList();
    orderCountController.getOrderNumber();


  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));





    return Obx(() =>

    ((){
      if(controller_mesCommandesAdmin.showLoader.value  == true){
        return Container(
          color: bottomShetColor,
          child: loaderSquare,
        );
      }
      else{

        return Scaffold(
          backgroundColor:   bottomShetColor,
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: bottomShetColor,
            elevation: 1,
            title: Text("Mes commandes",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: whiteTextColor))),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
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
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropMaterialHeader(
              backgroundColor: mainTextColor,
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj.length,
              itemBuilder: (context, index) {

                if(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 0){
                  String status = "Espèces";


                }else if(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 1){
                  String status = "Payé";

                }else if(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 2){
                  String status = "Livré";

                }else if(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 3){
                  String status = "Ticket Resto";
                }





                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OwnerOrderDetails(
                        id: controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].id!

                    )));
                  },
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 17.0),
                          child: SizerUtil.deviceType == DeviceType.mobile
                              ? Container( // Widget for Mobile

                            // height: 18.0.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


                                    SizedBox(
                                      width: 50.w,
                                      child: AutoSizeText(
                                        "${controller_mesCommandesAdmin.foodName[index]}",
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor,
                                          ),
                                        ),
                                        maxLines: 4,
                                      ),
                                    ),


                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "image/clock (1).svg",
                                          height: 16,
                                          width: 16,
                                          color: whiteTextColor,
                                        ),
                                        SizedBox(width: 7,),
                                        RichText(text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "Pick up:",
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal,
                                                          color: whiteTextColor))
                                              ),
                                              TextSpan(
                                                  text: " ${controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].customerPickupTimeFrom!}",
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          color: whiteTextColor))
                                              )
                                            ]
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 12,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "image/person_circle.svg",
                                          height: 16,
                                          width: 16,
                                          color: mainTextColor,
                                        ),
                                        SizedBox(width: 4,),
                                        SizedBox(
                                          width: 50.w,
                                          child: AutoSizeText(controller_mesCommandesAdmin.selectedUser[index].name ?? "Pas de nom disponible",
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: whiteTextColor)),
                                          maxLines: 4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 0.5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "image/phone_cricle.svg",
                                          height: 16,
                                          width: 16,
                                          color: mainTextColor,
                                        ),
                                        SizedBox(width: 4,),
                                        GestureDetector(
                                          onTap: () async {
                                            if(controller_mesCommandesAdmin.selectedUser[index].phone != null) {
                                              String urlString = 'tel:${controller_mesCommandesAdmin
                                                  .selectedUser[index].phone}';
                                              Uri uri = Uri.parse(urlString);

                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(uri);
                                              } else {
                                                throw 'Could not launch';
                                              }
                                            }
                                          },
                                          child: SizedBox(
                                            width: 50.w,
                                            child: AutoSizeText(
                                              controller_mesCommandesAdmin.selectedUser[index].phone ?? "Pas de numéro disponible",
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: whiteTextColor
                                                  )
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 0.5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "image/email_circle.svg",
                                          height: 16,
                                          width: 16,
                                          color: mainTextColor,
                                        ),
                                        SizedBox(width: 4,),
                                        SizedBox(
                                          width: 50.w,
                                          child: AutoSizeText(controller_mesCommandesAdmin.selectedUser[index].email ?? "Pas de é-mail disponible",
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: whiteTextColor)),
                                           maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 1.h,),
                                    Text(controller_mesCommandesAdmin.shopName[index],
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffD2FC94)))),
                                  ],
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 0)? speciescolor:(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 1)? mainTextColorwithOpachity:(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 2)? bookedcolor :(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 3)? ticketcolor: Colors.red

                                          ),
                                          child: Center(child: Text(
                                              controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 0
                                                  ? "Espèces"
                                                  : (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 1
                                                  ? "Payé"
                                                  : (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 2
                                                  ? "Livré"
                                                  : (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 3
                                                  ? "Ticket Resto"
                                                  : "Unknown"))),

                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: whiteTextColor))),),

                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 1
                                              ? "Nouveau "
                                              : controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 2
                                              ? "En cours de\ntraitement"
                                              : controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 3
                                              ? "Prêt à être\n  récupéré"
                                              : controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 4
                                              ? "Livré"
                                              : controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 5
                                              ? "Remboursée"
                                              : "Annulée",
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 1
                                                  ? Colors.yellow
                                                  : controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 2
                                                  ? Colors.green
                                                  : controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 3
                                                  ? Colors.red
                                                  : controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 4
                                                  ? Colors.blue
                                                  : controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderStatus == 5
                                                  ? Colors.purple
                                                  : Colors.teal
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        Text("${HelperFunction.stringToCurrency(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].totalPrice!, '€')}",
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: whiteTextColor),),),
                                        // SizedBox(height: 15,),
                                        //${HelperFunction.convertDateFormatWithYear(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderDate!)}
                                        Text(" ${HelperFunction.convertDateFormatWithYear(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderDate.toString()!)}",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff9D9D9D)))),
                                        SizedBox(height: 15,),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_forward_ios_rounded,
                                          color: Colors.white, size: 14,),
                                        SizedBox(height: 15,),
                                      ],
                                    ),

                                  ],

                                ),

                              ],
                            ),

                          )
                              : Container( // Widget for Tablet

                            height: 14.5.h,


                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller_mesCommandesAdmin.foodName[index],
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: whiteTextColor))),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "image/clock (1).svg",
                                          height: 1.7.h,
                                          width: 1.7.w,
                                          color: whiteTextColor,
                                        ),
                                        SizedBox(width: 1.w,),
                                        RichText(text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "Pick up:",
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 6.sp,
                                                          fontWeight: FontWeight
                                                              .normal,
                                                          color: whiteTextColor))
                                              ),
                                              TextSpan(
                                                  text: " ${HelperFunction.splitTime(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].pickupTime!)}",
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 6.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: whiteTextColor))
                                              )
                                            ]
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Text("${controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].customerName}",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 7.sp,
                                                fontWeight: FontWeight.bold,
                                                color: whiteTextColor))),
                                    SizedBox(height: 15,),
                                    Text(controller_mesCommandesAdmin.shopName[index],
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 7.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffD2FC94)))),
                                  ],
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          height: 4.h,
                                          width: 14.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              //(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 0)? Colors.green:(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 1)? mainTextColor:(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 2)? ticketcolor :(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 3)? Colors.green: (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 4)? speciescolor:(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 0)? Colors.green: Colors.green),
                                              color: (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 0)? speciescolor:(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 1)? mainTextColorwithOpachity:(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 2)? bookedcolor :(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 3)? ticketcolor: Colors.red),
                                          child: Center(child: Text(
                                              controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 0
                                                  ? "Espèces"
                                                  : (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 1
                                                  ? "Payé"
                                                  : (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 2
                                                  ? "Livré"
                                                  : (controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].paymentStatus == 3
                                                  ? "Ticket Resto"
                                                  : "Unknown"))),
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 6.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: whiteTextColor))),),

                                        ),
                                        // SizedBox(height: 15,),
                                        Text( HelperFunction.dynamicToCurrency(controller_mesCommandesAdmin.price[index], controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].quantity!, "€"),
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.bold,
                                                color: whiteTextColor),),),
                                        // SizedBox(height: 15,),
                                        Text(" ${HelperFunction.convertDateFormatWithYear(controller_mesCommandesAdmin.orderArrayWithOrderDateInDateTimeObj[index].orderDate.toString()!)}",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 6.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff9D9D9D)))),
                                        SizedBox(height: 15,),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_forward_ios_rounded,
                                          color: Colors.white, size: 8.sp,),
                                        SizedBox(height: 15,),
                                      ],
                                    ),


                                  ],
                                ),
                              ],
                            ),

                          )
                      ),
                      Divider(color: Colors.grey.withOpacity(0.5),endIndent: 15,indent: 15, ),

                    ],
                  ),
                );



              },



            ),
          ),
        );
      }

    }())





    );

  }
}