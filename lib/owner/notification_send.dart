import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';
import 'controller/notification_controller.dart';
import 'model/User.dart';
// Other imports...

class NotificationSend extends StatefulWidget {
  const NotificationSend({Key? key}) : super(key: key);

  @override
  State<NotificationSend> createState() => _NotificationSendState();
}

class _NotificationSendState extends State<NotificationSend> {
  final NotificationControllerOwner controller_notification = Get.put(NotificationControllerOwner());

  TextEditingController notificationTitle  = TextEditingController();
  TextEditingController notificationBody = TextEditingController();


  List<int> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    controller_notification.getUsers();

    notificationTitle.text = "";
    notificationBody.text = "";
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return
      Obx(() =>
          Scaffold(
            appBar: AppBar(
              centerTitle: false,
              titleSpacing: 0.0,
              automaticallyImplyLeading: false,
              backgroundColor: bottomShetColor,
              elevation: 1,
              title: Text("Notification Envoyée",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: notificationTitle,
                      decoration: InputDecoration(
                        labelText: 'Titre de la notification',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // this sets border color when the field is focused
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.3), // this sets border color when the field is not focused
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainTextColor, // this sets border color when the field is focused
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3), // this sets label color when the field is focused
                        ),
                      ),
                      style: TextStyle(color: mainTextColor),
                    ),
                  ),
                  SizedBox(height: 15,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: notificationBody,
                      decoration: InputDecoration(
                        labelText: 'Corps de la notification',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // this sets border color when the field is focused
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.3), // this sets border color when the field is not focused
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainTextColor, // this sets border color when the field is focused
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3), // this sets label color when the field is focused
                        ),
                      ),
                      style: TextStyle(color: mainTextColor),
                    ),
                  ),

                  SizedBox(height: 15,),
                  SizedBox(height: 15,),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Type de notification envoyée",
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
                                  backgroundColor: controller_notification.isAll.value == true
                                      ? MaterialStateProperty.all(mainTextColor)
                                      : MaterialStateProperty.all(Colors.transparent),
                                  side: MaterialStatePropertyAll(
                                      BorderSide(
                                          color: Color(0xff5B5B5B)
                                      )
                                  )
                              ),
                              onPressed: (){
                                controller_notification.isAll.value = true;
                              },
                              child: Text("Tout",
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
                                  backgroundColor: controller_notification.isAll.value == false
                                      ? MaterialStateProperty.all(mainTextColor)
                                      : MaterialStateProperty.all(Colors.transparent),
                                  side: MaterialStatePropertyAll(
                                      BorderSide(
                                          color: Color(0xff5B5B5B)
                                      )
                                  )
                              ),
                              onPressed: (){
                                controller_notification.isAll.value = false;

                              },
                              child: Text("Spécifique",
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
                     visible: controller_notification.isAll.value == false,
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child:   MultiSelectDialogField(
                              items: controller_notification.items,
                              searchable: true,
                              selectedColor: mainTextColor,
                              decoration: BoxDecoration(
                                color: mainTextColor.withOpacity(0.1),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: mainTextColor,
                                  width: 2,
                                ),
                              ),
                              buttonIcon: Icon(
                                Icons.person,
                                color: mainTextColor,
                              ),
                              buttonText: Text(
                                "Utilisateur",
                                style: TextStyle(
                                  color: mainTextColor,
                                  fontSize: 16,
                                ),
                              ),
                              onConfirm: (results) {

                                results.forEach((User user) {
                                  _selectedItems.add(user.id!);
                                });
                                //_selectedAnimals = results;
                              },
                            ),

                          ),
                        ],
                      )),


                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Container(
                      width: double.infinity, // This will make the button full width
                      child: ElevatedButton(
                        child: Text('Envoyer'),
                        onPressed: () {
                          // Your code to handle the selected items goes here.
                          // For example, you might print the selected items to the console:

                          if(notificationTitle.text.length == 0){
                            Fluttertoast.showToast(
                                msg: "Vous devez remplir le titre de la notification",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 14.0
                            );
                          }
                          else if(notificationBody.text.length == 0){
                            Fluttertoast.showToast(
                                msg: "Vous devez avoir besoin de remplir le corps de la notification",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 14.0
                            );
                          }
                          else if(controller_notification.isAll == false && _selectedItems.length == 0){
                            Fluttertoast.showToast(
                                msg: "Vous avez sélectionné un utilisateur spécifique mais pas sélectionné d'utilisateur.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 14.0
                            );
                          }
                          else{
                            String role = "";
                            if(controller_notification.isAll == true){
                              role = 'all';
                            }
                            else{
                              role = 'specific';
                            }

                            controller_notification.sendNotification(notificationTitle.text, notificationBody.text, role, _selectedItems);


                          }
                          // print(notificationTitle.text);
                          // print(notificationBody.text);
                          // print("=======");
                          //
                          //
                          //
                          //
                          // print('Selected items: $_selectedItems');
                        },
                      ),
                    ),
                  )

                ],
              ),
            ),
            backgroundColor: bottomShetColor,
          ),

      );
  }
}
