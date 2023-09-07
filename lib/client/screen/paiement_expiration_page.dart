import 'package:laspigadoro/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
class PaiementExpirationdatePage extends StatefulWidget {
  const PaiementExpirationdatePage({Key? key}) : super(key: key);

  @override
  State<PaiementExpirationdatePage> createState() => _PaiementExpirationdatePageState();
}

class _PaiementExpirationdatePageState extends State<PaiementExpirationdatePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bottomShetColor,
        elevation: 1,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("Votre carte de paiement",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
            ),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 50,
                width: 375,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Color(0xff4B4B4B78))

                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SvgPicture.asset("image/button_icon/credit-card-fill.svg",
                        height: 18,width: 22,color: Colors.white,),
                    ),
                    Text("**** **** **** 5878",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                  ],
                ),
              ),
            ),
            SizedBox(height:55,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Date d'expiration",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
            ),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("08/25",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
            ),
            SizedBox(height: 109,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                width: 370,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xffD1002B).withOpacity(1)
                ),
                child: Center(child: Text("Supprimer cette carte",style:
                TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),),),
              ),
            )
          ],
        ),
      ),

    );
  }
}
