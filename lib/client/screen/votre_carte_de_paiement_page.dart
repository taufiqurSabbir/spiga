import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/screen/paiement_expiration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'moyens_de_paiements_page.dart';

class VotreCarteDePaiementPage extends StatefulWidget {
  const VotreCarteDePaiementPage({Key? key}) : super(key: key);

  @override
  State<VotreCarteDePaiementPage> createState() =>
      _VotreCarteDePaiementPageState();
}

class _VotreCarteDePaiementPageState extends State<VotreCarteDePaiementPage> {
  var checkvalue = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: bottomShetColor));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bottomShetColor,
        elevation: 1,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 55,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("Votre carte de paiement",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PaiementExpirationdatePage()));
                  },
                  child: TextField(
                    enabled: false,
                    cursorColor: Color(0xff209602),
                    style: TextStyle(fontSize: 13, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "**** **** **** 5878",
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffC7C7C7)),
                        filled: true,
                        fillColor:
                            checkvalue ? mainTextColor : Colors.transparent,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Color(0xff4B4B4B78))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Color(0xff4B4B4B78))),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Color(0xff4B4B4B78))),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 8),
                          child: SvgPicture.asset(
                            "image/button_icon/credit-card-fill.svg",
                            height: 10,
                            width: 13,
                            color: Colors.white,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: Colors.white,
                        )),
                  ),
                )),
            SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Checkbox(
                      value: checkvalue,
                      checkColor: mainTextColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      fillColor: MaterialStatePropertyAll(whiteTextColor),
                      onChanged: (va) {
                        setState(() {
                          checkvalue = va!;
                        });
                      }),
                  Text("Carte par défaut",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: whiteTextColor))),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                enabled: false,
                style: TextStyle(fontSize: 15, color: Colors.white),
                cursorColor: Color(0xff209602),
                decoration: InputDecoration(
                    hintText: "**** **** **** 5878",
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffC7C7C7)),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Color(0xff4B4B4B78))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Color(0xff4B4B4B78))),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: Color(0xff4B4B4B78))),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 8),
                      child: SvgPicture.asset(
                        "image/button_icon/credit-card-fill.svg",
                        height: 10,
                        width: 13,
                        color: Colors.white,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 22,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: 85,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MoyensDePaiementsPage()));
                },
                child: Container(
                  height: 50,
                  width: 373,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xff209602).withOpacity(1)),
                  child: Center(
                    child: Text(
                      "+ Ajouter une nouvelle carte",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
