import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:laspigadoro/owner/model/Allergy.dart';
import 'package:laspigadoro/owner/model/Boutique.dart';
import 'package:laspigadoro/owner/model/Mystery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:laspigadoro/owner/model/Food.dart';
import '../../helper/helper_function.dart';

import '../../const/const.dart';
import '../controller/Public_Draft_Edit_Delete/food_edit_controller.dart';
import '../controller/publish&draft_controller.dart';
import '../controller/publish_and_draft__show_controller.dart';
import 'edit_food_offer.dart';

import '../model/FoodCat.dart' as FoodCat;
import '../../dialogue/Dialogue.dart' as MyDialogue;



class Draft_and_public extends StatefulWidget {
  FoodWithCreatedAtUpdatedAtInDateTimeObj target_food;
   Draft_and_public({Key? key, required this.target_food}) : super(key: key);

  @override
  State<Draft_and_public> createState() => _Draft_and_publicState();
}

class _Draft_and_publicState extends State<Draft_and_public> {
  final PublishAndDraftShowController draftAndPublicEditControler = Get.put(PublishAndDraftShowController());

  final FoodEditController controller_foodEditController = Get.put(FoodEditController());


  @override
  void initState() {
    super.initState();
    draftAndPublicEditControler.getPublishAndDrafList();
    draftAndPublicEditControler.getAllergy();
    draftAndPublicEditControler.getSurpriseType();
    draftAndPublicEditControler.getFoodCat();

  }


  @override

  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    var size = MediaQuery.of(context).size;
    return   Obx(()=>
        Scaffold(
          appBar: draftAndPublicEditControler.showLoader.value == false ? AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: bottomShetColor,
            elevation: 1,
            title: Text("Détails de l'offre alimentaire",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: whiteTextColor))),
            leading: Padding(
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
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 10),
            //     child: InkWell(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (_) => NotificationPage()));
            //         },
            //         child: Icon(
            //           Icons.done,
            //           size: 31,
            //           color: whiteTextColor,
            //         )),
            //   )
            // ],
          ) : null,
          backgroundColor: bottomShetColor,
          bottomNavigationBar:draftAndPublicEditControler.showLoader.value == false ? Container(
            height: size.height*0.2,
            width: size.width,
            color: bottomShetColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.target_food.hideShow == 1
                ? GestureDetector(
                    onTap: (){
                      controller_foodEditController.draftFoodOffer(widget.target_food.id!);
                    },
                    child: Container(
                        height: 54,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xff44680E).withOpacity(1),
                        ),
                        child: Center(
                            child: Text(
                              "Draft",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfFFFFFF).withOpacity(1))),
                            ))
                    )
                )
                : GestureDetector(
                    onTap: (){
                      //widget.controller_foodUploadController.postFoods();

                      controller_foodEditController.publishFoodOffer(widget.target_food.id!);
                    },
                    child: Container(
                        height: 54,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xff44680E).withOpacity(1),
                        ),
                        child: Center(
                            child: Text(
                              "Publier",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfFFFFFF).withOpacity(1))),
                            ))
                    )
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>EditFoodOffer(target_food: widget.target_food, controller_foodEditController: controller_foodEditController)));
                        },
                        child: Container(
                            height: 51,
                            width: 38.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xff407CE5).withOpacity(1),
                            ),
                            child: Center(
                                child: Text(
                                  "Modifier",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfFFFFFF).withOpacity(1))),
                                ))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: (){
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.bottomSlide,
                              title: 'Es-tu sûr?',
                              desc: 'Cette offre alimentaire sera supprimée.',
                              btnOkText: 'D\'accord',
                              btnOkColor: Colors.red,
                              btnCancelText: 'Annuler',
                              btnCancelColor: Colors.green,
                              btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            controller_foodEditController.deleteFoodOffer(widget.target_food.id!);
                          },
                          ).show();


                          //Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsPage()));

                          // widget.controller_foodUploadController.resetAllValue();
                          // Navigator.pop(context);

                        },
                        child: Container(
                            height: 51,
                            width: 38.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xffE5407E).withOpacity(1),
                            ),
                            child: Center(
                                child: Text(
                                  "Supprimer",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfFFFFFF).withOpacity(1))),
                                ))),
                      ),
                    )
                  ],
                )

              ],),
          ) : null,



          body: draftAndPublicEditControler.showLoader.value == true
              ? loaderSquare
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Food image
                Container(
                    height:250,
                    decoration: BoxDecoration(
                        color: Color(0xff606060).withOpacity(0.1),
                        image: DecorationImage(image: NetworkImage(widget.target_food.foodImage!),fit: BoxFit.cover))
                ),

                SizedBox(
                  height: 15,
                ),


                widget.target_food.listImage !=widget.target_food.foodImage ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Photo liste produits (facultatif)",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child :
                        GestureDetector(
                            onTap: () {
                            //  ImagePicarBottomSheet(2);
                            },
                            child: Container(
                                height:147,
                                decoration: BoxDecoration(
                                    color: Color(0xff606060).withOpacity(0.1),
                                    image: DecorationImage(

                                      image: NetworkImage(widget.target_food.listImage.toString()),

                                    ))
                            )
                        )
                    ),
                    SizedBox(height: 15,),
                  ],
                ) : Container(),



                widget.target_food.thumbnailImage  !=widget.target_food.foodImage
                    ?  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Image miniature (facultatif)",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child :
                        GestureDetector(
                            onTap: () {
                            //  ImagePicarBottomSheet(2);
                            },
                            child: Container(
                                height:140,
                                width: 35.w,
                                decoration: BoxDecoration(
                                    color: Color(0xff606060).withOpacity(0.1),
                                    image: DecorationImage(

                                      image: NetworkImage(widget.target_food.thumbnailImage.toString()),

                                    )


                                )
                            )
                        )
                    ),


                    SizedBox(height: 15,),
                  ],
                ) : Container(),



                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>TitreDeLoffrePage()));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text("Titre de l'offre",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  color: greyTextXolor))),
                    ),
                    subtitle: Padding(
                      padding:  EdgeInsets.only(bottom: 8),
                      child: Text("${widget.target_food.foodName}",
                    //  Text("${widget.controller_foodUploadController.foodName.value}",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    tileColor: Color(0xff606060).withOpacity(0.1),
                  ),
                ),

                Divider(
                  color: Colors.black,
                  height: 2,
                ),

                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>TitreDeLoffrePage()));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8, top:8),
                      child: Text("Description",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  color: greyTextXolor))),
                    ),
                    subtitle: Padding(
                      padding:  EdgeInsets.only(bottom: 8),
                      child:  Container(
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                  children: [


                                    Html(
                                      data: "${widget.target_food.foodDescription}",
                                      style: {
                                        "*": Style(
                                          fontFamily: 'Open Sans',
                                          fontSize: FontSize(10.sp),
                                          color: Colors.white,
                                        ),
                                      },
                                    ),
                                    // Text("${widget.target_food.foodDescription}",
                                    //     style: GoogleFonts.openSans(
                                    //         textStyle: TextStyle(
                                    //             fontSize: 10.sp,
                                    //             fontWeight: FontWeight.bold,
                                    //             color: whiteTextColor
                                    //         )
                                    //     )

                                   // )
                                  ]
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    tileColor: Color(0xff606060).withOpacity(0.1),
                  ),
                ),




                Divider(
                  color: Colors.black,
                  height: 2,
                ),
                ListTile(
                  title: Text("Stock",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                  trailing: Wrap(
                    children:<Widget> [
                      Container(
                        height: 22,
                        width: 47,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: mainTextColor
                        ),
                        child: Center(child: Text("${widget.target_food.foodStock}",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: whiteTextColor))),),
                      ),
                      SizedBox(width: 10,),
                      Icon(

                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  tileColor: Color(0xff606060).withOpacity(0.1),

                ),
                Divider(
                  color: Colors.black,
                  height: 2,
                ),
                ListTile(
                  title: Text("Prix réduit",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                  trailing: Wrap(
                    children:<Widget> [
                      Text("${HelperFunction.stringToCurrency(widget.target_food.price.toString(), "€ ")}",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                      SizedBox(width: 10,),
                      Icon(

                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  tileColor: Color(0xff606060).withOpacity(0.1),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black,
                  height: 2,
                ),
                ListTile(
                  title: Text("Prix initial",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                  trailing: Wrap(
                    children:<Widget> [
                      Text("${HelperFunction.stringToCurrency(widget.target_food.discountPrice.toString(), "€ ")}",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                      SizedBox(width: 10,),
                      Icon(

                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  tileColor: Color(0xff606060).withOpacity(0.1),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black,
                  height: 2,
                ),



                Padding(
                  padding: const EdgeInsets.only(left: 15,right:15, top: 15),
                  child: Text("Type d'offre",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                ),


                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(

                                backgroundColor: widget.target_food.foodType == 1
                                    ? MaterialStateProperty.all(mainTextColor)
                                    : MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Color(0xff5B5B5B)))),
                            onPressed: () {},
                            child: Text("Plat",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor)))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: widget.target_food.foodType == 2
                                    ? MaterialStateProperty.all(mainTextColor)
                                    : MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Color(0xff5B5B5B)))),
                            onPressed: () {},
                            child: Text("Panier surprise",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor)))),
                      ),
                    ],
                  ),
                ),

                Visibility(
                    visible: widget.target_food.foodType.toString() != "1",
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text("Type Panier surprise",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(

                              children: getMysteryColumn(draftAndPublicEditControler.surpriseTypeArray)
                              ,
                            ),
                          ),
                        ]
                    )

                ),

                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Pick up Date",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                ),
                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: HelperFunction.getTodayTomorrowOrDate(widget.target_food.pickupDateTo.toString()) == "Aujourd'hui"
                                    ? MaterialStateProperty.all(mainTextColor)
                                    : MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Color(0xff5B5B5B)))),
                            onPressed: () {
                            },
                            child: Text("Aujourd'hui",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor)))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: HelperFunction.getTodayTomorrowOrDate(widget.target_food.pickupDateTo.toString())  == "Demain"
                                    ? MaterialStateProperty.all(mainTextColor)
                                    : MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Color(0xff5B5B5B)))),
                            onPressed: () {},
                            child: Text("Demain",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor)))),
                      ),
                    ],
                  ),
                ),

                Visibility(
                  visible: HelperFunction.getTodayTomorrowOrDate(widget.target_food.pickupDateTo.toString()) != "Aujourd'hui" && HelperFunction.getTodayTomorrowOrDate(widget.target_food.pickupDateTo.toString()) != "Demain",
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5 - 16 - 5,
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(mainTextColor),
                                      side: MaterialStatePropertyAll(
                                          BorderSide(color: Color(0xff5B5B5B)))),
                                  onPressed: () {
                                  },
                                  child: Text("${HelperFunction.getTodayTomorrowOrDateWithYear(widget.target_food.pickupDateFrom.toString())}",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor)))),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]
                )
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Pick up Horaire",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Color(0xff5B5B5B)))),
                            onPressed: () {},
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "image/clock (1).svg",
                                  height: 20,
                                  width: 20,
                                  color: whiteTextColor,
                                ),
                                SizedBox(width: 10),
                                Text("${widget.target_food.pickupTimeFrom!}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor))),
                              ],
                            )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Color(0xff5B5B5B)))),
                            onPressed: () {},
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "image/clock (1).svg",
                                  height: 20,
                                  width: 20,
                                  color: whiteTextColor,
                                ),
                                SizedBox(width: 10),
                                Text("${widget.target_food.pickupTimeTo!}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor))),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Boutique",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      children: getStoreColumn(draftAndPublicEditControler.boutiqueArray)

                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Allergènes",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                   children:getAllergyColumn()

                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Catégories",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      children: getCatColumn(draftAndPublicEditControler.foodCatArray)
                  ),
                ),
                SizedBox(height: 15,),

              ],
            ),
          ),
        )


    );
  }


  getStoreColumn(RxList<Boutique> boutiqueArray ){
    List<Widget> column = [];
    int store_count  = 0;


    List<Widget> row = [];

    boutiqueArray.forEach((Boutique boutique) {
      store_count++;

      row.add(
          Container(
            width : MediaQuery.of(context).size.width/2 - (16+3),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: widget.target_food.boutiqueId == boutique.id
                        ? MaterialStateProperty.all(mainTextColor)
                        : MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                },
                child: Text(boutique.boutiqueName!,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor)))),
          )
      );

      if(store_count%2 == 0){
        Widget myRow = Row(children: row);
        column.add(myRow);
        row = [];
      }
      else{
        row.add(
          SizedBox(width: 6,),
        );
      }


    });

    if(row.length > 0 ){
      Widget myRow = Row(children: row);
      column.add(myRow);
      row = [];
    }

    return column;


  }

  getMysteryColumn(RxList<Mystery> surpriseTypeArray ){
    List<Widget> column = [];
    int mystery_count  = 0;


    List<Widget> row = [];

    surpriseTypeArray.forEach((Mystery mystery) {
      mystery_count++;

      row.add(
          Container(
            width : MediaQuery.of(context).size.width/2 - (16+3),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: widget.target_food.mysteryTypeId== mystery.id
                        ? MaterialStateProperty.all(mainTextColor)
                        : MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                },
                child: Text(mystery.mysteryName!,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor)))),
          )
      );

      if(mystery_count%2 == 0){
        Widget myRow = Row(children: row);
        column.add(myRow);
        row = [];
      }
      else{
        row.add(
          SizedBox(width: 6,),
        );
      }


    });

    if(row.length > 0 ){
      Widget myRow = Row(children: row);
      column.add(myRow);
      row = [];
    }

    return column;


  }

  getAllergyColumn( ){

    List<Allergy> allergyArray = [];
    String? selectedAllergyIds = widget.target_food.allergyIds;
    // String value = "6,5";
    List<String>? mySelectedAllergyIds = selectedAllergyIds?.split(",");

    mySelectedAllergyIds?.forEach((String id) {
      draftAndPublicEditControler.allergyArray.value.forEach((Allergy allergy){
        if(allergy.id == int.parse(id)){
          allergyArray.add(allergy);
          return;

        }
      });
    });

    List<Widget> column = [];
    int allergy_count  = 0;


    List<Widget> row = [];



    allergyArray.forEach((Allergy allergy)
    {
      allergy_count++;

      row.add(


          Container(
            width : MediaQuery.of(context).size.width/3 - (16+3),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainTextColor),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                },
                child: Text(allergy.name!,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor)))),
          )
      );

      if(allergy_count%3 == 0){
        Widget myRow = Row(children: row);
        column.add(myRow);
        row = [];
      }
      else{
        row.add(
          SizedBox(width: 6,),
        );
      }


    });

    if(row.length > 0 ){
      Widget myRow = Row(children: row);
      column.add(myRow);
      row = [];
    }

    return column;


  }

  getCatColumn(RxList<FoodCat.Data> foodCatArray ){


    List<FoodCat.Data> foodCatArray = [];
    String? selectedCatIds = widget.target_food.foodCatId;
    // String value = "6,5";
    List<String>? mySelectedCatIds = selectedCatIds?.split(",");
    print(mySelectedCatIds);

    mySelectedCatIds?.forEach((String id) {
      draftAndPublicEditControler.foodCatArray.value.forEach((FoodCat.Data cat){
        if(cat.id == int.parse(id)){
          foodCatArray.add(cat);
          return;

        }
      });
    });

    List<Widget> column = [];
    int allergy_count  = 0;


    List<Widget> row = [];



    foodCatArray.forEach((FoodCat.Data cat)
    {
      allergy_count++;

      row.add(


          Container(
            width : MediaQuery.of(context).size.width/3 - (16+3),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainTextColor),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                },
                child: Text(cat.name!,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor)))),
          )
      );

      if(allergy_count%3 == 0){
        Widget myRow = Row(children: row);
        column.add(myRow);
        row = [];
      }
      else{
        row.add(
          SizedBox(width: 6,),
        );
      }


    });

    if(row.length > 0 ){
      Widget myRow = Row(children: row);
      column.add(myRow);
      row = [];
    }

    return column;



  }


//
  //
  //
  // ImagePicarBottomSheet(int imageFor) {
  //   showModalBottomSheet(
  //       context: context,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topRight: Radius.circular(21), topLeft: Radius.circular(21))),
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: 300,
  //           decoration: BoxDecoration(
  //               color: bottomShetColor,
  //               borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(20),
  //                   topLeft: Radius.circular(20))),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 height:250,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15),
  //                     color: whiteTextColor
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text("Télécharger une photo",
  //                         style: GoogleFonts.openSans(
  //                             textStyle: TextStyle(
  //                                 fontSize: 15,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: bottomShetColor.withOpacity(01)))),
  //                     SizedBox(height: 10,),
  //                     InkWell(
  //                       onTap: (){
  //                         widget.controller_foodUploadController.takePhoto(ImageSource.camera, imageFor);
  //                         Navigator.pop(context);
  //
  //                       },
  //                       child: ListTile(
  //                         title:Text("Caméra",
  //                             style: GoogleFonts.openSans(
  //                                 textStyle: TextStyle(
  //                                     fontSize: 15,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: bottomShetColor.withOpacity(01)))) ,
  //                         trailing: Icon(Icons.camera_alt,size: 32,),
  //                       ),
  //                     ),
  //                     Divider(thickness: 2,),
  //                     InkWell(
  //                       onTap: (){
  //                         widget.controller_foodUploadController.takePhoto(ImageSource.gallery, imageFor);
  //                         Navigator.pop(context);
  //                       },
  //                       child: ListTile(
  //                           title:Text("Galerie",
  //                               style: GoogleFonts.openSans(
  //                                   textStyle: TextStyle(
  //                                       fontSize: 15,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: bottomShetColor.withOpacity(01)))) ,
  //                           trailing: SvgPicture.asset("image/image.svg",height: 21,width: 21,)
  //                       ),
  //                     ),
  //
  //                   ],
  //                 ),
  //               ),
  //
  //               // Padding(
  //               //   padding: const EdgeInsets.only(left: 5, right: 5),
  //               //   child: InkWell(
  //               //     onTap: () {
  //               //        Navigator.pop(context);
  //               //     },
  //               //     child: Container(
  //               //         height: 55,
  //               //         width:MediaQuery.of(context).size.width,
  //               //         decoration: BoxDecoration(
  //               //             borderRadius: BorderRadius.circular(25),
  //               //             color: whiteTextColor),
  //               //         child: Center(child: Text("Annuler",
  //               //             style: GoogleFonts.openSans(
  //               //                 textStyle: TextStyle(
  //               //                     fontSize: 14,
  //               //                     fontWeight: FontWeight.bold,
  //               //                     color: bottomShetColor))),)
  //               //     ),
  //               //   ),
  //               // )
  //             ],
  //           ),
  //         );
  //       });
  // }


}
