import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:laspigadoro/owner/Public_Draft_Edit_Delete/preview_edit.dart';
import 'package:laspigadoro/owner/Public_Draft_Edit_Delete/titre_de_loffre_page_for_edit.dart';
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
import '../model/Food.dart';
import '../../const/const.dart';
import 'package:sizer/sizer.dart';

import '../controller/Public_Draft_Edit_Delete/food_edit_controller.dart';
import '../controller/food_upload_controller.dart';
import 'package:intl/intl.dart';

import '../../helper/helper_function.dart';
import '../model/Allergy.dart';
import '../model/Boutique.dart';
import '../model/Mystery.dart';
import 'food_description_for_edit.dart';
import 'food_price_for_edit.dart';
import 'food_stock_for_edit.dart';
import '../model/FoodCat.dart' as FoodCat;




class EditFoodOffer extends StatefulWidget {
  FoodWithCreatedAtUpdatedAtInDateTimeObj target_food;
  final FoodEditController controller_foodEditController;

  EditFoodOffer({Key? key, required this.target_food, required this.controller_foodEditController}) : super(key: key);

  @override
  State<EditFoodOffer> createState() => _EditFoodOfferState();
}

class _EditFoodOfferState extends State<EditFoodOffer> {




  @override
  void initState() {
    super.initState();

    _initStateAsync();

  }

  Future<void> _initStateAsync() async {
    widget.controller_foodEditController.resetAllValue();

    await _getBoutiqueAsync();

    await _getAllergyAsync();

    await _getSurpriseTypeAsync();

    await _getFoodCatAsync();

    widget.controller_foodEditController.setAllValue(widget.target_food);
  }

  Future<void> _getBoutiqueAsync() async {
    await widget.controller_foodEditController.getBoutique();
  }

  Future<void> _getAllergyAsync() async {
    await widget.controller_foodEditController.getAllergy();
  }

  Future<void> _getSurpriseTypeAsync() async {
    await widget.controller_foodEditController.getSurpriseType();
  }

  Future<void> _getFoodCatAsync() async {
    await widget.controller_foodEditController.getFoodCat();
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Obx(
            () => Scaffold(
          appBar: widget.controller_foodEditController.showLoader.value == false ? AppBar(
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


                      if(widget.controller_foodEditController.foodName.value == ""){
                        Fluttertoast.showToast(
                          msg: "Veuillez renseigner le titre de votre offre.",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );

                        allConditionsSatisfied = false;

                      }

                      if(widget.controller_foodEditController.foodDescription.value == ""){
                        Fluttertoast.showToast(
                          msg: "Veuillez ajouter une description cocnernant votre offre",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );

                        allConditionsSatisfied = false;
                      }


                      // if(widget.controller_foodEditController.foodStock.value == "0"){
                      //   Fluttertoast.showToast(
                      //     msg: "Vous devez définir Stock.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     fontSize: 14.0,
                      //     gravity: ToastGravity.BOTTOM,
                      //     backgroundColor: Colors.red,
                      //   );
                      //
                      //   allConditionsSatisfied = false;
                      // }

                      if(widget.controller_foodEditController.foodPricePrix.value == ""){
                        Fluttertoast.showToast(
                          msg: "Veuillez renseigner le type d'offre",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );

                        allConditionsSatisfied = false;

                      }

                      if(widget.controller_foodEditController.offerType.value == "0"){
                        Fluttertoast.showToast(
                          msg: "Vous devez définir Type d'offre.",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );


                        allConditionsSatisfied = false;

                      }

                      if(widget.controller_foodEditController.offerType.value != "0" && widget.controller_foodEditController.offerType.value == "2" && widget.controller_foodEditController.mysteryId.value == 0){
                        Fluttertoast.showToast(
                          msg: "Vous devez définir Type Panier surprise.",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );

                        allConditionsSatisfied = false;

                      }



                      if(widget.controller_foodEditController.pickUpDate.value == 0){
                        Fluttertoast.showToast(
                          msg: "Vous devez définir le ramassage à date.",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );

                        allConditionsSatisfied = false;

                      }

                      if(widget.controller_foodEditController.pickUpTimeFrom.value == null){
                        Fluttertoast.showToast(
                          msg: "Vous devez avoir besoin de régler l'heure de prise en charge.",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );

                        allConditionsSatisfied = false;

                      }

                      if(widget.controller_foodEditController.pickUpTimeTo.value == null){
                        Fluttertoast.showToast(
                          msg: "Vous devez définir l'heure de prise en charge.",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );

                        allConditionsSatisfied = false;

                      }


                      if(widget.controller_foodEditController.storeId.value == 0){
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
                            builder: (_) => PreviewEdit(controller_foodEditController: widget.controller_foodEditController)));
                      }
                    },
                    child: Icon(Icons.done,size: 31,color: whiteTextColor,)),
              )
            ],
        ) : null,
          backgroundColor: bottomShetColor,
          bottomNavigationBar: widget.controller_foodEditController.showLoader.value == false ? Padding(
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
          body: widget.controller_foodEditController.showLoader.value == true
              ? loaderSquare
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (() {
                  if (widget.controller_foodEditController.imageFile.value != null) {
                    return Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Color(0xff606060).withOpacity(0.1),
                        image: DecorationImage(
                          image: FileImage(File(widget.controller_foodEditController.imageFile.value!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else if (widget.controller_foodEditController.networkFoodImage.value != null) {
                    return Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Color(0xff606060).withOpacity(0.1),
                        image: DecorationImage(
                          image: NetworkImage(widget.controller_foodEditController.networkFoodImage.value!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Color(0xff606060).withOpacity(0.1),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "image/image.svg",
                          height: 58,
                          width: 66,
                        ),
                      ),
                    );
                  }
                })(),


                SizedBox(height: 15,),

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

                        (() {
                          if (widget.controller_foodEditController.listImageFile.value != null) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                onTap: () {
                                  ImagePicarBottomSheet(2);
                                },
                                child: Container(
                                  height: 147,
                                  decoration: BoxDecoration(
                                    color: Color(0xff606060).withOpacity(0.1),
                                    image: DecorationImage(
                                      image: FileImage(File(widget.controller_foodEditController.listImageFile.value!.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (widget.controller_foodEditController.networkFoodListImage.value != null &&
                              widget.controller_foodEditController.networkFoodListImage.value != widget.controller_foodEditController.networkFoodImage.value) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                onTap: () {
                                  ImagePicarBottomSheet(2);
                                },
                                child: Container(
                                  height: 147,
                                  decoration: BoxDecoration(
                                    color: Color(0xff606060).withOpacity(0.1),
                                    image: DecorationImage(
                                      image: NetworkImage(widget.controller_foodEditController.networkFoodListImage.value!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
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
                                      height: 147,
                                      decoration: BoxDecoration(
                                        color: Color(0xff606060).withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("image/click.svg", height: 58, width: 66),
                                            Text("Cliquer ici pour télécharger une image",
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.normal,
                                                        fontStyle: FontStyle.italic,
                                                        color: whiteTextColor.withOpacity(0.5))))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        })(),

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


                        (() {
                          if (widget.controller_foodEditController.thumbImageFile.value != null) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                onTap: () {
                                  ImagePicarBottomSheet(3);
                                },
                                child: Container(
                                  height: 140,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xff606060).withOpacity(0.1),
                                    image: DecorationImage(
                                      image: FileImage(File(widget.controller_foodEditController.thumbImageFile.value!.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (widget.controller_foodEditController.networkFoodThumbnailImage.value != null &&
                              widget.controller_foodEditController.networkFoodThumbnailImage.value != widget.controller_foodEditController.networkFoodImage.value) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                onTap: () {
                                  ImagePicarBottomSheet(3);
                                },
                                child: Container(
                                  height: 140,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xff606060).withOpacity(0.1),
                                    image: DecorationImage(
                                      image: NetworkImage(widget.controller_foodEditController.networkFoodThumbnailImage.value!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                onTap: () {
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
                                      height: 140,
                                      width: 35.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xff606060).withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("image/click.svg", height: 58, width: 66),
                                            Text("Cliquer ici pour télécharger une image",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.normal,
                                                        fontStyle: FontStyle.italic,
                                                        color: whiteTextColor.withOpacity(0.5))))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        })(),

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
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>TitreDeLoffrePageForEdit(controller_foodEditController: widget.controller_foodEditController)));
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
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>DescriptionPageForEdit(controller_foodEditController: widget.controller_foodEditController)));
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
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>FoodStockForEdit(controller_foodEditController: widget.controller_foodEditController)));
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
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>FoodPriceForEdit(controller_foodEditController: widget.controller_foodEditController)));
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
                                backgroundColor: widget.controller_foodEditController.offerType.value == "1"
                                    ? MaterialStateProperty.all(mainTextColor)
                                    : MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStatePropertyAll(
                                    BorderSide(
                                        color: Color(0xff5B5B5B)
                                    )
                                )
                            ),
                            onPressed: (){
                              widget.controller_foodEditController.offerType.value = "1";
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
                                backgroundColor: widget.controller_foodEditController.offerType.value == "2"
                                    ? MaterialStateProperty.all(mainTextColor)
                                    : MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStatePropertyAll(
                                    BorderSide(
                                        color: Color(0xff5B5B5B)
                                    )
                                )
                            ),
                            onPressed: (){
                              widget.controller_foodEditController.offerType.value = "2";

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
                    visible: widget.controller_foodEditController.offerType.value != "0" && widget.controller_foodEditController.offerType.value != "1",
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

                              children: getMysteryColumn(widget.controller_foodEditController.surpriseTypeArray)
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
                                backgroundColor: DateTime.
                                parse(widget.controller_foodEditController.pickUpDate.value).isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))
                                    ? MaterialStateProperty.all(mainTextColor)
                                    : MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStatePropertyAll(
                                    BorderSide(
                                        color: Color(0xff5B5B5B)
                                    )
                                )
                            ),
                            onPressed: () {
                              widget.controller_foodEditController.pickUpDate.value = DateTime.now().toString().substring(0, 10);
                            },
                            child: Text("Aujourd'hui",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor)))) ,
                      ),
                      SizedBox(width: 6,),
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:DateTime.parse(widget.controller_foodEditController.pickUpDate.value).isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: 1)))
                                    ? MaterialStateProperty.all(mainTextColor)
                                    : MaterialStateProperty.all(Colors.transparent),
                                side: MaterialStatePropertyAll(
                                    BorderSide(
                                        color: Color(0xff5B5B5B)
                                    )
                                )
                            ),
                            onPressed: (){
                              widget.controller_foodEditController.pickUpDate.value = DateTime.now().add(Duration(days: 1)).toString().substring(0, 10);

                            },
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
                    visible: HelperFunction.getTodayTomorrowOrDate(widget.controller_foodEditController.pickUpDate.value.toString()) != "Aujourd'hui" && HelperFunction.getTodayTomorrowOrDate(widget.controller_foodEditController.pickUpDate.value.toString()) != "Demain",
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
                                      side: MaterialStateProperty.all(BorderSide(color: Color(0xff5B5B5B))),
                                    ),
                                    onPressed: () async {
                                      DateTime now = DateTime.now();
                                      DateTime dayAfterTomorrow = now.add(Duration(days: 2));
                                      DateTime? selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: dayAfterTomorrow,
                                        firstDate: dayAfterTomorrow,
                                        lastDate: DateTime(now.year + 5),
                                        builder: (BuildContext context, Widget? child) {
                                          return Theme(
                                            data: ThemeData.light().copyWith(
                                              primaryColor: mainTextColor,
                                              accentColor: mainTextColor,
                                              colorScheme: ColorScheme.light(primary: mainTextColor),
                                              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (selectedDate != null) {
                                        widget.controller_foodEditController.pickUpDate.value = selectedDate.toString().split(" ")[0];
                                        // Update your state or data with the selected date
                                      }
                                    },
                                    child: Text(
                                      "${HelperFunction.getTodayTomorrowOrDateWithYear(widget.target_food.pickupDateFrom.toString())}",
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
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
                              widget.controller_foodEditController.pickUpTimeFrom.value = HelperFunction.timeOfDayToString(_selectedTime);

                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: _selectedTime,
                                helpText: "Sélectionner l'heure",
                                cancelText: "Annuler",
                                confirmText: "D'accord",

                              );
                              if (picked != null && picked != _selectedTime) {
                                _selectedTime = picked;
                                widget.controller_foodEditController.pickUpTimeFrom.value = HelperFunction.timeOfDayToString(_selectedTime);
                              }


                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("image/clock (1).svg",height: 20,width: 20,color: whiteTextColor,),
                                SizedBox(width: 10),
                                Text(widget.controller_foodEditController.pickUpTimeFrom.value == null ? "A partir de" : "${widget.controller_foodEditController.pickUpTimeFrom.value}",
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
                              widget.controller_foodEditController.pickUpTimeTo.value = HelperFunction.timeOfDayToString(_selectedTime);

                              if(widget.controller_foodEditController.pickUpTimeFrom.value == null){
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
                                  widget.controller_foodEditController.pickUpTimeTo.value = HelperFunction.timeOfDayToString(_selectedTime);

                                }
                              }

                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("image/clock (1).svg",height: 20,width: 20,color: whiteTextColor,),
                                SizedBox(width: 10),
                                Text(widget.controller_foodEditController.pickUpTimeTo.value == null ? "Jusqu'à" : "${widget.controller_foodEditController.pickUpTimeTo.value}",
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
                      children: getStoreColumn(widget.controller_foodEditController.boutiqueArray)
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //
                //     children: [
                //       TextButton(
                //           style: ButtonStyle(
                //               side: MaterialStatePropertyAll(
                //                   BorderSide(
                //                       color: Color(0xff5B5B5B)
                //                   )
                //               )
                //           ),
                //           onPressed: (){
                //
                //           },
                //           child: Text("Rueil-Malmaison",
                //               style: GoogleFonts.openSans(
                //                   textStyle: TextStyle(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.bold,
                //                       color: whiteTextColor)))),
                //       SizedBox(width: 6,),
                //       TextButton(
                //           style: ButtonStyle(
                //               side: MaterialStatePropertyAll(
                //                   BorderSide(
                //                       color: Color(0xff5B5B5B)
                //                   )
                //               )
                //           ),
                //           onPressed: (){
                //
                //           },
                //           child: Text("Le Vesinet",
                //               style: GoogleFonts.openSans(
                //                   textStyle: TextStyle(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.bold,
                //                       color: whiteTextColor)))),
                //       SizedBox(width: 6,),
                //       TextButton(
                //           style: ButtonStyle(
                //               side: MaterialStatePropertyAll(
                //                   BorderSide(
                //                       color: Color(0xff5B5B5B)
                //                   )
                //               )
                //           ),
                //           onPressed: (){
                //
                //           },
                //           child: Text("Le Vesinet",
                //               style: GoogleFonts.openSans(
                //                   textStyle: TextStyle(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.bold,
                //                       color: whiteTextColor)))),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChipsChoice<Allergy>.multiple(
                          padding: EdgeInsets.all(0),
                          value: widget.controller_foodEditController.tags.value,
                          onChanged: (val) {
                            widget.controller_foodEditController.tags.value =val;
                            print(widget.controller_foodEditController.tags.value);

                          },
                          choiceItems: C2Choice.listFrom<Allergy, Allergy>(
                            source: widget.controller_foodEditController.allergyArray.value,
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

                //food cat
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
                          value: widget.controller_foodEditController.catTags.value,
                          onChanged: (val) {
                            widget.controller_foodEditController.catTags.value =val;
                            print(widget.controller_foodEditController.catTags.value);

                          },
                          choiceItems: C2Choice.listFrom<FoodCat.Data, FoodCat.Data>(
                            source: widget.controller_foodEditController.foodCatArray.value,
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
                          widget.controller_foodEditController.takePhoto(ImageSource.camera, imageFor);
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
                          widget.controller_foodEditController.takePhoto(ImageSource.gallery, imageFor);
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
                    backgroundColor: widget.controller_foodEditController.storeId.value == boutique.id
                        ? MaterialStateProperty.all(mainTextColor)
                        : MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                  widget.controller_foodEditController.storeId.value = boutique.id!;
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
                    backgroundColor: widget.controller_foodEditController.mysteryId.value == mystery.id
                        ? MaterialStateProperty.all(mainTextColor)
                        : MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                  widget.controller_foodEditController.mysteryId.value = mystery.id!;
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



}
