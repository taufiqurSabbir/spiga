import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/owner/details_page_57.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';

import 'controller/food_upload_controller.dart';
import '../helper/helper_function.dart';
import 'model/Allergy.dart';
import 'model/Boutique.dart';
import 'model/Mystery.dart';
import 'notification_page_50.dart';
import 'model/FoodCat.dart' as FoodCat;




class PublierUneOffreDetailsPage extends StatefulWidget {
  final FoodUploadControllerOwner controller_foodUploadController;

  PublierUneOffreDetailsPage({Key? key, required this.controller_foodUploadController}) : super(key: key);

  @override
  State<PublierUneOffreDetailsPage> createState() =>
      _PublierUneOffreDetailsPageState();
}

class _PublierUneOffreDetailsPageState extends State<PublierUneOffreDetailsPage> {
  // List<String> tags=[];
  // List<String> options=[
  //   "Onef","Gultein","plat","tag","Demain","Le Vesinet"
  //
  // ];


  @override

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    var size = MediaQuery.of(context).size;
    return   Obx(()=>
        Scaffold(
          appBar: widget.controller_foodUploadController.showLoader.value == false ? AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: bottomShetColor,
            elevation: 1,
            title: Text("Publier une offre",
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
          bottomNavigationBar: widget.controller_foodUploadController.showLoader.value == false ? Container(
            height: size.height*0.2,
            width: size.width,
            color: bottomShetColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                GestureDetector(
                    onTap: (){
                      widget.controller_foodUploadController.postFoods();
                    },
                    child: Container(
                        height: 54,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xff209602).withOpacity(1),
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
                          //Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsPage()));
                          widget.controller_foodUploadController.draftFoods();
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
                                "Draft",
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
                          //Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsPage()));

                          widget.controller_foodUploadController.resetAllValue();
                          Navigator.pop(context);

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



          body: widget.controller_foodUploadController.showLoader.value == true
              ? loaderSquare
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // imageFile !=null ? Container(
                //     height:size.height*0.3,
                //     width: size.width,
                //     decoration: BoxDecoration(
                //         color: Color(0xff606060).withOpacity(0.1),
                //         image: DecorationImage(image: FileImage(File(imageFile!.path)),fit: BoxFit.cover))
                // ):

                Stack(
                  children: [
                    widget.controller_foodUploadController.imageFile.value !=null ? Container(
                        height:250,
                        decoration: BoxDecoration(
                            color: Color(0xff606060).withOpacity(0.1),
                            image: DecorationImage(image: FileImage(File(widget.controller_foodUploadController.imageFile.value!.path)),fit: BoxFit.cover))
                    ):Container(
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
                    ),



                    Padding(
                      padding: const EdgeInsets.only(right: 20,top: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
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
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),


                widget.controller_foodUploadController.listImageFile.value !=null ? Column(
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
                                ImagePicarBottomSheet(2);
                              },
                              child: Container(
                                  height:147,
                                  decoration: BoxDecoration(
                                      color: Color(0xff606060).withOpacity(0.1),
                                      image: DecorationImage(image: FileImage(File(widget.controller_foodUploadController.listImageFile.value!.path)),fit: BoxFit.cover))
                              )
                          )
                      ),
                      SizedBox(height: 15,),
                    ],
                  ) : Container(),



                widget.controller_foodUploadController.thumbImageFile.value !=null
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
                                ImagePicarBottomSheet(2);
                              },
                              child: Container(
                                  height:140,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xff606060).withOpacity(0.1),
                                      image: DecorationImage(image: FileImage(File(widget.controller_foodUploadController.thumbImageFile.value!.path)),fit: BoxFit.cover))
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
                      child: Text("${widget.controller_foodUploadController.foodName.value}",
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
                                    Text("${widget.controller_foodUploadController.foodDescription.value}",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: whiteTextColor
                                            )
                                        )

                                    )
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
                        child: Center(child: Text("${widget.controller_foodUploadController.foodStock.value}",
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
                      Text("${HelperFunction.stringToCurrency(widget.controller_foodUploadController.foodPricePrix.value, "€ ")}",
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
                      Text("${HelperFunction.stringToCurrency(widget.controller_foodUploadController.foodDiscountPricePrix.value, "€ ")}",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor,
                                decoration: TextDecoration.lineThrough,

                              )
                          )),
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
                                backgroundColor: widget.controller_foodUploadController.offerType.value == "1"
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
                                backgroundColor: widget.controller_foodUploadController.offerType.value == "2"
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
                    visible: widget.controller_foodUploadController.offerType.value != "0" && widget.controller_foodUploadController.offerType.value != "1",
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

                              children: getMysteryColumn(widget.controller_foodUploadController.surpriseTypeArray)
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
                                backgroundColor: widget.controller_foodUploadController.pickUpDate == 1
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
                                backgroundColor: widget.controller_foodUploadController.pickUpDate == 2
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
                SizedBox(
                  height: 15,
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
                                Text("${widget.controller_foodUploadController.pickUpTimeFrom.value!}",
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
                                Text("${widget.controller_foodUploadController.pickUpTimeTo.value!}",
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
                      children: getStoreColumn(widget.controller_foodUploadController.boutiqueArray)

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
                      children: getAllergyColumn(widget.controller_foodUploadController.tags)

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
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      children: getFoodCatColumn(widget.controller_foodUploadController.catTags)

                  ),
                ),
                SizedBox(
                  height: 10,
                )
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
                    backgroundColor: widget.controller_foodUploadController.storeId.value.contains(boutique.id)
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
                    backgroundColor: widget.controller_foodUploadController.mysteryId.value == mystery.id
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

  getFoodCatColumn(RxList<FoodCat.Data> catTypeArray){
    List<Widget> column = [];
    int cat_count  = 0;


    List<Widget> row = [];

    catTypeArray.forEach((FoodCat.Data cat) {
      cat_count++;

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

      if(cat_count%3 == 0){
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


  getAllergyColumn(RxList<Allergy> allergyArray ){
    List<Widget> column = [];
    int allergy_count  = 0;


    List<Widget> row = [];

    allergyArray.forEach((Allergy allergy) {
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
                          widget.controller_foodUploadController.takePhoto(ImageSource.camera, imageFor);
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
                          widget.controller_foodUploadController.takePhoto(ImageSource.gallery, imageFor);
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


}
