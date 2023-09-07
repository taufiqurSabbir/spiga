import 'package:laspigadoro/owner/stock_greater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/owner/publier_une_offre_deatails_page_56.dart';
import 'package:sizer/sizer.dart';

import '../const/const.dart';
import 'controller/food_upload_controller.dart';

class Stock_55 extends StatefulWidget {
  final FoodUploadControllerOwner controller_foodUploadController;

  Stock_55({Key? key, required this.controller_foodUploadController}) : super(key: key);

  @override
  State<Stock_55> createState() => _Stock_55State();
}

class _Stock_55State extends State<Stock_55> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(() =>
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: bottomShetColor,
            elevation: 1,
            title: Text("Stock",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: whiteTextColor))),
            leading:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: mainTextColorwithOpachity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5,),
                        Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: whiteTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                    onTap: () {

                      Navigator.pop(context);

                    },
                    child: Icon(Icons.done,size: 31,color: whiteTextColor,)),
              )
            ],


          ),
          backgroundColor: bottomShetColor,
          body: Padding(
            padding:  EdgeInsets.fromLTRB(18, 20, 18, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "1";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "1" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("1", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "2";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "2" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("2", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "3";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "3" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("3", style: TextStyle(color: Colors.white))),

                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "4";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "4" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("4", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "5";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "5" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("5", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "6";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "6" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("6", style: TextStyle(color: Colors.white))),

                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "7";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "7" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("7", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "8";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "8" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("8", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "9";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "9" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("9", style: TextStyle(color: Colors.white))),

                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "10";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "10" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("10", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "11";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "11" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("11", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "12";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "12" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("12", style: TextStyle(color: Colors.white))),

                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "13";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "13" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("13", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "14";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "14" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("14", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "15";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "15" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("15", style: TextStyle(color: Colors.white))),

                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "16";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "16" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("16", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "17";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "17" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("17", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "18";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "18" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("18", style: TextStyle(color: Colors.white))),

                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "19";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "19" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("19", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "20";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "20" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("20", style: TextStyle(color: Colors.white))),

                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "21";
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: widget.controller_foodUploadController.foodStock.value != "21" ? Color(0xff606060).withOpacity(0.1) : mainTextColor
                          ),
                          child: Center(child: Text("21", style: TextStyle(color: Colors.white))),

                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: (){
                          widget.controller_foodUploadController.foodStock.value = "0";

                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (_) => StockGreaterThan21(controller_foodUploadController: widget.controller_foodUploadController)));
                        },
                        child: Container(
                          height: 38,
                          width: 27.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child: Center(child: Text("+", style: TextStyle(color: Colors.white))),

                        )
                    ),
                  ],
                ),

              ],),
          ),
        )

    );


  }
}
