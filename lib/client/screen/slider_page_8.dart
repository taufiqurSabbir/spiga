import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/const.dart';
import '../../flutterLocalNotification/FlutterLocalNotification.dart';
import '../controllar/tutorial_steps_controller.dart';
import 'choisir_votre_client.dart';

class SliderPage extends StatefulWidget {
  final bool isGuest;

  SliderPage({this.isGuest = false});

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final TutorialStepsController controller_tutorial_controller =
      Get.put(TutorialStepsController());

  CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    FlutterLocalNotification.initializeLocalNotifications();

    controller_tutorial_controller.getTutorialSteps();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() => controller_tutorial_controller.showLoader.value == true
        ? loaderSquareWithWhiteBackground
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(0.0),
                child: AppBar(
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xff209602),
                  ),
                )),
            body: Stack(
              children: [
                SizedBox(
                    height: size.height / 1.50,
                    width: size.width,
                    child: Container(
                        color: Colors.black,
                        child: CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              height: size.height / 1.50,
                              viewportFraction: 1.01,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                controller_tutorial_controller.current.value =
                                    index;
                                print("index => ${index}");
                                if (index == 2) {
                                  controller_tutorial_controller
                                      .buttonText.value = "Finir";
                                } else {
                                  controller_tutorial_controller
                                      .buttonText.value = "Suivant";
                                }
                              }),
                          items: controller_tutorial_controller.images.value
                              .map((item) => Container(
                                    child: Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                      width: size.width + 10,
                                    ),
                                  ))
                              .toList(),
                        ))),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(
                    "image/concept_page.svg",
                    fit: BoxFit.cover,
                    height: size.height / 1.6,
                    width: size.width + 77,
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: size.height / 3,
                    width: size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: controller_tutorial_controller.images.value
                              .asMap()
                              .entries
                              .map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  _carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Color(0xff209602))
                                        .withOpacity(
                                            controller_tutorial_controller
                                                        .current.value ==
                                                    entry.key
                                                ? 0.9
                                                : 0.2)),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          "${controller_tutorial_controller.titles.value[controller_tutorial_controller.current.value]}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Color(0xff23233C).withOpacity(1),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // TextStyle(color: Color(0xff23233C).withOpacity(1),
                          //     fontWeight: FontWeight.bold,fontSize: 25),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: Text(
                            "${controller_tutorial_controller.subtitles.value[controller_tutorial_controller.current.value]}",
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            // style: TextStyle(color: Color(0xffA5A5A5).withOpacity(1),
                            //     fontWeight: FontWeight.bold,fontSize: 12),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Color(0xffA5A5A5).withOpacity(1),
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 15),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Choisir_Scren_Client()),
                                          (route) =>
                                              false, // This condition ensures all pages are removed from the stack
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          // color: Colors.grey.withOpacity(0.2)
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Passer",
                                            style: TextStyle(
                                                color: Color(0xffB4B4B4)),
                                          ),
                                        ),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        if (controller_tutorial_controller
                                            .images.value.isNotEmpty) {
                                          if (controller_tutorial_controller
                                                  .buttonText.value ==
                                              "Finir") {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Choisir_Scren_Client(
                                                          isGuest: true)),
                                              (route) =>
                                                  false, // This condition ensures all pages are removed from the stack
                                            );
                                          } else if (controller_tutorial_controller
                                                  .buttonText.value ==
                                              "Suivant") {
                                            _carouselController.nextPage();
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 115,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Color(0xff209602)),
                                        child: Center(
                                          child: Text(
                                            "${controller_tutorial_controller.buttonText.value}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )

                // )
              ],
            )));
  }
}
