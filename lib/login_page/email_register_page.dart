import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/screen/slider_page_8.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laspigadoro/controller/auth_controllar.dart';

import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EmailRegisterPage extends StatefulWidget {
  EmailRegisterPage({Key? key}) : super(key: key);

  @override
  State<EmailRegisterPage> createState() => _EmailRegisterPageState();
}

class _EmailRegisterPageState extends State<EmailRegisterPage> {

  final ManualRegisterController _authServiceManual = ManualRegisterController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F8).withOpacity(1),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SvgPicture.asset("image/app-top-shape.svg",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width+10,
              ),
              Text("Enregistrer",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff209602).withOpacity(1),
                    fontWeight: FontWeight.bold,fontSize: 23),),

              // Padding(
              //     padding:  const EdgeInsets.only(top: 53,left: 22,right: 22),
              //     child:

              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Inserire il nome.';
                        }
                        return null;
                      },

                      cursorColor: Color(0xff209602).withOpacity(1),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: const Color(0xff060606),
                        fontWeight: FontWeight.bold,
                        height: 1.4166666666666667,
                      ),
                      controller: _authServiceManual.first_nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: "nome",


                        prefixIcon: InkWell(
                            child: new Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: new SizedBox(
                                height: 10,
                                child: Icon(Icons.perm_identity,color: Theme.of(context)
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
                                color: Color(0xff209602).withOpacity(0.5)),
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
              SizedBox(
                width: 300,
                child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Inserire il cognome';
                        }
                        return null;
                      },

                      cursorColor: Color(0xff209602).withOpacity(1),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: const Color(0xff060606),
                        fontWeight: FontWeight.bold,
                        height: 1.4166666666666667,
                      ),
                      controller: _authServiceManual.last_nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: "cognome",


                        prefixIcon: InkWell(
                            child: new Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: new SizedBox(
                                height: 10,
                                child: Icon(Icons.perm_identity,color: Theme.of(context)
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
                                color: Color(0xff209602).withOpacity(0.5)),
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
              SizedBox(
                width: 300,
                child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      cursorColor: Color(0xff209602).withOpacity(1),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: const Color(0xff060606),
                        fontWeight: FontWeight.bold,
                        height: 1.4166666666666667,
                      ),
                      controller: _authServiceManual.emailController,
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
                                color: Color(0xff209602).withOpacity(0.5)),
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

              SizedBox(
                width: 300,
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: _authServiceManual.passwordController,
                    cursorColor: Color(0xff209602).withOpacity(1),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: const Color(0xff060606),
                      fontWeight: FontWeight.bold,
                      height: 1.4166666666666667,
                    ),
                    obscureText: _obscureText1, // set the obscureText property to the boolean value
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      labelText: "Mot de passe",
                      prefixIcon: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: SizedBox(
                            height: 10,
                            child: Icon(
                              Icons.key,
                              color: Theme.of(context).focusColor.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText1 ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).focusColor.withOpacity(0.2),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText1 = !_obscureText1; // toggle the boolean value
                          });
                        },
                      ),
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Theme.of(context).focusColor.withOpacity(0.2),
                        fontWeight: FontWeight.w300,
                        height: 1.4166666666666667,
                      ),
                      fillColor: Color(0xffF1F2EF),
                      filled: true,
                      hintText: "Asdasd123!",
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: const Color(0xccb5b5b5),
                        fontWeight: FontWeight.w300,
                        height: 1.4166666666666667,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).focusColor.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff209602).withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).focusColor.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),

              // SizedBox(
              //   width: 300,
              //   child: Align(
              //       alignment: Alignment.center,
              //       child: TextFormField(
              //         cursorColor: Color(0xff44680E).withOpacity(1),
              //         style: TextStyle(
              //           fontFamily: 'Poppins',
              //           fontSize: 12,
              //           color: const Color(0xff060606),
              //           fontWeight: FontWeight.bold,
              //           height: 1.4166666666666667,
              //         ),
              //         controller: _authServiceManual.passwordController,
              //         obscureText: true,
              //         enableSuggestions: false,
              //         autocorrect: false,
              //         decoration: InputDecoration(
              //           contentPadding: const EdgeInsets.all(8.0),
              //           labelText: "Password",
              //
              //
              //           prefixIcon: InkWell(
              //               child: new Padding(
              //                 padding: const EdgeInsets.all(11.0),
              //                 child: new SizedBox(
              //                   height: 10,
              //                   child: Icon(Icons.key,color: Theme.of(context)
              //                       .focusColor
              //                       .withOpacity(0.2)),
              //                 ),
              //               )),
              //           labelStyle:  TextStyle(
              //             fontFamily: 'Poppins',
              //             fontSize: 12,
              //             color: Theme.of(context)
              //                 .focusColor
              //                 .withOpacity(0.2),
              //             fontWeight: FontWeight.w300,
              //             height: 1.4166666666666667,
              //           ),
              //           fillColor:Color(0xffF1F2EF),
              //           filled: true,
              //           hintText: "Asdasd123!",
              //           hintStyle: const TextStyle(
              //             fontFamily: 'Poppins',
              //             fontSize: 12,
              //             color: const Color(0xccb5b5b5),
              //             fontWeight: FontWeight.w300,
              //             height: 1.4166666666666667,
              //           ),
              //           border: OutlineInputBorder(
              //               borderSide: BorderSide(
              //                   color: Theme.of(context)
              //                       .focusColor
              //                       .withOpacity(0.2)),
              //               borderRadius: BorderRadius.circular(20.0)),
              //           focusedBorder: OutlineInputBorder(
              //               borderSide: BorderSide(
              //                   color: Color(0xff44680E).withOpacity(0.5)),
              //               borderRadius: BorderRadius.circular(20.0)),
              //           enabledBorder: OutlineInputBorder(
              //               borderSide: BorderSide(
              //                   color: Theme.of(context)
              //                       .focusColor
              //                       .withOpacity(0.2)),
              //               borderRadius: BorderRadius.circular(20.0)),
              //         ),
              //       )
              //   ),
              // ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      cursorColor: Color(0xff209602).withOpacity(1),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: const Color(0xff060606),
                        fontWeight: FontWeight.bold,
                        height: 1.4166666666666667,
                      ),
                      controller: _authServiceManual.confirmPasswordController,
                      obscureText: _obscureText2,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: "Confirmez le mot de passe",


                        prefixIcon: InkWell(
                            child: new Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: new SizedBox(
                                height: 10,
                                child: Icon(Icons.key,color: Theme.of(context)
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
                        hintText: "Asdasd123!",
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: const Color(0xccb5b5b5),
                          fontWeight: FontWeight.w300,
                          height: 1.4166666666666667,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText2 ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).focusColor.withOpacity(0.2),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText2 = !_obscureText2; // toggle the boolean value
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(20.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff209602).withOpacity(0.5)),
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
              SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: _authServiceManual.checkvalue,
                            side: BorderSide(color: Color(0xff44680E45)),
                            checkColor: whiteTextColor,
                            fillColor:MaterialStatePropertyAll(mainTextColorwithOpachity),
                            onChanged: (va){

                              setState(() {
                                _authServiceManual.checkvalue =va!;
                              });

                            }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width:250,  //give a width of your choice
                        child: Text('J\'autorise que La Bottega sauvegarde mon email ainsi que mes informations personnelles',
                          // overflow:TextOverflow.ellipsis,
                        ),
                      )
                      // Text(
                      //     'J\'autorise que La Bottega sauvegarde mon email ainsi  que mes informations personnelles',
                      //     overflow: TextOverflow.fade,
                      //     maxLines: 1,
                      //     softWrap: false
                      // )
                      // Text("J'autorise que La Bottega sauvegarde mon email ainsi  que mes informations personnelles", overflow: TextOverflow.ellipsis)
                    ],
                  )
              ),


              SizedBox(height: 37.01,),

              RoundedLoadingButton(
                elevation: 0,
                width: 270,
                color: mainTextColor,
                successIcon: Icons.check,
                failedIcon: Icons.close,
                valueColor: Colors.white,
                successColor: Colors.green,
                controller: _authServiceManual.manual_reg_controller,
                onPressed: (){
                  // if (!formkey.currentState!.validate()) {
                  //   return;
                  // }
                  _authServiceManual.register(context);
                },
                borderRadius: 260,
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color:Color(0xff209602),
                      borderRadius: BorderRadius.circular(260)
                  ),
                  child:Center(child: Text("Continuer",style: TextStyle(color: Colors.white),),),
                ),
              ),
              SizedBox(height: 10,),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(Icons.arrow_back),
                    SizedBox(width: 5,),
                    Text("Retour"),
                  ],
                ),
              )






              // Padding(
              //   padding: const EdgeInsets.only(left: 22,right: 22),
              //   child: InkWell(
              //     onTap: (){
              //       // controllar.emailLogin(context);
              //
              //       //Navigator.push(context, MaterialPageRoute(builder: (_)=>SliderPage()));
              //     },
              //     // child:checkvalue ? Container(
              //     //
              //     //   width: 358.86,
              //     //   height:53.31 ,
              //     //   decoration: BoxDecoration(
              //     //     borderRadius: BorderRadius.circular(123),
              //     //     color: Color(0xff44680E)
              //     //   ),
              //     //   child:Obx(() => controllar.loder.value?Center(child: CircularProgressIndicator(),): Center(child: Text("Continuer",style: TextStyle(color: Colors.white),),),)
              //     //
              //     // ):
              //
              //     child: Container(
              //
              //       width: 358.86,
              //       height:53.31 ,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(123),
              //           color: Color(0xff44680E)
              //       ),
              //       child: Center(child: Text("Continuer",style: TextStyle(color: Colors.white),),),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),


    );
  }
}
