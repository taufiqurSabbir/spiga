import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/screen/slider_page_8.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../controller/auth_controllar.dart';
import 'email_register_page.dart';
class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final FirebaseAuthForgotPasswordController forgotPassword = FirebaseAuthForgotPasswordController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F8).withOpacity(1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset("image/app-top-shape.svg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width+10,
            ),
            Text("Réinitialiser votre mot \n de passe ?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff44680E).withOpacity(1),
                  fontWeight: FontWeight.bold,fontSize: 23),),

            // Padding(
            //     padding:  const EdgeInsets.only(top: 53,left: 22,right: 22),
            //     child:

            SizedBox(height: 60),
            SizedBox(
              width: 300,
              child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: forgotPassword.emailController,
                    cursorColor: Color(0xff44680E).withOpacity(1),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: const Color(0xff060606),
                      fontWeight: FontWeight.bold,
                      height: 1.4166666666666667,
                    ),
                    // controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      labelText: "Email",


                      prefixIcon: InkWell(
                          child: new Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: new SizedBox(
                              height: 10,
                              child: Icon(Icons.email_outlined,color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2)),
                            ),
                          )),
                      labelStyle:  TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Theme.of(context)
                            .focusColor
                            .withOpacity(0.2),
                        fontWeight: FontWeight.w300,
                        height: 1.4166666666666667,
                      ),
                      fillColor:Color(0xffF1F2EF),
                      filled: true,
                      hintText: "xyz@gmail.com",
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: const Color(0xccb5b5b5),
                        fontWeight: FontWeight.w300,
                        height: 1.4166666666666667,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(20.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff44680E).withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  )
              ),
            ),
            SizedBox(height: 20),



            SizedBox(height: 37.01,),
            RoundedLoadingButton(
              elevation: 0,
              width: 270,
              color: mainTextColor,
              successIcon: Icons.check,
              failedIcon: Icons.close,
              valueColor: Colors.white,
              successColor: Colors.green,
              controller: forgotPassword.forgotPasswordController,
              onPressed: () => forgotPassword.sendPasswordResetEmail(context),
              borderRadius: 260,
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color:Color(0xff44680E),
                    borderRadius: BorderRadius.circular(260)
                ),
                child:Center(child: Text("Continuer",style: TextStyle(color: Colors.white),),),
              ),
            ),

          ],
        ),
      ),


    );
  }
}
