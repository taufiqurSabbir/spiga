import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';

import 'controller/profile_page_pro_menu_controller.dart';


class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool switchValue1=false;
  bool switchValue2=false;

  final ProfilePageControllerOwner controller_profilePage = Get.put(ProfilePageControllerOwner());

  @override
  void initState() {
    super.initState();

    controller_profilePage.getProfile();
  }

//
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(() =>

    ((){
      if(controller_profilePage.showLoader.value  == true){
        return Container(
          color: bottomShetColor,
          child: loaderSquare,
        );
      }
      else{

        return  Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: bottomShetColor,
            elevation: 1,
            title: Text("Notifications",
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
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Commandes réservées",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: whiteTextColor))),
                    // ToggleSwitch(
                    //   minWidth: 25.0,
                    //   minHeight: 22,
                    //   cornerRadius: 20.0,
                    //   activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
                    //   activeFgColor: Colors.white,
                    //   inactiveBgColor: Colors.grey,
                    //   inactiveFgColor: Colors.white,
                    //   initialLabelIndex: 1,
                    //   totalSwitches: 2,
                    //   radiusStyle: true,
                    //   onToggle: (index) {
                    //     print('switched to: $index');
                    //   },
                    // ),
                    CupertinoSwitch(
                      value: controller_profilePage.order_notification.value,
                      thumbColor: mainTextColor,
                      activeColor: const Color(0xff505050),
                      onChanged: (value1) {

                        // controller_profilePage.showLoader.value = true;



                        controller_profilePage.order_notification.value = value1;
                        controller_profilePage.profile.value?.orderNotification = controller_profilePage.order_notification.value ==true?1:0;

                        controller_profilePage.postProfile(false,false);
                        // controller_profilePage.profile.value?.outOfStockNotification= value2 == true?1 : 0 ;
                        // controller_profilePage.postProfile();


                        // switchValue2 = value2;
                        //   if(value2==true){
                        //     controller_profilePage.profile.value?.outOfStockNotification=0;
                        //     controller_profilePage.postProfile();
                        //     print(controller_profilePage.profile.value?.outOfStockNotification);
                        //
                        //
                        //   }else{
                        //     controller_profilePage.profile.value?.outOfStockNotification=1;
                        //     controller_profilePage.postProfile();
                        //   }
                        //

                      },
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Stock épuisé",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: whiteTextColor))),
                    // ToggleSwitch(
                    //   minWidth: 25.0,
                    //   minHeight: 22,
                    //   cornerRadius: 20.0,
                    //   activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
                    //   activeFgColor: Colors.white,
                    //   inactiveBgColor: Colors.grey,
                    //   inactiveFgColor: Colors.white,
                    //   initialLabelIndex: 1,
                    //   totalSwitches: 2,
                    //   radiusStyle: true,
                    //   onToggle: (index) {
                    //     print('switched to: $index');
                    //   },
                    // ),
                    CupertinoSwitch(
                      value: controller_profilePage.out_of_stock_notification.value,
                      thumbColor: mainTextColor,
                      activeColor: const Color(0xff505050),
                      onChanged: (value2) {
                        // controller_profilePage.showLoader.value = true;
                        controller_profilePage.out_of_stock_notification.value = value2;
                        controller_profilePage.profile.value?.outOfStockNotification = controller_profilePage.out_of_stock_notification.value ==true?1:0;

                        controller_profilePage.postProfile(false,false);
                        // controller_profilePage.profile.value?.outOfStockNotification= value2 == true?1 : 0 ;
                        // controller_profilePage.postProfile();


                        // switchValue2 = value2;
                        //   if(value2==true){
                        //     controller_profilePage.profile.value?.outOfStockNotification=0;
                        //     controller_profilePage.postProfile();
                        //     print(controller_profilePage.profile.value?.outOfStockNotification);
                        //
                        //
                        //   }else{
                        //     controller_profilePage.profile.value?.outOfStockNotification=1;
                        //     controller_profilePage.postProfile();
                        //   }
                        //

                      },
                    ),


                  ],
                ),
              )
            ],
          ),

        );
      }

    }())





    );


  }
}
