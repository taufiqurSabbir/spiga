import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laspigadoro/client/screen/add_to_cart_page.dart';
import 'package:laspigadoro/client/screen/home_page.dart';
import 'package:laspigadoro/client/screen/slider_page_8.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../api/api.dart';
import '../api/api_get_calls.dart';
import '../api/api_post_calls.dart';
import '../client/screen/choisir_votre_client.dart';
import '../login_page/email_login_page.dart';
import '../login_page/login_page.dart';
import '../model/UseAuth.dart';
import '../owner/choisir_votre_admin_47.dart';
import '../sharePreference/sharePreference_getFCM.dart';


class GoogleLogin{

  GoogleLogin();

  RoundedLoadingButtonController continue_with_google_controller = RoundedLoadingButtonController();

  //Firebase authentication with google
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {


    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }


  void googleLogin(BuildContext context) async {

    final UserCredential? user = await signInWithGoogle();

    if (user != null) {

        final url = Uri.parse(Api.registerApi);
        print("Api: ${Api.registerApi}");

        UserAuth authUserBody = UserAuth(name: user.user?.displayName, email: user.user?.email);
        print(authUserBody.body());
        final response = await post(url, body: authUserBody.body());
        print('Status code: ${response.statusCode}');
        print('Body: ${response.statusCode}');

        var data = UserAuth.resp(json.decode(response.body));

        //fcm id


        if(response.statusCode == 200){
          if(data.status == "Wrong Credentials"){
            //Error  occured

            continue_with_google_controller.error();



            Fluttertoast.showToast(
              msg: 'Quelque chose s\'est mal passé.',
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 14.0,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
            );

            Timer(Duration(seconds: 2), () {
              continue_with_google_controller.reset();
            });
          }

          if(data.status == "user" || (data.user != null && data.user == "user")){
            SharedPreferences prefs = await SharedPreferences.getInstance();
            print(data.token!);
            prefs.setString('token', data.token!);

            var fcm_id_response = await ApiPostCalls.postApiResponse(Api.fcmIdApi, {"fcmid": await getFcmId()});

            var userInfo_response = await ApiGetCalls.getApiResponse(Api.userInfoApi);

            if(userInfo_response.statusCode == 200){
              var userInfo = json.decode(userInfo_response.body);

              continue_with_google_controller.success();

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

                String redirectPage ="";
                redirectPage = (prefs.getString('redirectPage')??'');
                print(redirectPage);

                if(redirectPage =="goToPage"){
                  Navigator.of(context)
                      .pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            AddToCartPage()),
                        (route) => false, // This condition ensures all pages are removed from the stack
                  );

                }
                else {
                  Navigator.of(context)
                      .pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            Choisir_Scren_Client()),
                        (
                        route) => false, // This condition ensures all pages are removed from the stack
                  );
                }

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

                  continue_with_google_controller.error();

                  Fluttertoast.showToast(
                    msg: 'Quelque chose s\'est mal passé.',
                    toastLength: Toast.LENGTH_SHORT,
                    fontSize: 14.0,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                  );

                  Timer(Duration(seconds: 2), () {
                    continue_with_google_controller.reset();
                  });

                }
                else{
                  print("User not logged out");

                  continue_with_google_controller.error();

                  Fluttertoast.showToast(
                    msg: 'Quelque chose s\'est mal passé.',
                    toastLength: Toast.LENGTH_SHORT,
                    fontSize: 14.0,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                  );

                  Timer(Duration(seconds: 2), () {
                    continue_with_google_controller.reset();
                  });
                }


              }
              catch (e) {
                print('Error signing out: $e');

                continue_with_google_controller.error();

                Timer(Duration(seconds: 3),
                        () async {
                      continue_with_google_controller.reset();
                    });
              }




          }

          }

          if(data.status == "admin"){
            continue_with_google_controller.error();

            Fluttertoast.showToast(
              msg: 'Quelque chose s\'est mal passé.',
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 14.0,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
            );

            Timer(Duration(seconds: 2), () {
              continue_with_google_controller.reset();
            });

          }


        }
        else{
          continue_with_google_controller.error();

          Fluttertoast.showToast(
            msg: 'Quelque chose s\'est mal passé.',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );


          Timer(Duration(seconds: 2), () {
            continue_with_google_controller.reset();

          });


        }
    }
    else {
      Timer(Duration(seconds: 2), () {
        continue_with_google_controller.error();

        Fluttertoast.showToast(
          msg: 'Échec de la connexion avec Google',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );

        continue_with_google_controller.reset();
      });
    }
  }
}


class FirebaseAuthLogOut{
  FirebaseAuthLogOut();

  RoundedLoadingButtonController logout_controller = RoundedLoadingButtonController();


  Future<void> signOut(BuildContext context) async {
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

        logout_controller.success();

        Timer(Duration(seconds: 3),
                ()  {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false, // The condition to remove all previous routes
              );
            });
      }
      else{
        print("User not logged out");

        logout_controller.error();

        Timer(Duration(seconds: 3),
                () async {
              logout_controller.reset();
            });
      }


    } catch (e) {
      print('Error signing out: $e');

      logout_controller.error();

      Timer(Duration(seconds: 3),
      () async {
        logout_controller.reset();
      });
    }
  }
}

class FirebaseAuthDelete{
  FirebaseAuthDelete();

  RoundedLoadingButtonController delete_controller = RoundedLoadingButtonController();


  Future<void> deleteAccount(BuildContext context) async {

    AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Es-tu sûr?',
        desc: 'Votre compte et toutes les informations seront supprimés de façon permanente.',
        btnCancelColor: Colors.green,
        btnCancelText: 'Annuler',
        btnCancelOnPress: () {
          delete_controller.reset();
        },
        btnOkText: 'Supprimer',
        btnOkColor: Colors.red,
    btnOkOnPress: () async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        try {
          await currentUser.delete();
          print('User account deleted');

          var response = await ApiPostCalls.postApiResponse(Api.logoutApi, {});

          if(response.statusCode == 200){

            print("User logged out");


            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', "");

            delete_controller.success();

            Timer(Duration(seconds: 3),
                    ()  {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false, // The condition to remove all previous routes
                  );
                });
          }
          else{
            print("User not logged out");

            delete_controller.error();

            Timer(Duration(seconds: 3),
                    () async {
                  delete_controller.reset();
                });
          }



        } catch (e) {
          print('Error deleting user account: $e');
          delete_controller.error();

          Timer(Duration(seconds: 3),
                  () async {
                delete_controller.reset();
              });
        }
      }
      else {
        print('No user currently signed in');
        delete_controller.error();

        Timer(Duration(seconds: 3),
                () async {
              delete_controller.reset();
            });
      }


    },
    )..show();








    //
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    //
    // try {
    //   // Sign out from all providers
    //   await _auth.signOut();
    //   print('User signed out');
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('token', "");
    //   logout_controller.success();
    //
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginPage()),
    //         (route) => false, // The condition to remove all previous routes
    //   );
    //
    // } catch (e) {
    //   print('Error signing out: $e');
    //
    //   logout_controller.error();
    //
    //   Timer(Duration(seconds: 3),
    //           () async {
    //         logout_controller.reset();
    //       });
    // }
  }
}

class ManualRegisterController{

  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool checkvalue=false;


  RoundedLoadingButtonController manual_reg_controller = RoundedLoadingButtonController();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void register(BuildContext context) async {



    if(first_nameController.text.length == 0){
      manual_reg_controller.reset();


      Fluttertoast.showToast(
        msg: 'Inserire il nome.',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );


    }

    if(last_nameController.text.length == 0){
      manual_reg_controller.reset();


      Fluttertoast.showToast(
        msg: 'Inserire il cognome',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );


    }

    else if(emailController.text.length == 0){
      manual_reg_controller.reset();

      Fluttertoast.showToast(
        msg: 'Remplissez le champ e-mail.',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );

    }
    else if(passwordController.text.length == 0){
      manual_reg_controller.reset();

      Fluttertoast.showToast(
        msg: 'Remplissez le champ du mot de passe.',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );


    }
    else if(confirmPasswordController.text.length == 0){
      manual_reg_controller.reset();

      Fluttertoast.showToast(
        msg: 'Remplissez le champ de confirmation du mot de passe.',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );

    }
    else if(passwordController.text != confirmPasswordController.text){
      manual_reg_controller.reset();

      Fluttertoast.showToast(
        msg: 'Les champs de mot de passe et de confirmation de mot de passe doivent être identiques.',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );



    }
    else if(isValidEmail(emailController.text) == false) {
      manual_reg_controller.reset();

      Fluttertoast.showToast(
        msg: 'Le format de votre e-mail n\'est pas correct',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
    else if (checkvalue == false) {
      manual_reg_controller.reset();

      Fluttertoast.showToast(
        msg: 'Vous devez nous donner la permission',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
    else{
      final url = Uri.parse(Api.registerApi);
      print("Api: ${Api.registerApi}");

      UserAuth authUserBody = UserAuth(name: first_nameController.text,last_name: last_nameController.text, email: emailController.text, password: passwordController.text);
      print(authUserBody.body());
      final response = await post(url, body: authUserBody.body());
      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');

      var data = UserAuth.resp(json.decode(response.body));

      if(response.statusCode == 200){
        print('Body: ${response.body}');
        if(data.status == "Wrong Credentials"){
          //Error  occured

          manual_reg_controller.error();

          Fluttertoast.showToast(
            msg: 'Quelque chose s\'est mal passé.',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );

          Timer(Duration(seconds: 2), () {
            manual_reg_controller.reset();
          });
        }

        if(data.status == "user" || (data.user != null && data.user == "user")){

          try {
            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

            manual_reg_controller.success();

            Fluttertoast.showToast(
              msg: "Connecté avec succès",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 14.0,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
            );


            Timer(Duration(seconds: 2), () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EmailLoginPage()));
            });

          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {

              print('The password provided is too weak.');

              manual_reg_controller.error();

              Fluttertoast.showToast(
                msg: 'Le mot de passe fourni est trop faible.',
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 14.0,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
              );


              Timer(Duration(seconds: 2), () {
                manual_reg_controller.reset();

              });



            }
            else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');

              manual_reg_controller.error();

              Fluttertoast.showToast(
                msg: 'Le compte existe déjà pour cet e-mail.',
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 14.0,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
              );


              Timer(Duration(seconds: 2), () {
                manual_reg_controller.reset();

              });

            }
          } catch (e) {
            print(e);

            manual_reg_controller.error();

            Fluttertoast.showToast(
              msg: 'Quelque chose s\'est mal passé.',
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 14.0,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
            );


            Timer(Duration(seconds: 2), () {
              manual_reg_controller.reset();
            });

          }

        }

        if(data.status == "admin"){
          manual_reg_controller.error();

          Fluttertoast.showToast(
            msg: 'Quelque chose s\'est mal passé.',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );

          Timer(Duration(seconds: 2), () {
            manual_reg_controller.reset();
          });
        }

      }
      else{
        manual_reg_controller.error();

        Fluttertoast.showToast(
          msg: 'Quelque chose s\'est mal passé.',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );


        Timer(Duration(seconds: 2), () {
          manual_reg_controller.reset();
        });


      }
    }


  }



}

class ManualLoginController   {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool checkvalue=false;







  RoundedLoadingButtonController manual_login_controller = RoundedLoadingButtonController();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void login(BuildContext context) async {

    //Only  for  test
    //Admin
    // emailController.text = "admin@admin.com";
    // passwordController.text = "@@Bladepro@123@@";
    // checkvalue = true;

    // Customer
    // emailController.text = "ghuum@ghuum.com";
    // passwordController.text = "@@Bladepro@123@@";
    // checkvalue = true;


    if(emailController.text.length == 0){
      manual_login_controller.reset();

      Fluttertoast.showToast(
        msg: 'Remplissez le champ e-mail.',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );

    }
    else if(passwordController.text.length == 0){
      manual_login_controller.reset();

      Fluttertoast.showToast(
        msg: 'Remplissez le champ du mot de passe.',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );


    }
    else if(isValidEmail(emailController.text) == false) {
      manual_login_controller.reset();

      Fluttertoast.showToast(
        msg: 'Le format de votre e-mail n\'est pas correct',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
    else if (checkvalue == false) {
      manual_login_controller.reset();

      Fluttertoast.showToast(
        msg: 'Vous devez nous donner la permission',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
    else{

      //Check admin  or  not
      //If we  got  error  then it  is admin  cause we  are not sending  password  now

      final url = Uri.parse(Api.registerApi);
      print("Api: ${Api.registerApi}");

      UserAuth authUserBody = UserAuth(name: "Test",last_name: "test", email: emailController.text);
      print(authUserBody.body());
      var response = await post(url, body: authUserBody.body());
      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');

      var data = UserAuth.resp(json.decode(response.body));


      if(response.statusCode == 200){
        if(data.status == "Wrong Credentials"){
          //That means it is admin

          authUserBody = UserAuth(name: "Test", email: emailController.text, password: passwordController.text);
          print(authUserBody.body());

          response = await post(url, body: authUserBody.body());
          print('Status code: ${response.statusCode}');
          print('Body: ${response.statusCode}');

          data = UserAuth.resp(json.decode(response.body));


          if(response.statusCode == 200){
              if(data.status == "admin"){
                SharedPreferences prefs = await SharedPreferences.getInstance();
                print(data.token!);
                prefs.setString('token', data.token!);

                var fcm_id_response = await ApiPostCalls.postApiResponse(Api.fcmIdApi, {"fcmid": await getFcmId()});

                manual_login_controller.success();

                Fluttertoast.showToast(
                  msg: "Bonjour, administrateur",
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 14.0,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                );

                // Timer(Duration(seconds: 2), () {
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SliderPage()));
                // });

                Timer(Duration(seconds: 2), () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Choisir_Scren_Admin()));
                });
              }
              else{
                manual_login_controller.error();

                Fluttertoast.showToast(
                  msg: 'Votre adresse e-mail ou votre mot de passe est erroné.',
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 14.0,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                );

                Timer(Duration(seconds: 2), () {
                  manual_login_controller.reset();
                });
              }
            }
          else {
            manual_login_controller.error();

            Fluttertoast.showToast(
              msg: 'Quelque chose s\'est mal passé.',
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 14.0,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
            );

            Timer(Duration(seconds: 2), () {
              manual_login_controller.reset();
            });
          }
          }

        if(data.status == "user" || (data.user != null && data.user == "user")){

          try {
            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );


              SharedPreferences prefs = await SharedPreferences.getInstance();
              print(data.token!);
              prefs.setString('token', data.token!);
              var fcm_id_response = await ApiPostCalls.postApiResponse(Api.fcmIdApi, {"fcmid": await getFcmId()});
              var userInfo_response = await ApiGetCalls.getApiResponse(Api.userInfoApi);

              if(userInfo_response.statusCode == 200){
                var userInfo = json.decode(userInfo_response.body);

                manual_login_controller.success();

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


                  String redirectPage ="";
                  redirectPage = (prefs.getString('redirectPage')??'');
                  print(redirectPage);

                  if(redirectPage =="goToPage"){
                    Navigator.of(context)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              AddToCartPage()),
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

                    manual_login_controller.error();

                    Fluttertoast.showToast(
                      msg: 'Quelque chose s\'est mal passé.',
                      toastLength: Toast.LENGTH_SHORT,
                      fontSize: 14.0,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                    );

                    Timer(Duration(seconds: 2), () {
                      manual_login_controller.reset();
                    });

                  }
                  else{
                    print("User not logged out");

                    manual_login_controller.error();

                    Fluttertoast.showToast(
                      msg: 'Quelque chose s\'est mal passé.',
                      toastLength: Toast.LENGTH_SHORT,
                      fontSize: 14.0,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                    );

                    Timer(Duration(seconds: 2), () {
                      manual_login_controller.reset();
                    });
                  }


                }
                catch (e) {
                  print('Error signing out: $e');

                  manual_login_controller.error();

                  Timer(Duration(seconds: 3),
                          () async {
                            manual_login_controller.reset();
                      });
                }




              }



          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {

              print('No user found for that email.');

              manual_login_controller.error();

              Fluttertoast.showToast(
                msg: 'Aucun utilisateur trouvé pour cet e-mail.',
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 14.0,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
              );


              Timer(Duration(seconds: 2), () {
                manual_login_controller.reset();

              });



            }
            else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');

              manual_login_controller.error();

              Fluttertoast.showToast(
                msg: 'Mauvais mot de passe fourni pour cet utilisateur.',
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 14.0,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
              );


              Timer(Duration(seconds: 2), () {
                manual_login_controller.reset();

              });

            }
          } catch (e) {
            print(e);

            manual_login_controller.error();

            Fluttertoast.showToast(
              msg: 'Quelque chose s\'est mal passé.',
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 14.0,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
            );


            Timer(Duration(seconds: 2), () {
              manual_login_controller.reset();
            });

          }

        }

      }
      else{
        manual_login_controller.error();

        Fluttertoast.showToast(
          msg: 'Quelque chose s\'est mal passé.',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );


        Timer(Duration(seconds: 2), () {
          manual_login_controller.reset();
        });


      }
    }


  }



}

class FirebaseAuthForgotPasswordController{
  TextEditingController emailController = TextEditingController();

  final _firebaseAuth = FirebaseAuth.instance;
  RoundedLoadingButtonController forgotPasswordController = RoundedLoadingButtonController();

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: emailController.text);

      Fluttertoast.showToast(
        msg: 'Email de réinitialisation du mot de passe envoyé',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );

      forgotPasswordController.success();

      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });

    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Échec de l\'envoi de l\'email de réinitialisation du mot de passe',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );

      forgotPasswordController.error();

      Timer(Duration(seconds: 2), () {
        forgotPasswordController.reset();
      });
    }
  }
}

class AppleLogin{
  AppleLogin();

  RoundedLoadingButtonController continue_with_apple_controller = RoundedLoadingButtonController();

  //Firebase authentication with google
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AppleAuthProvider _appleSignIn = AppleAuthProvider();

  Future<UserCredential?> signInWithApple() async {
    try {

      return await FirebaseAuth.instance.signInWithProvider(_appleSignIn);

    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }


  void appleLogin(BuildContext context) async {

   final UserCredential? user = await signInWithApple();


    print("User =>");
    print(user);

    if (user != null) {

      final url = Uri.parse(Api.registerApi);
      print("Api: ${Api.registerApi}");

      UserAuth authUserBody = UserAuth(name: user.user?.displayName, email: user.user?.email);
      print(authUserBody.body());
      final response = await post(url, body: authUserBody.body());
      print('Status code: ${response.statusCode}');
      print('Body: ${response.statusCode}');

      var data = UserAuth.resp(json.decode(response.body));

      //fcm id


      if(response.statusCode == 200){
        if(data.status == "Wrong Credentials"){
          //Error  occured

          continue_with_apple_controller.error();



          Fluttertoast.showToast(
            msg: 'Quelque chose s\'est mal passé.',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );

          Timer(Duration(seconds: 2), () {
            continue_with_apple_controller.reset();
          });
        }

        if(data.status == "user" || (data.user != null && data.user == "user")){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(data.token!);
          prefs.setString('token', data.token!);

          var fcm_id_response = await ApiPostCalls.postApiResponse(Api.fcmIdApi, {"fcmid": await getFcmId()});

          var userInfo_response = await ApiGetCalls.getApiResponse(Api.userInfoApi);

          if(userInfo_response.statusCode == 200){
            var userInfo = json.decode(userInfo_response.body);

            continue_with_apple_controller.success();

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

              String redirectPage ="";
              redirectPage = (prefs.getString('redirectPage')??'');
              print(redirectPage);

              if(redirectPage =="goToPage"){
                Navigator.of(context)
                    .pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          AddToCartPage()),
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

                continue_with_apple_controller.error();

                Fluttertoast.showToast(
                  msg: 'Quelque chose s\'est mal passé.',
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 14.0,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                );

                Timer(Duration(seconds: 2), () {
                  continue_with_apple_controller.reset();
                });

              }
              else{
                print("User not logged out");

                continue_with_apple_controller.error();

                Fluttertoast.showToast(
                  msg: 'Quelque chose s\'est mal passé.',
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 14.0,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                );

                Timer(Duration(seconds: 2), () {
                  continue_with_apple_controller.reset();
                });
              }


            }
            catch (e) {
              print('Error signing out: $e');

              continue_with_apple_controller.error();

              Timer(Duration(seconds: 3),
                      () async {
                    continue_with_apple_controller.reset();
                  });
            }




          }

        }

        if(data.status == "admin"){
          continue_with_apple_controller.error();

          Fluttertoast.showToast(
            msg: 'Quelque chose s\'est mal passé.',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );

          Timer(Duration(seconds: 2), () {
            continue_with_apple_controller.reset();
          });

        }


      }
      else{
        continue_with_apple_controller.error();

        Fluttertoast.showToast(
          msg: 'Quelque chose s\'est mal passé.',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );


        Timer(Duration(seconds: 2), () {
          continue_with_apple_controller.reset();

        });


      }
    }
    else {
      Timer(Duration(seconds: 2), () {
        continue_with_apple_controller.error();

        Fluttertoast.showToast(
          msg: 'Échec de la connexion avec Google',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );

        continue_with_apple_controller.reset();
      });
    }
  }
}
