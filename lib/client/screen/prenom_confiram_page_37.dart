import 'dart:async';

import 'package:laspigadoro/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controllar/profile_client_controller.dart';
class PrenomConfiramPage extends StatefulWidget {
  final ProfileClientController clientController;
   PrenomConfiramPage({Key? key, required this.clientController}) : super(key: key);

  @override
  State<PrenomConfiramPage> createState() => _PrenomConfiramPageState();
}

class _PrenomConfiramPageState extends State<PrenomConfiramPage> {
  TextEditingController crossClintControllar=TextEditingController();
  final ProfileClientController clientController = Get.put(ProfileClientController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.clientController.profile.value?.name != null) {
      crossClintControllar.text = widget.clientController.profile.value!.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    // return Obx(() =>
    //
    // ((){
    //   if(controller_profilePage.showLoader.value  == true){
    //     return Expanded(
    //       child: loaderSquare,
    //     );
    //   }
    //   else{

    var name = widget.clientController.profile.value?.name;

    return Obx(() =>

    ((){
      if(clientController.showLoader.value  == true){
        return loaderSquare;
      }
      else{

        return  Scaffold(
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

                      if(crossClintControllar.text.isEmpty){
                        Fluttertoast.showToast(
                          msg: 'Vous devez entrer votre nom.',
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 14.0,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                        );
                      }
                      else{
                        if(widget.clientController.profile.value?.name  != crossClintControllar.text){
                          widget.clientController.profile.value?.name  = crossClintControllar.text;

                          widget.clientController.postClientProfile(true);

                        }
                        else{

                          Fluttertoast.showToast(
                            msg: 'et ole muuttanut mitään',
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 14.0,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                          );

                        }
                      }





                    },
                    child: Icon(Icons.done, size: 31, color: whiteTextColor,)),
              )
            ],
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
          backgroundColor: bottomShetColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text("Prénom",
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
                      controller: crossClintControllar,

                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8.0, top: 9.8),
                        hintText: "  ${widget.clientController.profile.value
                            ?.name}",
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
                            backgroundColor: mainTextColorwithOpachity
                                .withOpacity(0.4),
                            child: Center(
                                child: InkWell(
                                  onTap: () {
                                    crossClintControllar.clear();
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

// }())




  }

