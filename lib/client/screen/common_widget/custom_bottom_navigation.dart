import 'package:laspigadoro/client/screen/monCode_page_35.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:sizer/sizer.dart';

import '../../../const/const.dart';
import '../../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../add_to_cart_page.dart';
import '../home_page.dart';
import '../../controllar/cart_controller.dart';




class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final int quantity;

  var botomIcon=[
    "image/shop.svg",
    "image/noun_basket.svg",
    "image/profile_pic.svg"
  ];

   CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex, required this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21,right: 19,top: 15,bottom: 17),
      child: Container(
        height: 82,width: 470,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xffFFFFFF).withOpacity(1)

        ),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
                  onTap: () async {

                    final String? store_id = await getStoreId();

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePageClient(boutique_id: store_id!)),
                          (route) => false, // This condition ensures all pages are removed from the stack
                    );

                  },
                  child: Stack(
                    // clipBehavior: Clip.,
                    children: [

                      Align(
                          alignment: Alignment.center,
                          child: Stack(
                              children: [
                                Container(
                                  height: 105,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(100),
                                      shape: BoxShape.circle,

                                      // borderRadius: BorderRadius.circular(100),
                                      // color: Color(0xffF9F9F8).withOpacity(1)
                                      color: currentIndex == 0 ? Colors.grey.withOpacity(0.2) : Color(0xffFFFFFF).withOpacity(1)

                                  ),

                                ),

                                Positioned(
                                    left: 28,
                                    top: 16.8,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: currentIndex == 0 ? Color(0xff44680E) : Color(0xffFFFFFF).withOpacity(1)
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                            botomIcon[0],
                                            width: 21,
                                            height: 21,

                                            color:  currentIndex == 0 ? Color(0xffFFFF).withOpacity(1) : mainTextColor

                                        ),
                                      ),

                                    )
                                )

                              ]
                          )
                      )


                      // Positioned(
                      //   top: 10,
                      //   bottom: 15,
                      //   left: 8.w,
                      //   child:Container(
                      //     height: 60,
                      //     width: 60,
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color:Color(0xff44680E)
                      //     ),
                      //     child: Center(
                      //       child: SvgPicture.asset(
                      //         botomIcon[0],
                      //         width: 21,
                      //         height: 21,
                      //
                      //         color:  Color(0xffFFFF).withOpacity(1),
                      //
                      //       ),
                      //     ),
                      //
                      //   ),
                      // ),




                      // Positioned(
                      //     top: 12,
                      //      left: 64,
                      //      child:i==1? Container(
                      //        width: 25,
                      //          height: 25,
                      //          decoration: BoxDecoration(
                      //            borderRadius: BorderRadius.circular(100),
                      //            color: Color(0xffBDD516)
                      //          ),
                      //          child: Center(child: Text("3", style: GoogleFonts.openSans(
                      //              textStyle: TextStyle(
                      //                  fontSize: 14,
                      //                  fontWeight: FontWeight.bold,
                      //                  color: Color(0xfFFFFFF).withOpacity(1))),))):SizedBox())
                    ],
                  ),


                )),

            Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) =>
                        AddToCartPage()));

                    // final String? store_id = await getStoreId();
                    //
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => Panier_surprise(boutique_id: store_id!)),
                    //       (route) => false, // This condition ensures all pages are removed from the stack
                    // );

                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => QRViewExample()),
                    //       (route) => false, // This condition ensures all pages are removed from the stack
                    // );





                  },
                  child: Stack(
                    // clipBehavior: Clip.,
                    children: [

                      Align(
                          alignment: Alignment.center,
                          child: Stack(
                              children: [
                                Container(
                                  height: 105,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(100),
                                      shape: BoxShape.circle,

                                      // borderRadius: BorderRadius.circular(100),
                                      // color: Color(0xffF9F9F8).withOpacity(1)
                                      color: currentIndex == 1 ? Colors.grey.withOpacity(0.2) : Color(0xffFFFFFF).withOpacity(1)

                                  ),

                                ),


                                Positioned(
                                    left: 28,
                                    top: 16.8,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: currentIndex == 1 ? Color(0xff44680E) : Color(0xffFFFFFF).withOpacity(1)
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                            botomIcon[1],
                                            width: 21,
                                            height: 21,

                                            color:  currentIndex == 1 ? Color(0xffFFFF).withOpacity(1) : mainTextColor

                                        ),
                                      ),

                                    )
                                ),

                                quantity > 0
                                    ? Positioned(
                                    bottom: 48.0,
                                    right: 24.0,
                                    child: Container(

                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Color(0xffBDD516)),
                                      child: Text(" ${quantity.toString()} ", style: TextStyle(color: Colors.white),),


                                    )
                                )
                                    : SizedBox()

                              ]
                          )
                      )


                      // Positioned(
                      //   top: 10,
                      //   bottom: 15,
                      //   left: 8.w,
                      //   child:Container(
                      //     height: 60,
                      //     width: 60,
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color:Color(0xff44680E)
                      //     ),
                      //     child: Center(
                      //       child: SvgPicture.asset(
                      //         botomIcon[0],
                      //         width: 21,
                      //         height: 21,
                      //
                      //         color:  Color(0xffFFFF).withOpacity(1),
                      //
                      //       ),
                      //     ),
                      //
                      //   ),
                      // ),




                      // Positioned(
                      //     top: 12,
                      //      left: 64,
                      //      child:i==1? Container(
                      //        width: 25,
                      //          height: 25,
                      //          decoration: BoxDecoration(
                      //            borderRadius: BorderRadius.circular(100),
                      //            color: Color(0xffBDD516)
                      //          ),
                      //          child: Center(child: Text("3", style: GoogleFonts.openSans(
                      //              textStyle: TextStyle(
                      //                  fontSize: 14,
                      //                  fontWeight: FontWeight.bold,
                      //                  color: Color(0xfFFFFFF).withOpacity(1))),))):SizedBox())
                    ],
                  ),


                )),

            Expanded(
                child: GestureDetector(
                  onTap: (){

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MonCodePage()),
                          (route) => false, // This condition ensures all pages are removed from the stack
                    );

                  },
                  child: Stack(
                    // clipBehavior: Clip.,
                    children: [

                      Align(
                          alignment: Alignment.center,
                          child: Stack(
                              children: [
                                Container(
                                  height: 105,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(100),
                                      shape: BoxShape.circle,

                                      // borderRadius: BorderRadius.circular(100),
                                      // color: Color(0xffF9F9F8).withOpacity(1)
                                      color: currentIndex == 2 ? Colors.grey.withOpacity(0.2) : Color(0xffFFFFFF).withOpacity(1)

                                  ),

                                ),

                                Positioned(
                                    left: 28,
                                    top: 16.8,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: currentIndex == 2 ? Color(0xff44680E) : Color(0xffFFFFFF).withOpacity(1)
                                      ),
                                      child: Center(
                                        child:
                                        //Image.asset(botomIcon[2], width: 31, height: 31,),
                                        SvgPicture.asset(
                                            botomIcon[2],
                                            width: 23,
                                            height: 23,

                                            color:  currentIndex == 2 ? Color(0xffFFFF).withOpacity(1) : mainTextColor

                                        ),
                                      ),

                                    )
                                )

                              ]
                          )
                      )


                      // Positioned(
                      //   top: 10,
                      //   bottom: 15,
                      //   left: 8.w,
                      //   child:Container(
                      //     height: 60,
                      //     width: 60,
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color:Color(0xff44680E)
                      //     ),
                      //     child: Center(
                      //       child: SvgPicture.asset(
                      //         botomIcon[0],
                      //         width: 21,
                      //         height: 21,
                      //
                      //         color:  Color(0xffFFFF).withOpacity(1),
                      //
                      //       ),
                      //     ),
                      //
                      //   ),
                      // ),




                      // Positioned(
                      //     top: 12,
                      //      left: 64,
                      //      child:i==1? Container(
                      //        width: 25,
                      //          height: 25,
                      //          decoration: BoxDecoration(
                      //            borderRadius: BorderRadius.circular(100),
                      //            color: Color(0xffBDD516)
                      //          ),
                      //          child: Center(child: Text("3", style: GoogleFonts.openSans(
                      //              textStyle: TextStyle(
                      //                  fontSize: 14,
                      //                  fontWeight: FontWeight.bold,
                      //                  color: Color(0xfFFFFFF).withOpacity(1))),))):SizedBox())
                    ],
                  ),


                )),


          ],
        ),

      ),
    );
  }

}

