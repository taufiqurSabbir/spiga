import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/owner/description_54.dart';
import 'package:laspigadoro/owner/euro_58.dart';
import 'package:laspigadoro/owner/publier_une_offre_deatails_page_56.dart';
import 'package:laspigadoro/owner/stock_55.dart';
import 'package:laspigadoro/owner/titre_de_loffre_page_53.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../const/const.dart';
import 'package:sizer/sizer.dart';

import 'controller/food_upload_controller.dart';
import 'package:intl/intl.dart';

import '../helper/helper_function.dart';
import 'model/Allergy.dart';
import 'model/Boutique.dart';
import 'model/Mystery.dart';

import 'model/FoodCat.dart' as FoodCat;






class PublierUneOffrePage extends StatefulWidget {
  const PublierUneOffrePage({Key? key}) : super(key: key);

  @override
  State<PublierUneOffrePage> createState() => _PublierUneOffrePageState();
}

class _PublierUneOffrePageState extends State<PublierUneOffrePage> {


  final FoodUploadControllerOwner controller_foodUploadController = Get.put(FoodUploadControllerOwner());


  @override
  void initState() {
    super.initState();

    if(controller_foodUploadController.boutiqueArray.value.length == 0) {
      controller_foodUploadController.getBoutique();
    }

    if(controller_foodUploadController.allergyArray.value.length == 0) {
      controller_foodUploadController.getAllergy();
    }

    if(controller_foodUploadController.surpriseTypeArray.value.length == 0) {
      controller_foodUploadController.getSurpriseType();
    }

    if(controller_foodUploadController.foodCatArray.value.length == 0) {
      controller_foodUploadController.getFoodCat();
    }


    controller_foodUploadController.resetAllValue();
  }



  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Obx(
            () => Scaffold(
              appBar: controller_foodUploadController.showLoader.value == false ? AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: bottomShetColor,
                elevation: 1,
                title: Text("Publier une offre",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor))),
                leading:  Padding(
                  padding: EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 13),
                  child: GestureDetector(
                    onTap: () {
                      controller_foodUploadController.resetAllValue();
                      Navigator.pop(context);
                    },
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: (){

                          bool allConditionsSatisfied = true;

                          if(controller_foodUploadController.imageFile.value == null){
                            Fluttertoast.showToast(
                              msg: "Vous devez avoir besoin de définir une grande image.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;

                          }

                          if(controller_foodUploadController.foodName.value == ""){
                            Fluttertoast.showToast(
                              msg: "Veuillez renseigner le titre de votre offre.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;

                          }

                          if(controller_foodUploadController.foodDescription.value == ""){
                            Fluttertoast.showToast(
                              msg: "Veuillez ajouter une description cocnernant votre offre",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;
                          }


                          if(controller_foodUploadController.foodStock.value == "0"){
                            Fluttertoast.showToast(
                              msg: "Veuillez renseigner la Stock de votre offre.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;
                          }

                          if(controller_foodUploadController.foodPricePrix.value == ""){
                            Fluttertoast.showToast(
                              msg: "Veuillez renseigner un prix",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;

                          }

                          if(controller_foodUploadController.offerType.value == "0"){
                            Fluttertoast.showToast(
                              msg: "Vous devez définir Type d'offre.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );


                            allConditionsSatisfied = false;

                          }

                          if(controller_foodUploadController.offerType.value != "0" && controller_foodUploadController.offerType.value == "2" && controller_foodUploadController.mysteryId.value == 0){
                            Fluttertoast.showToast(
                              msg: "Vous devez définir Type Panier surprise.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;

                          }



                          if(controller_foodUploadController.pickUpDate.value == 0){
                            Fluttertoast.showToast(
                              msg: "Vous devez définir le ramassage à date.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;

                          }

                          if(controller_foodUploadController.pickUpTimeFrom.value == null){
                            Fluttertoast.showToast(
                              msg: "Vous devez avoir besoin de régler l'heure de prise en charge.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;

                          }

                          if(controller_foodUploadController.pickUpTimeTo.value == null){
                            Fluttertoast.showToast(
                              msg: "Vous devez définir l'heure de prise en charge.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;

                          }


                          if(controller_foodUploadController.storeId.value == 0){
                            Fluttertoast.showToast(
                              msg: "Veuillez renseigner une boutique",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 14.0,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                            );

                            allConditionsSatisfied = false;

                          }


                          if (allConditionsSatisfied) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (_) => PublierUneOffreDetailsPage(controller_foodUploadController: controller_foodUploadController)));
                          }
                        },
                        child: Icon(Icons.done,size: 31,color: whiteTextColor,)),
                  )
                ],


              ) : null,
              backgroundColor: bottomShetColor,
              bottomNavigationBar: controller_foodUploadController.showLoader.value == false ? Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height:71,
                      width: 390,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white
                      ),

                    ),
                    Positioned(
                      child: Container(
                        height: 105,
                        width: 105,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: bottomShetColor
                        ),
                      ),),
                    Positioned(
                      child: InkWell(
                        onTap: (){

                          ImagePicarBottomSheet(1);
                        },
                        child: Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mainTextColor
                          ),
                          child: Center(child: SvgPicture.asset("image/camera.svg",height: 21,width: 29,)),

                        ),
                      ),)
                  ],
                ),
              ) : null,
              body: controller_foodUploadController.showLoader.value == true
              ? loaderSquare
              : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller_foodUploadController.imageFile.value !=null
                        ? Container(
                        height:250,
                        decoration: BoxDecoration(
                            color: Color(0xff606060).withOpacity(0.1),
                            image: DecorationImage(image: FileImage(File(controller_foodUploadController.imageFile.value!.path)),fit: BoxFit.cover))
                            )
                        : Container(
                      height:250,
                      decoration: BoxDecoration(
                        color: Color(0xff606060).withOpacity(0.1),
                      ),
                      child: Center(child: SvgPicture.asset("image/image.svg",height: 58,width: 66,),),
                    ),


                    SizedBox(height: 15,),

                    //Enzo told to remove. That's why I am removing
                    Visibility(
                        visible: false,
                        child: Column(
                          children: [
                            // Image  for  list
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


                            controller_foodUploadController.listImageFile.value !=null
                                ?  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child :
                                GestureDetector(
                                    onTap: () {
                                      ImagePicarBottomSheet(2);
                                    },
                                    child: Container(
                                        height:147,
                                        decoration: BoxDecoration(
                                            color: Color(0xff606060).withOpacity(0.1),
                                            image: DecorationImage(image: FileImage(File(controller_foodUploadController.listImageFile.value!.path)),fit: BoxFit.cover))
                                    )
                                )
                            )
                                : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    ImagePicarBottomSheet(2);
                                  },
                                  child: DottedBorder(
                                      color: whiteTextColor.withOpacity(0.5),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      padding: EdgeInsets.all(6),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          child: Container(
                                            height:147,
                                            decoration: BoxDecoration(
                                              color: Color(0xff606060).withOpacity(0.1),
                                            ),
                                            child: Center(child:
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset("image/click.svg",height: 58,width: 66,),
                                                  Text("Tap here to upload  image.",
                                                      style: GoogleFonts.openSans(
                                                          textStyle: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.normal,
                                                              fontStyle: FontStyle.italic,
                                                              color: whiteTextColor.withOpacity(0.5))))
                                                ]
                                            )



                                            ),
                                          )
                                      )
                                  ),
                                )
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text("** Cette image apparaîtra sur la carte de la liste des aliments.",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic,
                                          color: whiteTextColor.withOpacity(0.5)))),
                            ),
                            SizedBox(height: 15,),



                            // Image  for  thumbnail
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

                            controller_foodUploadController.thumbImageFile.value !=null
                                ?  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child : GestureDetector(
                                    onTap: (){
                                      ImagePicarBottomSheet(3);
                                    },
                                    child: Container(
                                        height:140,
                                        width: 35.w,
                                        decoration: BoxDecoration(
                                            color: Color(0xff606060).withOpacity(0.1),
                                            image: DecorationImage(image: FileImage(File(controller_foodUploadController.thumbImageFile.value!.path)),fit: BoxFit.cover))
                                    )
                                )




                            )
                                : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: GestureDetector(
                                  onTap: (){
                                    ImagePicarBottomSheet(3);
                                  },
                                  child: DottedBorder(
                                      color: whiteTextColor.withOpacity(0.5),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      padding: EdgeInsets.all(6),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          child: Container(
                                            height:140,
                                            width: 35.w,
                                            decoration: BoxDecoration(
                                              color: Color(0xff606060).withOpacity(0.1),
                                            ),
                                            child: Center(child:
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset("image/click.svg",height: 58,width: 66,),
                                                  Text("Tap here to upload  image.",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.openSans(
                                                          textStyle: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.normal,
                                                              fontStyle: FontStyle.italic,
                                                              color: whiteTextColor.withOpacity(0.5))))
                                                ]
                                            )



                                            ),
                                          )
                                      )
                                  ),
                                )
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text("** Cette image apparaîtra en vignette.",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic,
                                          color: whiteTextColor.withOpacity(0.5)))),
                            ),
                            SizedBox(height: 15,),
                          ],
                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                          height: 47,
                          width: 373,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>TitreDeLoffrePage(controller_foodUploadController: controller_foodUploadController)));
                            },
                            child: ListTile(
                              title:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text("Titre de l'offre",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor))),
                              ),
                              trailing:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                          height: 47,
                          width: 373,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>DescriptionPage(controller_foodUploadController: controller_foodUploadController)));
                            },
                            child: ListTile(
                              title:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text("Description",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor))),
                              ),
                              trailing:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                          height: 47,
                          width: 373,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child:InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>Stock_55(controller_foodUploadController: controller_foodUploadController)));
                            },
                            child: ListTile(
                              title:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text("Stock",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor))),
                              ),
                              trailing:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                          height: 47,
                          width: 373,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child:InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>Euro_58(controller_foodUploadController: controller_foodUploadController)));
                            },
                            child: ListTile(
                              title:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text("Prix",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor))),
                              ),
                              trailing:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Type d'offre",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(

                        children: [
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                   backgroundColor: controller_foodUploadController.offerType.value == "1"
                                       ? MaterialStateProperty.all(mainTextColor)
                                       : MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Color(0xff5B5B5B)
                                        )
                                    )
                                ),
                                onPressed: (){
                                  controller_foodUploadController.offerType.value = "1";
                                },
                                child: Text("Plat",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor)))),
                          ),
                          SizedBox(width: 6,),
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: controller_foodUploadController.offerType.value == "2"
                                        ? MaterialStateProperty.all(mainTextColor)
                                        : MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Color(0xff5B5B5B)
                                        )
                                    )
                                ),
                                onPressed: (){
                                  controller_foodUploadController.offerType.value = "2";

                                },
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
                       visible: controller_foodUploadController.offerType.value != "0" && controller_foodUploadController.offerType.value != "1",
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

                                children: getMysteryColumn(controller_foodUploadController.surpriseTypeArray)
                                ,
                              ),
                            ),
                          ]
                        )

                    ),



                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Pick up Date",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(

                        children: [
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: controller_foodUploadController.pickUpDate.value == 1
                                        ? MaterialStateProperty.all(mainTextColor)
                                        : MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Color(0xff5B5B5B)
                                        )
                                    )
                                ),
                                onPressed: (){
                                  controller_foodUploadController.pickUpDate.value = 1;
                                },
                                child: Text("Aujourd'hui",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor)))),
                          ),
                          SizedBox(width: 6,),
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: controller_foodUploadController.pickUpDate.value == 2
                                        ? MaterialStateProperty.all(mainTextColor)
                                        : MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Color(0xff5B5B5B)
                                        )
                                    )
                                ),
                                onPressed: (){
                                  controller_foodUploadController.pickUpDate.value = 2;

                                },
                                child: Text("Demain",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor)))),
                          ),
                          SizedBox(width: 6,),
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: controller_foodUploadController.pickUpDate.value == 100000
                                        ? MaterialStateProperty.all(mainTextColor)
                                        : MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Color(0xff5B5B5B)
                                        )
                                    )
                                ),
                                onPressed: (){
                                  controller_foodUploadController.pickUpDate.value = 100000;

                                },
                                child: Text("durée de vie",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: whiteTextColor)))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),

                    //Pichup Hour
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Pick up Horaire",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    side: MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Color(0xff5B5B5B)
                                        )
                                    )
                                ),
                                onPressed: () async {
                                  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 15);
                                  controller_foodUploadController.pickUpTimeFrom.value = HelperFunction.timeOfDayToString(_selectedTime);

                                  final TimeOfDay? picked = await showTimePicker(
                                    context: context,
                                    initialTime: _selectedTime,
                                    helpText: "Sélectionner l'heure",
                                    cancelText: "Annuler",
                                    confirmText: "D'accord",

                                  );
                                  if (picked != null && picked != _selectedTime) {
                                      _selectedTime = picked;
                                      controller_foodUploadController.pickUpTimeFrom.value = HelperFunction.timeOfDayToString(_selectedTime);
                                  }


                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset("image/clock (1).svg",height: 20,width: 20,color: whiteTextColor,),
                                    SizedBox(width: 10),
                                    Text(controller_foodUploadController.pickUpTimeFrom.value == null ? "A partir de" : "${controller_foodUploadController.pickUpTimeFrom.value}",
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
                                        BorderSide(
                                            color: Color(0xff5B5B5B)
                                        )
                                    )
                                ),
                                onPressed: () async {
                                  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 15);
                                  controller_foodUploadController.pickUpTimeTo.value = HelperFunction.timeOfDayToString(_selectedTime);

                                  if(controller_foodUploadController.pickUpTimeFrom.value == null){
                                    Fluttertoast.showToast(
                                      msg: "Veuillez d'abord sélectionner l'heure de prise en charge.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 14.0,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                  else{
                                    final TimeOfDay? picked = await showTimePicker(
                                      context: context,
                                      initialTime: _selectedTime,
                                      helpText: "Sélectionner l'heure",
                                      cancelText: "Annuler",
                                      confirmText: "D'accord",

                                    );
                                    if (picked != null && picked != _selectedTime) {
                                        _selectedTime = picked;
                                        controller_foodUploadController.pickUpTimeTo.value = HelperFunction.timeOfDayToString(_selectedTime);

                                    }
                                  }

                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset("image/clock (1).svg",height: 20,width: 20,color: whiteTextColor,),
                                    SizedBox(width: 10),
                                    Text(controller_foodUploadController.pickUpTimeTo.value == null ? "Jusqu'à" : "${controller_foodUploadController.pickUpTimeTo.value}",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: whiteTextColor))),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),


                    //Botique select
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Boutique",
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
                        children: getStoreColumn(controller_foodUploadController.boutiqueArray)
                      ),
                    ),
                    SizedBox(height: 15,),

                    //Allargy select
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Allergènes",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChipsChoice<Allergy>.multiple(
                              padding: EdgeInsets.all(0),
                              value: controller_foodUploadController.tags.value,
                              onChanged: (val) {
                                controller_foodUploadController.tags.value =val;
                                  print(controller_foodUploadController.tags.value);

                              },
                              choiceItems: C2Choice.listFrom<Allergy, Allergy>(
                                source: controller_foodUploadController.allergyArray.value,
                                value: (i, v) => v,
                                label: (i, v) => v.name!,
                              ),
                              choiceStyle: C2ChoiceStyle(
                                  showCheckmark: false,
                                  borderRadius: BorderRadius.circular(7),
                                  borderColor: Color(0xffDFE7D6).withOpacity(0.1),
                                  backgroundColor: bottomShetColor,
                                  color: Colors.white,


                              ),
                              choiceActiveStyle: C2ChoiceStyle(
                                  showCheckmark: false,
                                  borderRadius: BorderRadius.circular(7),
                                  borderColor: Color(0xffDFE7D6).withOpacity(0.1),
                                  backgroundColor:mainTextColor,
                                  color: Colors.white,

                              ),

                              wrapped: true,
                            )
                          ]
                      ),
                    ),

                    //Category select
                    SizedBox(height: 15,),

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChipsChoice<FoodCat.Data>.multiple(
                              padding: EdgeInsets.all(0),
                              value: controller_foodUploadController.catTags.value,
                              onChanged: (val) {
                                controller_foodUploadController.catTags.value =val;
                                print(controller_foodUploadController.catTags.value);

                              },
                              choiceItems: C2Choice.listFrom<FoodCat.Data, FoodCat.Data>(
                                source: controller_foodUploadController.foodCatArray.value,
                                value: (i, v) => v,
                                label: (i, v) => v.name!,
                              ),
                              choiceStyle: C2ChoiceStyle(
                                showCheckmark: false,
                                borderRadius: BorderRadius.circular(7),
                                borderColor: Color(0xffDFE7D6).withOpacity(0.1),
                                backgroundColor: bottomShetColor,
                                color: Colors.white,


                              ),
                              choiceActiveStyle: C2ChoiceStyle(
                                showCheckmark: false,
                                borderRadius: BorderRadius.circular(7),
                                borderColor: Color(0xffDFE7D6).withOpacity(0.1),
                                backgroundColor:mainTextColor,
                                color: Colors.white,

                              ),

                              wrapped: true,
                            )
                          ]
                      ),
                    ),
                    SizedBox(height: 15,),

                  ],),
              ),
            )
    );
  }



  ImagePicarBottomSheet(int imageFor) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(21), topLeft: Radius.circular(21))),
        builder: (BuildContext context) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
                color: bottomShetColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Container(
                 height:250,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(15),
                   color: whiteTextColor
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text("Télécharger une photo",
                         style: GoogleFonts.openSans(
                             textStyle: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.bold,
                                 color: bottomShetColor.withOpacity(01)))),
                     SizedBox(height: 10,),
                     InkWell(
                       onTap: (){
                         controller_foodUploadController.takePhoto(ImageSource.camera, imageFor);
                         Navigator.pop(context);

                       },
                       child: ListTile(
                         title:Text("Caméra",
                             style: GoogleFonts.openSans(
                                 textStyle: TextStyle(
                                     fontSize: 15,
                                     fontWeight: FontWeight.bold,
                                     color: bottomShetColor.withOpacity(01)))) ,
                         trailing: Icon(Icons.camera_alt,size: 32,),
                       ),
                     ),
                     Divider(thickness: 2,),
                     InkWell(
                       onTap: (){
                         controller_foodUploadController.takePhoto(ImageSource.gallery, imageFor);
                         Navigator.pop(context);
                       },
                       child: ListTile(
                         title:Text("Galerie",
                             style: GoogleFonts.openSans(
                                 textStyle: TextStyle(
                                     fontSize: 15,
                                     fontWeight: FontWeight.bold,
                                     color: bottomShetColor.withOpacity(01)))) ,
                         trailing: SvgPicture.asset("image/image.svg",height: 21,width: 21,)
                       ),
                     ),
                     
                   ],
                 ),
               ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 5, right: 5),
                //   child: InkWell(
                //     onTap: () {
                //        Navigator.pop(context);
                //     },
                //     child: Container(
                //         height: 55,
                //         width:MediaQuery.of(context).size.width,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(25),
                //             color: whiteTextColor),
                //         child: Center(child: Text("Annuler",
                //             style: GoogleFonts.openSans(
                //                 textStyle: TextStyle(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.bold,
                //                     color: bottomShetColor))),)
                //     ),
                //   ),
                // )
              ],
            ),
          );
        });
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
                    backgroundColor: controller_foodUploadController.storeId.contains(boutique.id)
                        ? MaterialStateProperty.all(mainTextColor)
                        : MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                  if(controller_foodUploadController.storeId.contains(boutique.id!)){
                    controller_foodUploadController.storeId.remove(boutique.id!);
                  }
                  else{
                    controller_foodUploadController.storeId.add(boutique.id!);
                  }
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
                    backgroundColor: controller_foodUploadController.mysteryId.value == mystery.id
                        ? MaterialStateProperty.all(mainTextColor)
                        : MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                  controller_foodUploadController.mysteryId.value = mystery.id!;
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

  getCatColumn(RxList<FoodCat.Data> catTypeArray){
    List<Widget> column = [];
    int cat_count  = 0;


    List<Widget> row = [];

    catTypeArray.forEach((FoodCat.Data cat) {
      cat_count++;

      row.add(
          Container(
            width : MediaQuery.of(context).size.width/2 - (16+3),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: controller_foodUploadController.foodCatId.value == cat.id
                        ? MaterialStateProperty.all(mainTextColor)
                        : MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                  controller_foodUploadController.foodCatId.value = cat.id!;
                },
                child: Text(cat.name!,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor)))),
          )
      );

      if(cat_count%2 == 0){
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


}
