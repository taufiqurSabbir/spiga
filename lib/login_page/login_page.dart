import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:laspigadoro/controller/auth_controllar.dart';
import 'package:laspigadoro/helper/helper_function.dart';
import 'package:laspigadoro/login_page/email_login_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sizer/sizer.dart';
import 'dart:io' show Platform;

import '../api/api.dart';
import '../api/api_get_calls.dart';
import '../api/api_post_calls.dart';
import '../client/screen/choisir_votre_client.dart';
import '../client/screen/slider_page_8.dart';
import '../const/const.dart';
import '../dialogue/Dialogue.dart';
import '../model/UseAuth.dart';
import '../sharePreference/sharePreference_getFCM.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final GoogleLogin _authServiceGoogle = GoogleLogin();
  final AppleLogin _authServiceApple = AppleLogin();


  FirebaseAuth auth=FirebaseAuth.instance;
  String _isGuest = '';

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: mainTextColor
    ));

    return Scaffold(
      backgroundColor: Color(0xffF9F9F8).withOpacity(1),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child:

        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Align(
            alignment: Alignment.center,
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Wrap(
              children: [
                Column(
                  children: [

                    RoundedLoadingButton(
                      elevation: 0,
                      width: 50,
                      color: mainTextColor,
                      successIcon: Icons.check,
                      failedIcon: Icons.close,
                      valueColor: Colors.white,
                      successColor: Colors.green,
                      controller: _authServiceGoogle.continue_with_google_controller,
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('isGuest', '0');

                        _authServiceGoogle.googleLogin(context);
                      },
                      borderRadius: 260,
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(260)
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 12,),
                            SvgPicture.asset("image/search (1).svg",width: 18.09,height: 18.09,),
                            SizedBox(width: 6,),
                            Text("Continuer avec Google",style: TextStyle(color: Colors.black, fontSize: 17.92), )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 8,),

                    // RoundedLoadingButton(
                    //   elevation: 0,
                    //   width: 50,
                    //   color: mainTextColor,
                    //   successIcon: Icons.check,
                    //   failedIcon: Icons.close,
                    //   valueColor: Colors.white,
                    //   successColor: Colors.green,
                    //   controller: _authServiceApple.continue_with_apple_controller,
                    //   onPressed: () => _authServiceApple.appleLogin(context),
                    //   borderRadius: 260,
                    //   child: Container(
                    //     height: 50,
                    //     width: 300,
                    //     decoration: BoxDecoration(
                    //         color:Colors.black,
                    //         borderRadius: BorderRadius.circular(260)
                    //     ),
                    //     child:Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         SizedBox(width: 12,),
                    //         SvgPicture.asset("image/apple_logo.svg",width: 18.09,height: 18.09,),
                    //         SizedBox(width: 6,),
                    //         Text("Continuer avec Apple",style: TextStyle(color: Colors.white, fontSize: 17.92), )
                    //       ],
                    //     ),
                    //   ),
                    //
                    // ),

                    // InkWell(
                    //   onTap: (){
                    //     controllar.googlelogin(context);
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 51,right: 51),
                    //     child:controllar.loder.value?Center(child: CircularProgressIndicator(),): Container(
                    //       height: 50,
                    //       width: MediaQuery.of(context).size.width,
                    //       decoration: BoxDecoration(
                    //           color:Colors.white,
                    //           borderRadius: BorderRadius.circular(260)
                    //       ),
                    //       child:Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           SvgPicture.asset("image/search (1).svg",width: 25.09,height: 25.09,),
                    //           SizedBox(width: 15,),
                    //           Text("Continuer avec Google",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),


                    Visibility(
                      visible: Platform.isIOS,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color:Color(0xff209602),
                                      borderRadius: BorderRadius.circular(260)
                                  ),
                                  child:SignInWithAppleButton(

                                    text: "Continuer avec Apple",

                                    onPressed: () async {

                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('isGuest', '0');

                                      Dialogue.showLoadingDialog();
                                      try{
                                        final rawNonce = generateNonce();
                                        final nonce = HelperFunction.sha256ofString(rawNonce);
                                        final appleCredential = await SignInWithApple.getAppleIDCredential(
                                          scopes: [
                                            AppleIDAuthorizationScopes.email,
                                            AppleIDAuthorizationScopes.fullName,
                                          ],
                                          nonce: nonce,
                                        );

                                        final oauthCredential = OAuthProvider("apple.com").credential(
                                          idToken: appleCredential.identityToken,
                                          rawNonce: rawNonce,
                                        );

                                        final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);

                                        print("userCredential => ");
                                        print(userCredential);

                                        print("apple credential => ");
                                        print(appleCredential.familyName);
                                        print(appleCredential.givenName);
                                        print(appleCredential.email);


                                        String? email;

                                        if(appleCredential.email == null){
                                          String uid = userCredential.user!.uid;

                                          email = "$uid@laspigadoro.com";
                                        }
                                        else{
                                          email = appleCredential.email;
                                        }

                                        if(email!=null){
                                          final url = Uri.parse(Api.registerApi);
                                          print("Api: ${Api.registerApi}");

                                          UserAuth authUserBody = UserAuth(name: "${appleCredential.givenName!} ${appleCredential.familyName!}", email: email);
                                          print(authUserBody.body());
                                          final response = await post(url, body: authUserBody.body());
                                          print('Status code: ${response.statusCode}');
                                          print('Body: ${response.statusCode}');

                                          var data = UserAuth.resp(json.decode(response.body));

                                          //fcm id


                                          if(response.statusCode == 200){
                                            if(data.status == "Wrong Credentials"){

                                              //Error  occured
                                              Dialogue.dismissLoadingDialog();

                                              Fluttertoast.showToast(
                                                msg: 'Quelque chose s\'est mal passé.',
                                                toastLength: Toast.LENGTH_SHORT,
                                                fontSize: 14.0,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                              );

                                            }

                                            if(data.status == "user" || (data.user != null && data.user == "user")){
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              print(data.token!);
                                              prefs.setString('token', data.token!);

                                              var fcm_id_response = await ApiPostCalls.postApiResponse(Api.fcmIdApi, {"fcmid": await getFcmId()});

                                              var userInfo_response = await ApiGetCalls.getApiResponse(Api.userInfoApi);

                                              if(userInfo_response.statusCode == 200){
                                                var userInfo = json.decode(userInfo_response.body);

                                                Dialogue.dismissLoadingDialog();

                                                Fluttertoast.showToast(
                                                  msg: "Connecté avec succès",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  fontSize: 14.0,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                );

                                                if(userInfo["tutorial_steps"]==0){
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SliderPage()),
                                                        (route) => false, // This condition ensures all pages are removed from the stack
                                                  );
                                                }
                                                else{
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Choisir_Scren_Client()),
                                                        (route) => false, // This condition ensures all pages are removed from the stack
                                                  );
                                                }


                                              }
                                              else{
                                                final FirebaseAuth _auth = FirebaseAuth.instance;

                                                try {
                                                  // Sign out from all providers
                                                  await _auth.signOut();
                                                  print('User signed out');


                                                  var response = await ApiPostCalls.postApiResponse(Api.logoutApi, {});

                                                  if(response.statusCode == 200){

                                                    print("User logged out");


                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    prefs.setString('token', "");

                                                    Dialogue.dismissLoadingDialog();

                                                    Fluttertoast.showToast(
                                                      msg: 'Quelque chose s\'est mal passé.',
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      fontSize: 14.0,
                                                      gravity: ToastGravity.BOTTOM,
                                                      backgroundColor: Colors.red,
                                                    );

                                                  }
                                                  else{
                                                    print("User not logged out");

                                                    Dialogue.dismissLoadingDialog();

                                                    Fluttertoast.showToast(
                                                      msg: 'Quelque chose s\'est mal passé.',
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      fontSize: 14.0,
                                                      gravity: ToastGravity.BOTTOM,
                                                      backgroundColor: Colors.red,
                                                    );

                                                  }


                                                }
                                                catch (e) {
                                                  print('Error signing out: $e');

                                                  Dialogue.dismissLoadingDialog();

                                                }
                                              }

                                            }

                                            if(data.status == "admin"){
                                              Dialogue.dismissLoadingDialog();

                                              Fluttertoast.showToast(
                                                msg: 'Quelque chose s\'est mal passé.',
                                                toastLength: Toast.LENGTH_SHORT,
                                                fontSize: 14.0,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                              );
                                            }
                                          }
                                          else{
                                            Dialogue.dismissLoadingDialog();

                                            Fluttertoast.showToast(
                                              msg: 'Quelque chose s\'est mal passé.',
                                              toastLength: Toast.LENGTH_SHORT,
                                              fontSize: 14.0,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.red,
                                            );
                                          }
                                        }
                                        else {
                                          Dialogue.dismissLoadingDialog();

                                          Fluttertoast.showToast(
                                            msg: 'Échec de la connexion avec Apple',
                                            toastLength: Toast.LENGTH_SHORT,
                                            fontSize: 14.0,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                          );

                                        }
                                      }
                                      catch(error){
                                        Dialogue.dismissLoadingDialog();

                                        Fluttertoast.showToast(
                                          msg: 'Échec de la connexion avec Apple',
                                          toastLength: Toast.LENGTH_SHORT,
                                          fontSize: 14.0,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                        );
                                      }



                                    },

                                    borderRadius: BorderRadius.circular(260),

                                  )
                              ),
                            ),
                            SizedBox(height: 8,),

                          ],
                        )
                    ),
                    // RoundedLoadingButton(
                    //   elevation: 0,
                    //   width: 50,
                    //   color: mainTextColor,
                    //   successIcon: Icons.check,
                    //   failedIcon: Icons.close,
                    //   valueColor: Colors.white,
                    //   successColor: Colors.green,
                    //   controller: _authServiceGoogle.continue_with_google_controller,
                    //   onPressed: () => _authServiceGoogle.googleLogin(context),
                    //   borderRadius: 260,
                    //   child: Container(
                    //     height: 50,
                    //     width: 300,
                    //     decoration: BoxDecoration(
                    //         color:Colors.white,
                    //         borderRadius: BorderRadius.circular(260)
                    //     ),
                    //     child:Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         SizedBox(width: 12,),
                    //         SvgPicture.asset("image/search (1).svg",width: 18.09,height: 18.09,),
                    //         SizedBox(width: 6,),
                    //         Text("Continuer avec Google",style: TextStyle(color: Colors.black, fontSize: 17.92), )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0,right: 0),
                      child: InkWell(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('isGuest', '0');

                          Navigator.push(context,MaterialPageRoute(builder: (_)=>EmailLoginPage()));

                        },
                        child: Container(
                          height: 50,
                          width:300 ,
                          decoration: BoxDecoration(
                              color:Color(0xff209602),
                              borderRadius: BorderRadius.circular(260)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //  SvgPicture.asset("image/simple_email.svg",color: Colors.white,width: 25.09,height: 25.09,),
                              SizedBox(width: 12,),
                              Image.asset("image/mail-9.png", width: 20.09, height: 20.09,),
                              //SvgPicture.asset("image/wmail.svg",width: 18.09,height: 18.09,),
                              SizedBox(width: 4,),
                              Text("Continuer avec Email",style: TextStyle(color: Colors.white, fontSize: 18.92),)
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8,),

                    Padding(
                      padding: const EdgeInsets.only(left: 0,right: 0),
                      child: InkWell(
                        onTap: () async {
                           SharedPreferences prefs = await SharedPreferences.getInstance();
                           prefs.setString('isGuest', '1');

                          Navigator.push(context,MaterialPageRoute(builder: (_)=>Choisir_Scren_Client(isGuest: true)));
                        },
                        child: Container(
                          height: 50,
                          width:300 ,
                          decoration: BoxDecoration(
                              color:Color(0xff779F52).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(260)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //  SvgPicture.asset("image/simple_email.svg",color: Colors.white,width: 25.09,height: 25.09,),

                              Text("Continuer en tant qu'invité",style: TextStyle(color: Color(0xff209602), fontSize: 18.92),)
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15,),
                  ],
                ),


              ],
            ),
          ),

        ),
      ),

      body:

      Column(

        children: [
          Container(

            height: 27,
            color: Color(0xff209602),




          ),

          Container(
            child: SvgPicture.asset("image/italian_app_top_svg_shape.svg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width+10,
              // height: 24.h,
            ),
            transform: Matrix4.translationValues(0, -0.06, 0),
          ),


          Padding(
            padding: EdgeInsets.only(bottom: 5, top: 15),
            child: Image.asset('image/laspigadoro_green.png', width: MediaQuery.of(context).size.width/1.6,),

          ),
          // Text("Ensemble, reduissons",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 23,
          //         color: Color(0xff44680E).withOpacity(1))
          // ),
          // Text("le gaspillage",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 23,
          //         color: Color(0xff44680E).withOpacity(1))
          // ),
          Expanded( // add this
              child: Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage("image/splashImage2.png"),


                  width: 65.w,),
              )
          )

        ],
      ),

    );

  }



}