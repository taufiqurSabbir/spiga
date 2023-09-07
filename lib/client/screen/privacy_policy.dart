import 'package:laspigadoro/client/controllar/privacy_controller.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/helper/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';




class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final PrivacyController privacyController = Get.put(PrivacyController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    privacyController.getPrivacy();
  }
  @override
  Widget build(BuildContext context) {

    return
      Obx(() =>

      ((){
        if(privacyController.showLoader.value  == true){
          return loaderSquare;
        }
        else{

          return   Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: bottomShetColor,
              elevation: 1,
              title: Text("Politique de confidentialité",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
              leading:  Padding(
                padding: EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 13),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: mainTextColorwithOpachity,
                  child: GestureDetector(
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            //color: Color(0xff606060)
                        ),
                        child: Html(

                          data: HelperFunction.htmlLiWrapSpan(privacyController.privacy.value),
                          style: {

                            "p": Style(
                              color: Colors.white,


                              fontSize: FontSize(18),
                            ),
                            "ol": Style(
                              padding: EdgeInsets.only(left: 0),

                              color: Colors.white,



                              fontSize: FontSize(20),
                            ),
                            "li":Style(
                              textDecorationColor:Color(0xffFFFFFF) ,


                              listStyleType: ListStyleType.NONE,
                              padding: EdgeInsets.only(bottom: 5),

                          //    color: Colors.red,
                              fontSize: FontSize(17)

                            ),
                            "span":Style(

                                color: Colors.white,
                                fontSize: FontSize(16)

                            ),
                            "li span":Style(


                                color: mainTextColor,
                                fontSize: FontSize(17)

                            ),

                          },


                        )
                    ),
                  )
                ],
              ),
            ),
          );
        }

      }())





      );


  }
}




