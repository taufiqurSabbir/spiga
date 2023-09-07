import 'package:laspigadoro/owner/publier_une_offre_page_52.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/owner/publier_une_offre_deatails_page_56.dart';
import 'package:sizer/sizer.dart';

import '../controller/Public_Draft_Edit_Delete/food_edit_controller.dart';



class TitreDeLoffrePageForEdit extends StatefulWidget {
  final FoodEditController controller_foodEditController;

  TitreDeLoffrePageForEdit({Key? key, required this.controller_foodEditController}) : super(key: key);

  @override
  State<TitreDeLoffrePageForEdit> createState() => _TitreDeLoffrePageForEditState();
}

class _TitreDeLoffrePageForEditState extends State<TitreDeLoffrePageForEdit> {
  TextEditingController crossControllar=TextEditingController();


  @override
  void initState() {
    super.initState();
    crossControllar.text = widget.controller_foodEditController.foodName.value;
  }

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
        title: Text("Titre de l'offre",
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
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {

                  if(crossControllar.text.length > 0) {
                    widget.controller_foodEditController.foodName.value = crossControllar.text;
                    // Navigator.pushReplacement(context, MaterialPageRoute(
                    //     builder: (_) => PublierUneOffrePage()));

                    Navigator.pop(context);
                  }
                  else{
                    Fluttertoast.showToast(
                      msg: "Vous n'avez écrit aucun nom",
                      toastLength: Toast.LENGTH_SHORT,
                      fontSize: 14.0,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                child: Icon(Icons.done,size: 31,color: whiteTextColor,)),
          )
        ],


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
                child: Text("Titre de l'offre",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor))),
              ),
              SizedBox(height: 10,),
              Container(
                height: 47,
                width: 95.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Color(0xffDFE7D6).withOpacity(0.1)),
                    color: Color(0xff606060).withOpacity(0.1)
                ),
                child:
                TextField(
                  cursorColor: mainTextColorwithOpachity,
                  style: TextStyle(color: Colors.white),
                  controller: crossControllar,
                  decoration: InputDecoration(
                    focusColor: mainTextColorwithOpachity.withOpacity(0.4),
                    hintText: 'Nom du plat ou panier surprise',
                    hintStyle: TextStyle(color: Color(0xff9f9f9f), fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 8.0, top: 9.8),
                    focusedBorder: OutlineInputBorder(

                      borderSide: BorderSide(width: 1,color: mainTextColorwithOpachity),
                    ),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: mainTextColorwithOpachity.withOpacity(0.4),
                        child: Center(
                            child: InkWell(
                              onTap:  () {
                                crossControllar.clear();
                              },
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: whiteTextColor,
                              ),
                            )),
                      ),
                    ),

                  ),
                ),

                // ListTile(
                //
                //   trailing:Padding(
                //     padding:  EdgeInsets.only(bottom: 10),
                //     child: CircleAvatar(
                //       radius: 12,
                //       backgroundColor: mainTextColorwithOpachity.withOpacity(0.4),
                //       child: Center(
                //           child: Icon(
                //             Icons.close,
                //             size: 18,
                //             color: whiteTextColor,
                //           )),
                //     ),
                //   ),
                // )
              ),


            ],
          ),
        ),
      ),
    );
  }
}
