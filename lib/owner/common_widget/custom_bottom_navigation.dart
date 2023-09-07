import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/const.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../home_page_45.dart';
import '../panier_surprise.dart';
import '../profile_48.dart';
import 'package:sizer/sizer.dart';

import '../profile_page_pro_menu.dart';
import '../qr_code_scanner.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;


  var botomIcon=[
    "image/shop.svg",
    "image/qr-code-scan.svg",
    "image/profile_pic.svg"
  ];


   CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21,right: 19,top: 11,bottom: 17),
      child: Container(
        height: 70,width: 390,
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
                      MaterialPageRoute(builder: (context) => HomePageAdmin(boutique_id: store_id!)),
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
                                    top: 9.8,
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

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QRViewExample())
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
                                      color: currentIndex == 1 ? Colors.grey.withOpacity(0.2) : Color(0xffFFFFFF).withOpacity(1)

                                  ),

                                ),

                                Positioned(
                                    left: 28,
                                    top: 9.8,
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
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => ProfilePageAdmin()),
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
                                    top: 9.8,
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


                    ],
                  ),


                )),

          ],
        ),

      ),
    );
  }
}