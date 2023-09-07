import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laspigadoro/const/const.dart';

import '../controllar/profile_client_controller.dart';
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  var switchValue=false;
  final ProfileClientController  clientNotificationController = Get.put(ProfileClientController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clientNotificationController.getClientProfile();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(() =>

    ((){
      if(clientNotificationController.showLoader.value  == true){
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
            leading:  Padding(
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


          ),
          backgroundColor: bottomShetColor,
          body: Column(
            children: [

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Push Notifications",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: whiteTextColor))),

                    // CupertinoSwitch(
                    //   value: switchValue,
                    //   thumbColor: mainTextColor,
                    //   activeColor: Color(0xff505050),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       switchValue = value;
                    //     });
                    //   },
                    // ),
                    CupertinoSwitch(
                      value: clientNotificationController.push_notification.value,
                      thumbColor: mainTextColor,
                      activeColor: const Color(0xff505050),
                      onChanged: (value1) {

                        //clientNotificationController.showLoader.value = true;



                        clientNotificationController.push_notification.value = value1;
                        clientNotificationController.profile.value?.pushNotification = clientNotificationController.push_notification.value ==true?1:0;

                        clientNotificationController.postClientProfile(false,false);
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
