import 'package:laspigadoro/client/screen/common_widget/custom_bottom_navigation.dart';
import 'package:laspigadoro/client/screen/common_widget/custom_bottom_navigation_black.dart';
import 'package:laspigadoro/client/screen/personal_info_page_36.dart';
import 'package:laspigadoro/client/screen/privacy_policy.dart';
import 'package:laspigadoro/client/screen/qr_code_for_mon_qr_code_button.dart';
import 'package:laspigadoro/client/screen/qr_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/auth_controllar.dart';
import '../../login_page/login_page.dart';
import '../controllar/cart_controller.dart';
import 'package:get/get.dart';

import 'package:laspigadoro/const/const.dart';
import 'order_history_page_42.dart';

class MonCodePage extends StatefulWidget {
  const MonCodePage({Key? key}) : super(key: key);

  @override
  State<MonCodePage> createState() => _MonCodePageState();
}

class _MonCodePageState extends State<MonCodePage> {

  String _isGuest ="";

  var curentIndex=1;
  final CartController controller_cartController = Get.put(CartController());

  final FirebaseAuthLogOut _firebaseLogout = FirebaseAuthLogOut();
  final FirebaseAuthDelete _firebaseDelete = FirebaseAuthDelete();



  @override
  void initState() {
    super.initState();

    controller_cartController.loadData();
    guestOrNot();


  }

  Future<void> guestOrNot() async {
    print("---------");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _isGuest = (prefs.getString('isGuest')??'');
    });

    print(_isGuest);
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));
    print("testttttttttttt");
print(_isGuest);


    return Obx(()=>

        Scaffold(
          backgroundColor: bottomShetColor,

          bottomNavigationBar:  CustomBottomNavigationBarBlack(
            currentIndex: curentIndex,
            quantity: controller_cartController.quantity.value,

          ),





          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Center(
                child: Column(
                  children: [
                    Visibility(
                      visible: _isGuest== "1"? false : true,

                      child: Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PersonalInfoPage()));
                          },
                          child: Container(
                            height: 54,
                            width: 360,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                              borderRadius: BorderRadius.circular(7),
                              color:Color(0xff929292).withOpacity(0.1),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Mon Profil",
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
                    ),
                    SizedBox(height: 15,),



                    Visibility(
                      visible:  _isGuest== "1"? false : true,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderHistoryPage()));
                        },
                        child:Container(
                          height: 54,
                          width: 360,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                            borderRadius: BorderRadius.circular(7),
                            color:Color(0xff929292).withOpacity(0.1),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("Historique de commande",
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
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: () async {
                        //Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsPage()));

                        Uri  privacyPolicyUrl = Uri.parse('https://laspigadoro.fr/privacy-policy');

                        if (await canLaunchUrl(privacyPolicyUrl)) {
                        await launchUrl(privacyPolicyUrl);
                        } else {
                        throw 'Could not launch $privacyPolicyUrl';
                        }
                        //Navigator.push(context, MaterialPageRoute(builder: (_)=>PrivacyPolicyPage()));
                      },
                      child: Container(
                        height: 54,
                        width: 360,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                          borderRadius: BorderRadius.circular(7),
                          color:Color(0xff929292).withOpacity(0.1),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Politique de confidentialité",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70,),


                    Visibility(
                      visible:  _isGuest== "1"? false : true,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCodePageMonQrCodeButton()));
                        },
                        child: Container(
                          height: 50,
                          width: 360,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withOpacity(0.2),width: 1),
                              borderRadius: BorderRadius.circular(25),
                              color:mainTextColor
                          ),
                          child: Center(
                            child: Text("Mon QR code",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: whiteTextColor))),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    Expanded(
                      child: Container(),
                    ),

                    Visibility(
                      visible:  _isGuest== "1"? false : true,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
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
                                height: 50,
                                width: 360,
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
                            RoundedLoadingButton(
                                elevation: 0,
                                width: 50,
                                color: mainTextColor,
                                successIcon: Icons.check,
                                failedIcon: Icons.close,
                                valueColor: Colors.white,
                                successColor: Colors.green,
                                controller: _firebaseDelete.delete_controller,
                                onPressed: () => _firebaseDelete.deleteAccount(context),
                                borderRadius: 260,
                                child: Container(
                                  height: 54,
                                  width: 360,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                                      borderRadius: BorderRadius.circular(25),
                                      color:Colors.red
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,

                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Center(
                                        child: Text("Supprimer le compte",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: whiteTextColor))),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ],
                        )
                      ),
                    ),

                    Visibility(
                      visible:  _isGuest== "1"? true : false,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('isGuest', '0');

                                  Navigator.of(context)
                                      .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginPage()),
                                        (route) => false, // This condition ensures all pages are removed from the stack
                                  );
                                },
                                child: Container(
                                  height: 54,
                                  width: 360,
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
                                        child: Text("Se connecter ou s'inscrire",
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
                            ],
                          )
                      ),
                    )


                  ],
                ),
              ),
            ),
          ),
        )
    );



  }
}

