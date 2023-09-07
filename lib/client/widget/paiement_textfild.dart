import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class PaiementTextFild extends StatelessWidget {
   final String hintText;
   final TextEditingController controllar;
   PaiementTextFild({Key? key, required this.hintText, required this.controllar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controllar,
      cursorColor: Color(0xff44680E),
      style: TextStyle(fontSize: 15,color: Colors.white),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 13,color: Color(0xffC7C7C7))),
          filled: true,
          fillColor: Color(0xffffffff).withOpacity(0.009),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(
                  color: Color(0xff4B4B4B78)
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(
                  color: Color(0xff4B4B4B78)
              )
          )
      ),
    );
  }
}
