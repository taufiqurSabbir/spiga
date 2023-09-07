
import 'package:laspigadoro/owner/T%C3%A9l%C3%A9phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/owner/notification_page_50.dart';
import 'package:laspigadoro/owner/profile_49.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../controller/auth_controllar.dart';
import '../login_page/login_page.dart';
import 'controller/profile_page_pro_menu_controller.dart';



class PersonalInfoPageAdmin extends StatefulWidget {
  const PersonalInfoPageAdmin({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPageAdmin> createState() => _PersonalInfoPageState();
}
class _PersonalInfoPageState extends State<PersonalInfoPageAdmin> {

  TextEditingController prenomControllar=TextEditingController();
  TextEditingController emailControllar=TextEditingController();
  TextEditingController telephoneControllar=TextEditingController();
  TextEditingController notificationsControllar=TextEditingController();
  TextEditingController  privacyPolicyControllar=TextEditingController();

  final ProfilePageControllerOwner controller_profilePage = Get.put(ProfilePageControllerOwner());
  final FirebaseAuthLogOut _firebaseLogout = FirebaseAuthLogOut();
  final FirebaseAuthDelete _firebaseDelete = FirebaseAuthDelete();


  @override
  void initState() {
    super.initState();

    controller_profilePage.getProfile();
  }

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


          body: SizerUtil.deviceType == DeviceType.mobile
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 5),
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
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile49(
                          controller_profilePage:controller_profilePage

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
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text("${controller_profilePage.profile.value?.name}", style: TextStyle(
                              color: greyTextXolor,
                            ),),
                          ),
                          leading:Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text("prénom",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          ),
                          //${controller_profilePage.profile.value?.name}
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
                          child: Text("${controller_profilePage.profile.value?.email}", style: TextStyle(
                            color: greyTextXolor,
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

                      )
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>Telephone(
                          controller_profilePage:controller_profilePage

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
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child:


                            Text( " ${controller_profilePage.profile.value
                                ?.phone ?? 'Numéro de téléphone non fourni'}", style: TextStyle(
                              color: greyTextXolor,
                            ),),
                          ),
                          leading:Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text("Téléphone",
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
                  SizedBox(height: 50,),

                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("Paramètres",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: whiteTextColor))),
                  ),


                  // Text("Paramètres",
                  //     style: GoogleFonts.openSans(
                  //         textStyle: TextStyle(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.bold,
                  //             color: whiteTextColor))),
                  SizedBox(height: 15,),
                  InkWell(
                    onTap: (){
                      //    Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsPage()));
                    },
                    child: Container(
                        height: 47,
                        width: 373,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                            color: Color(0xff606060).withOpacity(0.1)
                        ),
                        child:InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationPage()));
                          },
                          child: ListTile(
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
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 15,),



                  SizedBox(height: 75,),

                ],
              ),
            ),
          )
              : Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile49(
                              controller_profilePage:controller_profilePage
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
                              title:Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text("Prénom",
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
                            title:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("Email*",
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
                            title:Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("Téléphone",
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
                          //    Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsPage()));
                        },
                        child: Container(
                            height: 47,
                            width: 373,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                                color: Color(0xff606060).withOpacity(0.1)
                            ),
                            child:InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationPage()));
                              },
                              child: ListTile(
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
                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 15,),



                      SizedBox(height: 75,),

                    ],
                  ),
                ),
              )
          ),




          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Align(
                alignment: Alignment.center,
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Align(
                            alignment: Alignment.center,
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Wrap(
                              children: [
                                Column(
                                  children: [
                                    RoundedLoadingButton(
                                      elevation: 0,
                                      width: 50,
                                      color: mainTextColor,
                                      successIcon: Icons.check,
                                      failedIcon: Icons.close,
                                      valueColor: Colors.white,
                                      successColor: Colors.green,
                                      controller: _firebaseLogout.logout_controller,
                                      onPressed: () => _firebaseLogout.signOut(context),
                                      borderRadius: 260,
                                      child:Container(
                                        height: 54,
                                        width: 339,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                                            borderRadius: BorderRadius.circular(25),
                                            color:mainTextColor
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,

                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Center(
                                              child: Text("Déconnexion",
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: whiteTextColor))),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    // RoundedLoadingButton(
                                    //   elevation: 0,
                                    //   width: 50,
                                    //   color: mainTextColor,
                                    //   successIcon: Icons.check,
                                    //   failedIcon: Icons.close,
                                    //   valueColor: Colors.white,
                                    //   successColor: Colors.green,
                                    //   controller: _firebaseDelete.delete_controller,
                                    //   onPressed: () => _firebaseDelete.deleteAccount(context),
                                    //   borderRadius: 260,
                                    //     child: Container(
                                    //       height: 54,
                                    //       width: 339,
                                    //       decoration: BoxDecoration(
                                    //           border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                                    //           borderRadius: BorderRadius.circular(25),
                                    //           color:Colors.red
                                    //       ),
                                    //       child: Align(
                                    //         alignment: Alignment.bottomLeft,
                                    //
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.only(left: 15),
                                    //           child: Center(
                                    //             child: Text("Supprimer le compte",
                                    //                 style: GoogleFonts.openSans(
                                    //                     textStyle: TextStyle(
                                    //                         fontSize: 14,
                                    //                         fontWeight: FontWeight.bold,
                                    //                         color: whiteTextColor))),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     )
                                    // ),




                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 15),
                                    //   child: Center(
                                    //     child: Text("Déconnexion",
                                    //         style: GoogleFonts.openSans(
                                    //             textStyle: TextStyle(
                                    //                 fontSize: 14,
                                    //                 fontWeight: FontWeight.bold,
                                    //                 color: whiteTextColor))),
                                    //   ),
                                    // ),
                                    // RoundedLoadingButton(
                                    //   elevation: 0,
                                    //   width: 50,
                                    //   color: mainTextColor,
                                    //   successIcon: Icons.check,
                                    //   failedIcon: Icons.close,
                                    //   valueColor: Colors.white,
                                    //   successColor: Colors.green,
                                    //   controller: _authServiceGoogle.continue_with_google_controller,
                                    //   onPressed: () => _authServiceGoogle.googleLogin(context),
                                    //   borderRadius: 260,
                                    //   child: Container(
                                    //     height: 50,
                                    //     width: 263,
                                    //     decoration: BoxDecoration(
                                    //         color:Colors.white,
                                    //         borderRadius: BorderRadius.circular(260)
                                    //     ),
                                    //     child:Row(
                                    //       mainAxisAlignment: MainAxisAlignment.center,
                                    //       children: [
                                    //         SvgPicture.asset("image/search (1).svg",width: 25.09,height: 25.09,),
                                    //         SizedBox(width: 15,),
                                    //         Text("Continuer avec Google",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),

                                    // InkWell(
                                    //   onTap: (){
                                    //     controllar.googlelogin(context);
                                    //   },
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(left: 51,right: 51),
                                    //     child:controllar.loder.value?Center(child: CircularProgressIndicator(),): Container(
                                    //       height: 50,
                                    //       width: MediaQuery.of(context).size.width,
                                    //       decoration: BoxDecoration(
                                    //           color:Colors.white,
                                    //           borderRadius: BorderRadius.circular(260)
                                    //       ),
                                    //       child:Row(
                                    //         mainAxisAlignment: MainAxisAlignment.center,
                                    //         children: [
                                    //           SvgPicture.asset("image/search (1).svg",width: 25.09,height: 25.09,),
                                    //           SizedBox(width: 15,),
                                    //           Text("Continuer avec Google",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    //
                                    // SizedBox(height: 8,),
                                    //
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 0,right: 0),
                                    //   child: Container(
                                    //       height: 50,
                                    //       width: 263,
                                    //       decoration: BoxDecoration(
                                    //           color:Color(0xff44680E),
                                    //           borderRadius: BorderRadius.circular(260)
                                    //       ),
                                    //       child:SignInWithAppleButton(onPressed: () {  },
                                    //         borderRadius: BorderRadius.circular(260),
                                    //
                                    //       )
                                    //   ),
                                    // ),
                                    //
                                    // SizedBox(height: 8,),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 0,right: 0),
                                    //   child: InkWell(
                                    //     onTap: (){
                                    //       Navigator.push(context,MaterialPageRoute(builder: (_)=>EmailLoginPage()));
                                    //     },
                                    //     child: Container(
                                    //       height: 50,
                                    //       width: 263,
                                    //       decoration: BoxDecoration(
                                    //           color:Color(0xff44680E),
                                    //           borderRadius: BorderRadius.circular(260)
                                    //       ),
                                    //       child:Row(
                                    //         mainAxisAlignment: MainAxisAlignment.center,
                                    //         children: [
                                    //           Text("Continuer avec votre Email",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: 15,),
                                  ],
                                ),


                              ],
                            ),
                          ),

                        ),

                        // RoundedLoadingButton(
                        //   elevation: 0,
                        //   width: 50,
                        //   color: mainTextColor,
                        //   successIcon: Icons.check,
                        //   failedIcon: Icons.close,
                        //   valueColor: Colors.white,
                        //   successColor: Colors.green,
                        //   controller: _authServiceGoogle.continue_with_google_controller,
                        //   onPressed: () => _authServiceGoogle.googleLogin(context),
                        //   borderRadius: 260,
                        //   child: Container(
                        //     height: 50,
                        //     width: 263,
                        //     decoration: BoxDecoration(
                        //         color:Colors.white,
                        //         borderRadius: BorderRadius.circular(260)
                        //     ),
                        //     child:Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SvgPicture.asset("image/search (1).svg",width: 25.09,height: 25.09,),
                        //         SizedBox(width: 15,),
                        //         Text("Continuer avec Google",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // InkWell(
                        //   onTap: (){
                        //     controllar.googlelogin(context);
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 51,right: 51),
                        //     child:controllar.loder.value?Center(child: CircularProgressIndicator(),): Container(
                        //       height: 50,
                        //       width: MediaQuery.of(context).size.width,
                        //       decoration: BoxDecoration(
                        //           color:Colors.white,
                        //           borderRadius: BorderRadius.circular(260)
                        //       ),
                        //       child:Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           SvgPicture.asset("image/search (1).svg",width: 25.09,height: 25.09,),
                        //           SizedBox(width: 15,),
                        //           Text("Continuer avec Google",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),



                        SizedBox(height: 15,),
                      ],
                    ),


                  ],
                ),
              ),

            ),



























            // Column(
            //   children: [
            //     Container(
            //       height: 54,
            //       width: 339,
            //       decoration: BoxDecoration(
            //           border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
            //           borderRadius: BorderRadius.circular(25),
            //           color:mainTextColor
            //       ),
            //       child: Align(
            //         alignment: Alignment.bottomLeft,
            //
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 15),
            //           child: Center(
            //             child: Text("Déconnexion",
            //                 style: GoogleFonts.openSans(
            //                     textStyle: TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.bold,
            //                         color: whiteTextColor))),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 54,
            //       width: 339,
            //       decoration: BoxDecoration(
            //           border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
            //           borderRadius: BorderRadius.circular(25),
            //           color:mainTextColor
            //       ),
            //       child: Align(
            //         alignment: Alignment.bottomLeft,
            //
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 15),
            //           child: Center(
            //             child: Text("Déconnexion",
            //                 style: GoogleFonts.openSans(
            //                     textStyle: TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.bold,
            //                         color: whiteTextColor))),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //   ]
            // )



          ),
        );
      }

    }())





    );


  }
}
