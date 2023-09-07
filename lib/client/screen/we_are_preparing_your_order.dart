import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/screen/details_page.dart';
import 'package:laspigadoro/client/screen/qr_code_page.dart';
import 'package:laspigadoro/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../controllar/cart_controller.dart';
import 'home_page.dart';
class PrepearingFoodScreen extends StatefulWidget {

   PrepearingFoodScreen({Key? key}) : super(key: key);

  @override
  State<PrepearingFoodScreen> createState() => _PrepearingFoodScreenState();
}

class _PrepearingFoodScreenState extends State<PrepearingFoodScreen> {
  final CartController controller_cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();

    controller_cartController.loadData();
  }


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 88.h,
            width: size.width,
            child: SvgPicture.asset("image/appbottomshape.svg",
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            // heightFactor:1.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h,),
                Container(
                  height: 111,
                  width: 111,
                  decoration: BoxDecoration(
                      color: whiteTextColor,
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: SvgPicture.asset("image/noun_basket_821481.svg",height: 47,width: 47,color: mainTextColorwithOpachity,),
                  ),
                ),
                SizedBox(height: 26.5,),
                Text("Nous préparons votre commande",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor
                        ))),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Text("Veuillez récupérer votre commande\n en montrant votre QR code enregistrer\n dans votre Profil",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: whiteTextColor,
                              fontWeight: FontWeight.bold
                          ))),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "image/clock (1).svg",
                      height: 16,
                      width: 16,
                      color: whiteTextColor,
                    ),
                    SizedBox(width: 7,),
                    RichText(text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Pick up:", style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: whiteTextColor))
                          ),
                          TextSpan(
                              text: " ${controller_cartController.customer_pickUp_time_from.value}", style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))
                          )
                        ]
                    )),
                  ],
                ),
                SizedBox(height: 18,),
                GestureDetector(
                    onTap: () async {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DetailsPage()));

                      final String? store_id = await getStoreId();

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePageClient(boutique_id: store_id!)),
                            (route) => false, // This condition ensures all pages are removed from the stack
                      );

                    },
                    child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: whiteTextColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(child: Text("Retour à la boutique",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: mainTextColor))),
                        )
                    )
                ),

                SizedBox(height: 10,),

                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCodePage()));
                    },
                    child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: whiteTextColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(child: Text("Voir mon QR code",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: mainTextColor))),
                    )
                ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}