import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/screen/prenom_confiram_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'notification_page.dart';
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
        leading: Padding(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
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
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>PrenomConfiramPage()));

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
              SizedBox(height: 15,),
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
                      child: Text("Politique de confidentialité",
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


              SizedBox(height: 75,),
              Container(
                height: 54,
                width: 339,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1),width: 1),
                  borderRadius: BorderRadius.circular(25),
                  color:mainTextColor
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
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
            ],
          ),
        ),
      ),
    );
  }
}
