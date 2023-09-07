import 'dart:convert';

import 'package:laspigadoro/client/screen/we_are_preparing_your_order.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/screen/details_page.dart';
import 'package:laspigadoro/client/screen/qr_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../dialogue/Dialogue.dart';
import '../../helper/helper_function.dart';
import '../controllar/cart_controller.dart';


class PaiementValiderPage extends StatefulWidget {


  PaiementValiderPage({Key? key}) : super(key: key);

  @override
  State<PaiementValiderPage> createState() => _PaiementValiderPageState();
}

class _PaiementValiderPageState extends State<PaiementValiderPage> {

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
            child: Positioned(
                child:Column(
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
                    Text("Paiement Valider",
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
                                  text: " ${HelperFunction.splitTime(controller_cartController.pickUp_time.value)}", style: GoogleFonts.openSans(
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
                          print(controller_cartController.payment_status.value);

                          if(controller_cartController.payment_status==0) {


                            Dialogue.showLoadingDialog();

                            var response = await controller_cartController.placeOrderCash();

                            if (response.statusCode == 200) {
                              var data = json.decode(response.body);

                              if (data["status"] == "Order created successfully") {

                                controller_cartController.payment_status.value = 0;
                                controller_cartController.order_id.value = data["data"]["id"];
                                controller_cartController.resetValuesAfterPayment();


                                Get.offAll(
                                      () => PrepearingFoodScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              }
                              else if (data["status"].contains('Out of Stock')){
                                Fluttertoast.showToast(
                                  msg: 'En rupture de stock. Available  stock is ${HelperFunction.extractNumber(data["status"])}',
                                  toastLength: Toast.LENGTH_SHORT,
                                  fontSize: 14.0,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                );
                              }
                              else {
                                Fluttertoast.showToast(
                                  msg: "Votre commande n\'a pas abouti, Veuillez réessayer à nouveau",
                                  toastLength: Toast.LENGTH_SHORT,
                                  fontSize: 14.0,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                );
                              }
                            }
                            else {
                              Fluttertoast.showToast(
                                msg: 'Une erreur s\'est produite. Veuillez réessayer à nouveau',
                                toastLength: Toast.LENGTH_SHORT,
                                fontSize: 14.0,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                              );
                            }
                          }

                          if(controller_cartController.payment_status==3) {


                            Dialogue.showLoadingDialog();

                            var response = await controller_cartController.placeOrderTicket();

                            if (response.statusCode == 200) {
                              var data = json.decode(response.body);

                              if (data["status"] == "Order created successfully") {

                                controller_cartController.payment_status.value = 3;
                                controller_cartController.order_id.value = data["data"]["id"];
                                controller_cartController.resetValuesAfterPayment();


                                Get.offAll(
                                      () => PrepearingFoodScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              }
                              else if (data["status"].contains('Out of Stock')){
                                Fluttertoast.showToast(
                                  msg: 'En rupture de stock. Available  stock is ${HelperFunction.extractNumber(data["status"])}',
                                  toastLength: Toast.LENGTH_SHORT,
                                  fontSize: 14.0,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                );
                              }


                              else {
                                Fluttertoast.showToast(
                                  msg: 'Order Failed", "Your order has been failed',
                                  toastLength: Toast.LENGTH_SHORT,
                                  fontSize: 14.0,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                );
                              }
                              // Perform any additional actions with the transaction ID, e.g., store it in your database
                            }
                            else {
                              Fluttertoast.showToast(
                                msg: 'Something went wrong", "Please try again later',
                                toastLength: Toast.LENGTH_SHORT,
                                fontSize: 14.0,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                              );
                            }
                          }

                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DetailsPage()));



                        },
                        child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                              color: whiteTextColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(child: Text("Continuer le processus",
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
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            color: whiteTextColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(child: Text("Annuler le processus",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: mainTextColor))),
                          )
                      ),
                    ),

                  ],
                )
            ),
          )

        ],
      ),
    );
  }
}
