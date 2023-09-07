import 'dart:async';

import 'package:laspigadoro/owner/publier_une_offre_deatails_page_56.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../const/const.dart';
import 'controller/profile_page_pro_menu_controller.dart';

class Telephone extends StatefulWidget {
  final ProfilePageControllerOwner controller_profilePage;
   Telephone({Key? key, required this.controller_profilePage}) : super(key: key);

  @override
  State<Telephone> createState() => _TelephoneState();
}

class _TelephoneState extends State<Telephone> {

  TextEditingController numberControllar = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.controller_profilePage.profile.value!.phone !=null){
      numberControllar.text =widget.controller_profilePage.profile.value!.phone!;
    }
  }




  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Scaffold(
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
                  if(widget.controller_profilePage.profile.value?.phone  != numberControllar.text){
                    widget.controller_profilePage.profile.value?.phone  = numberControllar.text;

                    widget.controller_profilePage.postProfile(true);
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
                  controller: numberControllar,
                  keyboardType: TextInputType.phone,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8.0, top: 9.8),
                    hintText:

                    // "  ${widget.controller_profilePage.profile.value
                    //     ?.phone}",

                    " ${widget.controller_profilePage.profile.value
                        ?.phone ?? ' Numéro de téléphone non fourni  '}",
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
                                numberControllar.clear();
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
}
