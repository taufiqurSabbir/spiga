import 'dart:developer';

import 'package:laspigadoro/client/screen/client_telephone.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/screen/prenom_confiram_page_37.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/helper/helper_function.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/auth_controllar.dart';
import '../controllar/profile_client_controller.dart';
import 'lastNameConfiram.dart';
import 'notification_page_41.dart';
class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}
class _PersonalInfoPageState extends State<PersonalInfoPage> {

  TextEditingController prenomControllar=TextEditingController();
  TextEditingController emailControllar=TextEditingController();
  TextEditingController telephoneControllar=TextEditingController();
  TextEditingController notificationsControllar=TextEditingController();
  TextEditingController  privacyPolicyControllar=TextEditingController();
  final ProfileClientController profileClientController = Get.put(ProfileClientController());

  final FirebaseAuthLogOut _firebaseLogout = FirebaseAuthLogOut();

  @override
  void initState() {
    super.initState();

    profileClientController.getClientProfile();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(() =>

    ((){
      if(profileClientController.showLoader.value  == true){
        return Container(
          color: bottomShetColor,
          child: loaderSquare,
        );
      }
      else{

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
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text("Infos personnelles",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>PrenomConfiramPage(
                          clientController: profileClientController,

                        )));

                      },
                      child: Container(
                          height: 47,
                          width: 373,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child:ListTile(
                            leading:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("Prénom",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor))),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("${profileClientController.profile.value?.name}", style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                            trailing:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                            ),
                          )
                      ),
                    ),




                    SizedBox(height: 10,),


                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>LastNameConfirm(
                          clientController: profileClientController,

                        )));
                        log(profileClientController.toString());

                      },
                      child: Container(
                          height: 47,
                          width: 373,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child:ListTile(
                            leading:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("nom de famille",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor))),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("${profileClientController.profile.value?.last_name}", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            trailing:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                            ),
                          )
                      ),
                    ),




                    SizedBox(height: 10,),
                    Container(
                        height: 47,
                        width: 373,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                            color: Color(0xff606060).withOpacity(0.1)
                        ),
                        child:ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text("${HelperFunction.checkEmailHasOrNot(profileClientController.profile.value!.email!)}", style: TextStyle(
                              // color: greyTextXolor,
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          leading:Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: RichText(

                              text: TextSpan( text: 'Email',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor),

                                  ),

                                  children: [
                                    TextSpan(text: "*" , style: TextStyle(color: mainTextColor))
                                  ]),
                            ),
                          ),
                          // subtitle: Center(child: Text("Tareq"), ),
                          // trailing:Padding(
                          //   padding: const EdgeInsets.only(bottom: 8),
                          //   child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                          // ),
                        )
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Client_telephone(
                          clientPhoneController: profileClientController,

                        )));

                      },
                      child: Container(
                          height: 47,
                          width: 373,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child:ListTile(
                            leading:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("Téléphone",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor))),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                " ${profileClientController.profile.value?.phone != "null"
                                    ? profileClientController.profile.value?.phone
                                    : 'Numéro de téléphone non fourni'}",


                                // "${profileClientController.profile.value?.phone ?? 'Numéro de téléphone non fourni'}",


                                style: TextStyle(
                                // color: greyTextXolor,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                              ),),
                            ),
                            trailing:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(height: 50,),
                    Text("Paramètres",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: whiteTextColor))),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsPage()));
                      },
                      child: Container(
                          height: 47,
                          width: 373,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                              color: Color(0xff606060).withOpacity(0.1)
                          ),
                          child:ListTile(
                            title:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("Notifications",
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
                          )
                      ),
                    ),
                    // SizedBox(height: 15,),
                    // InkWell(
                    //   onTap: () async {
                    //     //Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsPage()));
                    //
                    //     Uri  privacyPolicyUrl = Uri.parse('https://laspigadoro.fr/privacy-policy');
                    //
                    //     if (await canLaunchUrl(privacyPolicyUrl)) {
                    //     await launchUrl(privacyPolicyUrl);
                    //     } else {
                    //     throw 'Could not launch $privacyPolicyUrl';
                    //     }
                    //   },
                    //   child: Container(
                    //       height: 47,
                    //       width: 373,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(7),
                    //           border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                    //           color: Color(0xff606060).withOpacity(0.1)
                    //       ),
                    //       child:ListTile(
                    //         title:Padding(
                    //           padding: const EdgeInsets.only(bottom: 8),
                    //           child: Text("Politique de confidentialité",
                    //               style: GoogleFonts.openSans(
                    //                   textStyle: TextStyle(
                    //                       fontSize: 13,
                    //                       fontWeight: FontWeight.bold,
                    //                       color: whiteTextColor))),
                    //         ),
                    //         trailing:Padding(
                    //           padding: const EdgeInsets.only(bottom: 8),
                    //           child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                    //         ),
                    //       )
                    //   ),
                    // ),

                    // Container(
                    //     height: 47,
                    //     width: 373,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(7),
                    //         border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                    //         color: Color(0xff606060).withOpacity(0.1)
                    //     ),
                    //     child:ListTile(
                    //       title:Padding(
                    //         padding: const EdgeInsets.only(bottom: 8),
                    //         child: Text("Politique de confidentialité",
                    //             style: GoogleFonts.openSans(
                    //                 textStyle: TextStyle(
                    //                     fontSize: 13,
                    //                     fontWeight: FontWeight.bold,
                    //                     color: whiteTextColor))),
                    //       ),
                    //       trailing:Padding(
                    //         padding: const EdgeInsets.only(bottom: 8),
                    //         child: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                    //       ),
                    //     )
                    // ),


                    // SizedBox(height: 75,),
                    // RoundedLoadingButton(
                    //   elevation: 0,
                    //   width: 50,
                    //   color: mainTextColor,
                    //   successIcon: Icons.check,
                    //   failedIcon: Icons.close,
                    //   valueColor: Colors.white,
                    //   successColor: Colors.green,
                    //   controller: _firebaseLogout.logout_controller,
                    //   onPressed: () => _firebaseLogout.signOut(context),
                    //   borderRadius: 260,
                    //   child:Container(
                    //     height: 54,
                    //     width: 339,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                    //         borderRadius: BorderRadius.circular(25),
                    //         color:mainTextColor
                    //     ),
                    //     child: Align(
                    //       alignment: Alignment.bottomLeft,
                    //
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 15),
                    //         child: Center(
                    //           child: Text("Déconnexion",
                    //               style: GoogleFonts.openSans(
                    //                   textStyle: TextStyle(
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.bold,
                    //                       color: whiteTextColor))),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

    }())





    );




  }
}
