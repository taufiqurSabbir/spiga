import 'package:laspigadoro/owner/controller/liste_controller.dart';
import 'package:laspigadoro/owner/publier_une_offre_deatails_page_56.dart';
import 'package:laspigadoro/owner/publier_une_offre_page_52.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/owner/home_page_45.dart';
import 'package:laspigadoro/owner/mes_offers.dart';
import 'package:laspigadoro/owner/profile_48.dart';
import 'package:sizer/sizer.dart';

import '../client/controllar/order_details_controller.dart';
import '../const/const.dart';
import 'common_widget/custom_bottom_navigation_black.dart';
import 'controller/order_number_controller.dart';
import 'mes_commandes_page_44.dart';
import 'notification_send.dart';

class ProfilePageAdmin extends StatefulWidget {
  ProfilePageAdmin({Key? key}) : super(key: key);

  @override
  State<ProfilePageAdmin> createState() => _ProfilePageAdminState();
}

class _ProfilePageAdminState extends State<ProfilePageAdmin> {
  var curentIndex=1;
  // final ListeControllerOwner controller_listeController = Get.put(ListeControllerOwner());
  final OrderNumberController orderCountController = Get.find();

  @override
  void initState() {
    super.initState();
    orderCountController.getOrderNumber();
  }



  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Obx(() =>
        Scaffold(
            backgroundColor: bottomShetColor,
            bottomNavigationBar: CustomBottomNavigationBarBlack(
              currentIndex: curentIndex,
            ),

            body: SizerUtil.deviceType == DeviceType.mobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>PersonalInfoPageAdmin()));
                        },

                        child: Container(
                          height: size.height*0.18,
                          width: (size.width*0.5)- (15*2) - 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffDFE7D6)),
                              color: Colors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("image/person.svg"),
                              SizedBox(height: 10,),
                              Text("Mon Profil",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: mainTextColor))),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>MesCommandesPageAdmin()));
                        },
                        child: Container(
                          height: size.height*0.18,
                          width: (size.width*0.5)- (15*2) - 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffDFE7D6)),
                              color: Colors.white
                          ),

                          child: Stack(


                            children: [

                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          SvgPicture.asset("image/noun_basket.svg",color: mainTextColor,),


                                          Visibility(
                                            visible: orderCountController.order_number.value != 0,
                                            child: Positioned(
                                              left: orderCountController.order_number.value.toString().length >2 ? 16 : 18,
                                              bottom: 18,
                                              child: Container(

                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle, color: Color(0xffFEA31B)),
                                                child: Text(" ${orderCountController.order_number.value} ", style: TextStyle(color: Colors.white),),

                                              ),
                                            ),
                                          ),

                                        ]
                                    ),

                                    SizedBox(height: 10,),
                                    Text("Commandes",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: mainTextColor)))
                                  ],

                                ),
                              )

                            ],
                          ),





                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>UploadedFoodsPageAdmin()));
                        },

                        child: Container(
                          height: size.height*0.18,
                          width: (size.width*0.5)- (15*2) - 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffDFE7D6)),
                              color: Colors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("image/percent.svg"),
                              SizedBox(height: 10,),
                              Text("Créer une offre",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: mainTextColor))),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationSend()));
                        },
                        child: Container(
                          height: size.height*0.18,
                          width: (size.width*0.5)- (15*2) - 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffDFE7D6)),
                              color: Colors.white
                          ),

                          child: Stack(


                            children: [

                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          SvgPicture.asset("image/notification.svg",color: mainTextColor,),

                                        ]
                                    ),

                                    SizedBox(height: 10,),
                                    Text("Notification",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: mainTextColor)))
                                  ],

                                ),
                              )

                            ],
                          ),





                        ),
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30),
                //   child: InkWell(
                //     onTap: (){
                //       // Navigator.push(context, MaterialPageRoute(builder: (_)=>PublierUneOffrePage()));
                //       Navigator.push(context, MaterialPageRoute(builder: (_)=>UploadedFoodsPageAdmin()));
                //
                //
                //     },
                //     child: Container(
                //       height: size.height*0.18,
                //       width: size.width,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(15),
                //         color: Colors.white
                //       ),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset("image/percent.svg"),
                //           SizedBox(height: 10,),
                //           Text("Créer une offre",
                //               style: GoogleFonts.openSans(
                //                   textStyle: TextStyle(
                //                       fontSize: 14,
                //                       fontWeight: FontWeight.bold,
                //                       color: mainTextColor))),
                //         ],
                //       ),
                //     ),
                //   ),
                // )


              ],)
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>PersonalInfoPageAdmin()));
                        },

                        child: Container(
                          height: 170,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffDFE7D6)),
                              color: Colors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("image/person.svg"),
                              SizedBox(height: 10,),
                              Text("Mon Profil",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: mainTextColor))),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>MesCommandesPageAdmin()));
                        },
                        child: Container(
                          height: 170,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffDFE7D6)),
                              color: Colors.white
                          ),

                          child: Stack(


                            children: [

                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          SvgPicture.asset("image/noun_basket.svg",color: mainTextColor,),


                                          Visibility(
                                            visible: true,
                                            child: Positioned(
                                              left: 20,
                                              bottom: 18,
                                              child: Container(

                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle, color: Color(0xffFEA31B)),
                                                child: Text("12", style: TextStyle(color: Colors.white),),

                                              ),
                                            ),
                                          ),

                                        ]
                                    ),

                                    SizedBox(height: 10,),
                                    Text("Commandes",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: mainTextColor)))
                                  ],

                                ),
                              )

                            ],
                          ),





                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>UploadedFoodsPageAdmin()));
                        },

                        child: Container(
                          height: size.height*0.18,
                          width: (size.width*0.5)- (15*2) - 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffDFE7D6)),
                              color: Colors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("image/percent.svg"),
                              SizedBox(height: 10,),
                              Text("Créer une offre",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: mainTextColor))),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationSend()));
                        },
                        child: Container(
                          height: size.height*0.18,
                          width: (size.width*0.5)- (15*2) - 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffDFE7D6)),
                              color: Colors.white
                          ),

                          child: Stack(


                            children: [

                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          SvgPicture.asset("image/notification.svg",color: mainTextColor,),

                                        ]
                                    ),

                                    SizedBox(height: 10,),
                                    Text("Notification",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: mainTextColor)))
                                  ],

                                ),
                              )

                            ],
                          ),





                        ),
                      ),
                    ],
                  ),
                ),


              ],)
        )
    );

  }
}
