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

import 'controller/choisir_votre_admin_47_controller.dart';
import 'controller/publish&draft_controller.dart';
import '../helper/helper_function.dart';
import 'Public_Draft_Edit_Delete/draft_and_public_edit.dart';


class UploadedFoodsPageAdmin extends StatefulWidget {
  const UploadedFoodsPageAdmin({Key? key}) : super(key: key);

  @override
  State<UploadedFoodsPageAdmin> createState() => _UploadedFoodsPageAdminState();
}

class _UploadedFoodsPageAdminState extends State<UploadedFoodsPageAdmin> {
  final PublishAndDraftControllerOwner controller_PublishAndDraft = Get.put(PublishAndDraftControllerOwner());


  // @override
  // void initState() {
  //   super.initState();
  //
  //   controller_choisirVotreAdmin.getBoutique();
  // }

  @override
  void initState() {
    super.initState();
    controller_PublishAndDraft.getPublishAndDrafList();
  }




  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(() =>

    ((){
      if(controller_PublishAndDraft.showLoader.value  == true){
        return Container(
          color: bottomShetColor,
          child: loaderSquare,
        );
      }
      else{

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: bottomShetColor,
            elevation: 1,
            title: Text("Mes Offers",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: whiteTextColor))),
            leading: InkWell(
              onTap: () {
                // Navigator
                //     .of(context)
                //     .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                //   return new ProfilePage();
                // }));

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
          backgroundColor: bottomShetColor,
          body:         ListView.builder(
            shrinkWrap: true,
            primary: false,

            itemCount: controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj.length,
            itemBuilder: (context, index) {
              for(var i =0 ; i<controller_PublishAndDraft.boutiqueArray.length; i++ ){
                if(controller_PublishAndDraft.boutiqueArray[i].id == controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].boutiqueId){
                  String name =  controller_PublishAndDraft.boutiqueArray[i].boutiqueName!;
                  return    Padding(

                      padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.h),
                      child: Column(
                        children: [

                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>Draft_and_public(
                                target_food: controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index],
                              )));
                              },
                            child: Container(

                              width: size.width,
                              decoration: BoxDecoration(color: bottomShetColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [



                                  Row(
                                    children: [
                                      ClipRRect(
                                        child:
                                        SizerUtil.deviceType == DeviceType.mobile ?

                                        Image(
                                          image: CachedNetworkImageProvider(controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].thumbnailImage!),

                                          //  fit: BoxFit.cover,
                                          height: 11.h,
                                          width: 22.w,
                                        ) :  Image(
                                          image: CachedNetworkImageProvider(controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].thumbnailImage!),
                                          fit: BoxFit.cover,
                                          height: 16.h,
                                          width: 20.w,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),



                                      SizedBox(width: 2.w,),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: SizedBox(
                                              width: 45.w,
                                              child: AutoSizeText(
                                                "${controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].foodName}",
                                                style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: whiteTextColor,
                                                  ),
                                                ),
                                                maxLines: 2,
                                              ),
                                            )
                                          ),


                                          // Padding(
                                          //   padding: EdgeInsets.only(top: 5),
                                          //   child: Text(
                                          //     "${controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].foodName}",
                                          //     style: GoogleFonts.openSans(
                                          //       textStyle: TextStyle(
                                          //         fontSize: 10.sp,
                                          //         fontWeight: FontWeight.bold,
                                          //         color: whiteTextColor,
                                          //       ),
                                          //     ),
                                          //     overflow: TextOverflow.ellipsis,
                                          //     maxLines: 2,
                                          //   ),
                                          // ),

                                          SizedBox(height: 6,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "image/clock (1).svg",
                                                height: 1.8.h,
                                                width: 1.8.w,
                                                color: whiteTextColor,
                                              ),
                                              SizedBox(width: 4,),
                                              RichText(text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "Pick up:", style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 9.sp,
                                                            fontWeight: FontWeight.normal,
                                                            color: whiteTextColor))
                                                    ),
                                                    TextSpan(

                                                        text: " ${controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].pickupTimeFrom!} - ${controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].pickupTimeTo!}", style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 9.sp,
                                                            fontWeight: FontWeight.bold,
                                                            color: whiteTextColor))
                                                    )
                                                  ]
                                              )),
                                            ],
                                          ),

                                          SizedBox(height: 2),

                                          //controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].pickupDateFrom!
                                          Text("${HelperFunction.convertDateFormatWithYear(controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].pickupDateFrom!)} ",
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 9.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xff9D9D9D)))),





                                          Text( name,
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xffD2FC94)))),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 3.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].hideShow == 1? mainTextColorwithOpachity :draftcolor,
                                              ),
                                              child: Center(child: Text(
                                                  controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].hideShow == 0 ? "Draft" : (controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].hideShow == 1 ? "Publier" : ""),

                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 9.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: whiteTextColor))),),

                                            ),
                                            SizedBox(height: 10,),
                                            Text("${controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].foodStock} plats dispos",
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color:Color(0xffFC8181)))),
                                            SizedBox(height: 10,),
                                            Text(controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].foodType == 1 ? "Plat" : "Panier surprise",
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 7.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: whiteTextColor),),),

                                            SizedBox(height: 10,),
                                            Text("${HelperFunction.stringToCurrency(controller_PublishAndDraft.publishAndDrafArrayWithDateTimeObj[index].price
                                                .toString(), "€")}",
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 7.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: whiteTextColor),),),
                                            // SizedBox(height: 15,),

                                            SizedBox(height: 10,),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 1.w
                                        ,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14,),
                                          SizedBox(height: 15,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ),
                          Divider(color: Colors.grey.withOpacity(0.5),endIndent: 10,indent: 10, ),

                        ]
                      )


                  );

                }


              }

            },



            //Divider(color: Colors.grey,endIndent: 10,indent: 10, ),


            // ListTile(
            //   leading: ClipRRect(
            //     child: Image(
            //       image: AssetImage(
            //         "image/header-generic.png",
            //       ),
            //       fit: BoxFit.fill,
            //       height: 84,
            //       width: 72,
            //     ),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   title: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Pasta a la carbonara",
            //           style: GoogleFonts.openSans(
            //               textStyle: TextStyle(
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.bold,
            //                   color: whiteTextColor))),
            //       //SizedBox(height: 4,),
            //
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           SvgPicture.asset(
            //             "image/clock (1).svg",
            //             height: 16,
            //             width: 16,
            //             color: whiteTextColor,
            //           ),
            //           SizedBox(width: 4,),
            //           RichText(text: TextSpan(
            //               children: [
            //                 TextSpan(
            //                     text: "Pick up:", style: GoogleFonts.openSans(
            //                     textStyle: TextStyle(
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.normal,
            //                         color: whiteTextColor))
            //                 ),
            //                 TextSpan(
            //                     text: " 05:30 PM - 06:00 PM", style: GoogleFonts.openSans(
            //                     textStyle: TextStyle(
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.bold,
            //                         color: whiteTextColor))
            //                 )
            //               ]
            //           )),
            //         ],
            //       ),
            //       //  SizedBox(height: 4,),
            //
            //       Text("02 Janvier 2023",
            //           style: GoogleFonts.openSans(
            //               textStyle: TextStyle(
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.bold,
            //                   color: Color(0xff9D9D9D)))),
            //
            //
            //
            //       Text("Rueil-Malmaison",
            //           style: GoogleFonts.openSans(
            //               textStyle: TextStyle(
            //                   fontSize: 13,
            //                   fontWeight: FontWeight.bold,
            //                   color: Color(0xffD2FC94)))),
            //     ],
            //   ),
            //
            // )

            // Container(
            //   height: 120,
            //   width: size.width,
            //   decoration: BoxDecoration(color: bottomShetColor),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         ClipRRect(
            //           child: Image(
            //             image: AssetImage(
            //               "image/header-generic.png",
            //             ),
            //             fit: BoxFit.fill,
            //             height: 81,
            //             width: 82,
            //           ),
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(left: 10),
            //               child: Text("Pasta a la carbonara",
            //                   textAlign: TextAlign.center,
            //                   style: GoogleFonts.openSans(
            //                       textStyle: TextStyle(
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.bold,
            //                           color:whiteTextColor))),
            //             ),
            //             SizedBox(height: 10,),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 10),
            //               child: Text("\€ 5.00",
            //                   style: GoogleFonts.openSans(
            //                       textStyle: TextStyle(
            //                           fontSize: 16,
            //                           fontWeight:
            //                           FontWeight.bold,
            //                           color:whiteTextColor))),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 10),
            //               child: Text("02 Janvier 2023",
            //                   style: GoogleFonts.openSans(
            //                       textStyle: TextStyle(
            //                           fontSize: 13,
            //                           fontWeight:
            //                           FontWeight.normal,
            //                           color:Color(0xff9D9D9D)))),
            //             ),
            //             // Row(
            //             //   mainAxisAlignment:
            //             //   MainAxisAlignment.spaceBetween,
            //             //   children: [
            //             //     Padding(
            //             //       padding: const EdgeInsets.only(left: 8),
            //             //       child: Row(
            //             //         mainAxisAlignment:
            //             //         MainAxisAlignment.spaceBetween,
            //             //         children: [
            //             //           GestureDetector(
            //             //             onTap: (){
            //             //
            //             //             },
            //             //             child: Container(
            //             //               height: 25,
            //             //               width: 25,
            //             //               decoration: BoxDecoration(
            //             //                   shape: BoxShape.circle,
            //             //                   border: Border.all(
            //             //                       color: mainTextColorwithOpachity)),
            //             //               child: Center(
            //             //                   child: Icon(
            //             //                     Icons.remove,
            //             //                     size: 18,
            //             //                     color: mainTextColorwithOpachity,
            //             //                   )),
            //             //             ),
            //             //           ),
            //             //           SizedBox(width: 10,),
            //             //           // IconButton(
            //             //           //     onPressed: () {},
            //             //           //     style: ButtonStyle(
            //             //           //       side: MaterialStateProperty.all(
            //             //           //         BorderSide(width: 7,color: Colors.black12)
            //             //           //       )
            //             //           //     ),
            //             //           //     color: mainTextColorwithOpachity,
            //             //           //     icon: Icon(
            //             //           //       Icons.remove,
            //             //           //       size: 32,
            //             //           //       color: mainTextColorwithOpachity,
            //             //           //     )),
            //             //           Text("01",
            //             //               style: GoogleFonts.openSans(
            //             //                   textStyle: TextStyle(
            //             //                       fontSize: 13,
            //             //                       fontWeight:
            //             //                       FontWeight.bold,
            //             //                       color:
            //             //                       mainTextColorwithOpachity))),
            //             //           SizedBox(width: 10,),
            //             //           GestureDetector(
            //             //             onTap: (){
            //             //             },
            //             //             child: Container(
            //             //               height: 25,
            //             //               width: 25,
            //             //               decoration: BoxDecoration(
            //             //                   shape: BoxShape.circle,
            //             //                   color:mainTextColorwithOpachity,
            //             //                   border: Border.all(
            //             //                       color:
            //             //                       mainTextColorwithOpachity)),
            //             //               child: Center(
            //             //                   child: Icon(
            //             //                     Icons.add,
            //             //                     size: 18,
            //             //                     color: whiteTextColor,
            //             //                   )),
            //             //             ),
            //             //           ),
            //             //           // IconButton(
            //             //           //     onPressed: () {},
            //             //           //     icon: Icon(
            //             //           //       Icons.add_circle,
            //             //           //       size: 32,
            //             //           //       color:
            //             //           //           mainTextColorwithOpachity,
            //             //           //     )),
            //             //         ],
            //             //       ),
            //             //     ),
            //             //     SizedBox(
            //             //       width: 60,
            //             //     ),
            //             //     Row(
            //             //       children: [
            //             //         Text("\$ 5.00",
            //             //             style: GoogleFonts.openSans(
            //             //                 textStyle: TextStyle(
            //             //                     fontSize: 18,
            //             //                     fontWeight:
            //             //                     FontWeight.bold,
            //             //                     color:mainTextColorwithOpachity))),
            //             //         SizedBox(
            //             //           width: 12,
            //             //         ),
            //             //         SvgPicture.asset(
            //             //           "image/button_icon/trash3file.svg",
            //             //           height: 22,
            //             //           width: 14,
            //             //         )
            //             //       ],
            //             //     )
            //             //   ],
            //             // )
            //           ],
            //         ),
            //         Expanded(
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 10),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text("2 plats disponibles",
            //                     overflow: TextOverflow.fade,
            //                     textAlign: TextAlign.center,
            //                     style: GoogleFonts.openSans(
            //                         textStyle: TextStyle(
            //                             fontSize: 10,
            //                             fontWeight: FontWeight.bold,
            //                             color:Color(0xffFC8181)))),
            //                 SizedBox(height: 10,),
            //                 Container(
            //                   height: 41,
            //                   width: 136,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     color:mainTextColor,
            //                   ),
            //                   child: Center(
            //                     child: Text("Commander",
            //                         textAlign: TextAlign.center,
            //                         style: GoogleFonts.openSans(
            //                             textStyle: TextStyle(
            //                                 fontSize: 12,
            //                                 fontWeight: FontWeight.bold,
            //                                 color:Colors.white))),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 35, right: 35),
            child: Container(
              height: 48,
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                  borderRadius: BorderRadius.circular(25),
                  color:mainTextColor
              ),
              child: Align(
                alignment: Alignment.bottomCenter,

                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>PublierUneOffrePage()));
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("image/percent.svg" , color: Colors.white, width: 15,),
                        SizedBox(width: 15,),
                        Text("Créer une offre",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: whiteTextColor))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }

    }())





    );


  }
}
