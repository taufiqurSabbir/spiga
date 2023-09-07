import 'package:laspigadoro/owner/publier_une_offre_page_52.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/owner/publier_une_offre_deatails_page_56.dart';

import 'controller/food_upload_controller.dart';
import '../helper/helper_function.dart';

class DescriptionPage extends StatefulWidget {
  final FoodUploadControllerOwner controller_foodUploadController;

  DescriptionPage({Key? key, required this.controller_foodUploadController}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  TextEditingController descriptionControllar=TextEditingController();


  @override
  void initState() {
    if(widget.controller_foodUploadController.foodDescription.value != ""){
      descriptionControllar.text = widget.controller_foodUploadController.foodDescription.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bottomShetColor,
        elevation: 1,
        title: Text("Description",
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
                  if(descriptionControllar.text.length > 0) {

                    // print(HelperFunction.htmlEncode(descriptionControllar.text));
                    // print(descriptionControllar.text);
                    widget.controller_foodUploadController.foodDescription.value = descriptionControllar.text;
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>PublierUneOffrePage()));
                    Navigator.pop(context);


                  }
                  else{
                    Fluttertoast.showToast(
                      msg: "Vous n'avez écrit aucune description",
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("Description",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: whiteTextColor))),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0xff606060)
                ),
                child: TextField(
                  controller: descriptionControllar,
                  minLines: 20,
                  maxLines: 100,
                  style: TextStyle(fontSize: 15,color: whiteTextColor,),
                  cursorColor: mainTextColorwithOpachity,
                  decoration: InputDecoration(
                    hintText: "Description plat, panier...",
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.4),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffDFE7D6) ,width: 1),
                        borderRadius: BorderRadius.circular(7),

                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Color(0xffDFE7D6),width: 1),
                          borderRadius: BorderRadius.circular(7)
                      ),
                    hintStyle: TextStyle(fontSize: 12,color: Color(0xff9F9F9F))
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
