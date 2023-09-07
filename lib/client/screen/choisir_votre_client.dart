import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laspigadoro/const/const.dart';

import 'package:sizer/sizer.dart';

import '../../flutterLocalNotification/FlutterLocalNotification.dart';
import '../controllar/choisir_votre_client_controller.dart';
import 'home_page.dart';

class Choisir_Scren_Client extends StatefulWidget {
  final bool isGuest;

  Choisir_Scren_Client({Key? key, this.isGuest = false}) : super(key: key);

  @override
  State<Choisir_Scren_Client> createState() => _Choisir_Scren_ClientState();
}

class _Choisir_Scren_ClientState extends State<Choisir_Scren_Client> {
  final ChoisirVotreClientController controller_choisirVotreAdmin =
      Get.put(ChoisirVotreClientController());

  @override
  void initState() {
    super.initState();
    FlutterLocalNotification.initializeLocalNotifications();

    controller_choisirVotreAdmin.getBoutique();
    updateTutorialSteps();
  }

  updateTutorialSteps() async {
    if (widget.isGuest == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('tutorial_steps_for_guest', '1');
    } else {
      controller_choisirVotreAdmin.updateTutorialStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller_choisirVotreAdmin.showLoader.value == true
        ? loaderSquare
        : Scaffold(
            body: Column(
              children: [
                SvgPicture.asset(
                  "image/app-top-shape.svg",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width + 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SvgPicture.asset(
                    "image/Groupe 16373.svg",
                    height: 137,
                    width: 239,
                  ),
                ),
                (() {
                  if (controller_choisirVotreAdmin.showLoader.value == true) {
                    return loaderSquare;
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Choisir votre",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 23,
                                          color: Color(0xff23233C)))),
                              TextSpan(
                                  text: " Boutique",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff209602))))
                            ]),
                          ),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller_choisirVotreAdmin
                                .boutiqueArray.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  index == 0
                                      ? SizedBox(
                                          height: 32,
                                        )
                                      : SizedBox(
                                          height: 22,
                                        ),
                                  InkWell(
                                    onTap: () async {
                                      //I am storing  store id (boutique_name) in Share Preferred
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'saved_boutique_id',
                                          controller_choisirVotreAdmin
                                              .boutiqueArray[index].id
                                              .toString());
                                      prefs.setString(
                                          'saved_boutique_name',
                                          controller_choisirVotreAdmin
                                              .boutiqueArray[index]
                                              .boutiqueName!);
                                      prefs.setString(
                                          'saved_boutique_address',
                                          controller_choisirVotreAdmin
                                              .boutiqueArray[index].address!);

                                      prefs.setString(
                                          'saved_boutique_opening_time',
                                          controller_choisirVotreAdmin
                                              .boutiqueArray[index].openedAt!);
                                      prefs.setString(
                                          'saved_boutique_closing_time',
                                          controller_choisirVotreAdmin
                                              .boutiqueArray[index].closedAt!);

                                      //This  will  change
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePageClient(
                                                  boutique_id:
                                                      controller_choisirVotreAdmin
                                                          .boutiqueArray[index]
                                                          .boutiqueName!)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 47, right: 47),
                                      child: Container(
                                          height: 54,
                                          width: 336.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5)),
                                            color: Color(0xff209602)
                                                .withOpacity(1),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "${controller_choisirVotreAdmin.boutiqueArray[index].boutiqueName}",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xfFFFFFF)
                                                        .withOpacity(1))),
                                          ))),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    );
                  }
                }())
              ],
            ),
          ));
  }
}
