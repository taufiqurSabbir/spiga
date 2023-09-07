import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/screen/votre_carte_de_paiement_page.dart';
import 'package:laspigadoro/client/widget/paiement_textfild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MoyensDePaiementsPage extends StatefulWidget {
  const MoyensDePaiementsPage({Key? key}) : super(key: key);

  @override
  State<MoyensDePaiementsPage> createState() => _MoyensDePaiementsPageState();
}

class _MoyensDePaiementsPageState extends State<MoyensDePaiementsPage> {
  TextEditingController titulaireDeLa_Carte_Controllar =
      TextEditingController();
  TextEditingController date_expirationControllar = TextEditingController();
  TextEditingController cvc_cvv_Controllar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: bottomShetColor));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bottomShetColor,
        elevation: 1,
        title: Text("Moyens de paiements",
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => VotreCarteDePaiementPage()));
                },
                child: Icon(
                  Icons.done_sharp,
                  color: Colors.white,
                  size: 28,
                )),
          )
        ],
      ),
      backgroundColor: bottomShetColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("Renseignez vos infos de paiement",
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
              child: TextField(
                cursorColor: Color(0xff209602),
                style: TextStyle(fontSize: 15, color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Numéro de la carte",
                    hintStyle:
                        TextStyle(fontSize: 13, color: Color(0xffC7C7C7)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(color: Color(0xff4B4B4B78))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(color: Color(0xff4B4B4B78))),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(
                          right: 10, left: 10, top: 10, bottom: 10),
                      child: SvgPicture.asset(
                        "image/button_icon/credit-card-fill.svg",
                        height: 10,
                        width: 15,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PaiementTextFild(
                hintText: "Titulaire de la carte",
                controllar: titulaireDeLa_Carte_Controllar,
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: PaiementTextFild(
                      hintText: "Date d'expiration",
                      controllar: date_expirationControllar,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: PaiementTextFild(
                      hintText: "CVC / CVV",
                      controllar: cvc_cvv_Controllar,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
