import 'package:laspigadoro/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'moyens_de_paiements_page.dart';
class PrenomConfiramPage extends StatefulWidget {
  const PrenomConfiramPage({Key? key}) : super(key: key);

  @override
  State<PrenomConfiramPage> createState() => _PrenomConfiramPageState();
}

class _PrenomConfiramPageState extends State<PrenomConfiramPage> {
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>MoyensDePaiementsPage()));
              },
                child: Icon(Icons.done_sharp,color: Colors.white,size: 30,)),
          )
        ],

      ),
      backgroundColor: bottomShetColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("Prénom",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: whiteTextColor))),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
                height: 47,
                width: 373,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                    color: Color(0xff606060).withOpacity(0.1)
                ),
              child:  Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainTextColorwithOpachity),
                    child: Center(
                        child: Icon(
                          Icons.clear_rounded,
                          size: 15,
                          color: whiteTextColor,
                        )),
                  ),
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
