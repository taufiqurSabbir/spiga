import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../const/const.dart';
import '../controllar/profile_client_controller.dart';

class Client_telephone extends StatefulWidget {
  final ProfileClientController clientPhoneController;
  Client_telephone({Key? key, required this.clientPhoneController}) : super(key: key);

  @override
  State<Client_telephone> createState() => _Client_telephoneState();
}

class _Client_telephoneState extends State<Client_telephone> {
  TextEditingController client_numberControllar = TextEditingController();
  ProfileClientController profileClientPhoneController =Get.put(ProfileClientController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.clientPhoneController.profile.value?.phone);
    if(widget.clientPhoneController.profile.value?.phone == "null"){
      client_numberControllar.text = "";
    }
    else if(widget.clientPhoneController.profile.value?.phone != null ) {
      client_numberControllar.text = widget.clientPhoneController.profile.value!.phone!;
    }
    // else{
    //   print("----------------------------");
    //   print(client_numberControllar);
    //   client_numberControllar.text = "";
    // }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return
      Obx(() =>

      ((){
        if(profileClientPhoneController.showLoader.value  == true){
          return loaderSquare;
        }
        else{

          return   Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: bottomShetColor,
              elevation: 1,
              title: Text("Mon Profil",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                      onTap: () {
                        print("Baal ");
                        print(client_numberControllar.text.isEmpty);

                        if(client_numberControllar.text.isEmpty){
                          widget.clientPhoneController.profile.value?.phone = "null";

                          print(widget.clientPhoneController.profile.value?.toJson());
                          widget.clientPhoneController.postClientProfile(true);

                        }
                        else if(widget.clientPhoneController.profile.value?.phone  != client_numberControllar.text){
                          // print("nummmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
                          // print(widget.clientPhoneController.profile.value?.phone);
                          widget.clientPhoneController.profile.value?.phone  = client_numberControllar.text;

                          widget.clientPhoneController.postClientProfile(true);


                        }else{

                          Fluttertoast.showToast(
                            msg: 'et ole muuttanut mitään',
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 14.0,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                          );

                        }

                      },
                      child: Icon(Icons.done, size: 31, color: whiteTextColor,)),
                )
              ],
              leading: Padding(
                padding: EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 13),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: mainTextColorwithOpachity,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text("Téléphone",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 47,
                      width: 95.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: Color(0xffDFE7D6).withOpacity(0.1)),
                          color: Color(0xff606060).withOpacity(0.1)
                      ),
                      child:
                      TextField(
                        cursorColor: mainTextColorwithOpachity,
                        style: TextStyle(color: Colors.white),
                        controller: client_numberControllar,
                        keyboardType: TextInputType.phone,

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 8.0, top: 9.8),

                          // hintText: "  ${widget.clientPhoneController.profile.value
                          //     ?.phone}",




                          hintStyle: TextStyle(
                              fontSize: 20.0, color: greyTextXolor),
                          focusColor: mainTextColorwithOpachity.withOpacity(0.4),
                          focusedBorder: OutlineInputBorder(

                            borderSide: BorderSide(
                                width: 1, color: mainTextColorwithOpachity),
                          ),

                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: mainTextColorwithOpachity.withOpacity(
                                  0.4),
                              child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      client_numberControllar.clear();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                      color: whiteTextColor,
                                    ),
                                  )),
                            ),
                          ),

                        ),
                      ),

                      // ListTile(
                      //
                      //   trailing:Padding(
                      //     padding:  EdgeInsets.only(bottom: 10),
                      //     child: CircleAvatar(
                      //       radius: 12,
                      //       backgroundColor: mainTextColorwithOpachity.withOpacity(0.4),
                      //       child: Center(
                      //           child: Icon(
                      //             Icons.close,
                      //             size: 18,
                      //             color: whiteTextColor,
                      //           )),
                      //     ),
                      //   ),
                      // )
                    ),


                  ],
                ),
              ),
            ),

          );
        }

      }())





      );


  }
}
