import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laspigadoro/client/model/Food.dart';
import 'package:laspigadoro/const/const.dart';
import 'package:laspigadoro/client/widget/paiement_textfild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laspigadoro/login_page/login_page.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:time_picker_widget/time_picker_widget.dart';

import '../../custom_time_picker.dart';
import '../../dialogue/Dialogue.dart';
import '../../helper/helper_function.dart';
import '../../sharePreference/sharePreference_getSelectedStoreDetails.dart';
import '../controllar/cart_controller.dart';
import '../controllar/food_stock_controller.dart';
import 'we_are_preparing_your_order.dart';
import 'home_page.dart';
import 'paiement_valider_page.dart';

class AddToCartPage extends StatefulWidget {
  AddToCartPage({Key? key}) : super(key: key);

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  Map<String, dynamic>? paymentIntent;

  TextEditingController numero_de_la_Controllar = TextEditingController();
  TextEditingController date_expirationControllar = TextEditingController();
  TextEditingController titulaireDeLa_Carte_Controllar =
      TextEditingController();
  TextEditingController cvc_cvv_Controllar = TextEditingController();

  final CartController controller_cartController = Get.put(CartController());
  final FoodStockController controller_foodStockController =
      Get.put(FoodStockController());

  @override
  void initState() {
    super.initState();

    controller_cartController.loadData();
    controller_cartController.payment_status.value = null;
    controller_foodStockController
        .getFoodStock(controller_cartController.food_id.value);
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
  //   super.dispose();
  // }
  //
  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   switch (state) {
  //     case AppLifecycleState.detached:
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString('redirectPage', 'notGoToPage');
  //       break;
  //   }
  // }

  var checkvalue = false;

  var changeButtonColor = true;
  onChangeIcon() {
    setState(() {
      changeButtonColor = !changeButtonColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() => controller_foodStockController.showLoader.value == true
        ? loaderSquareWithWhiteBackground
        : Scaffold(
            bottomNavigationBar: controller_cartController.quantity.value == 0
                ? SizedBox()
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 19, right: 19, bottom: 19),
                    child: Container(
                      height: 54,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff202124)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 19, right: 19),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Total  ",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor))),
                              TextSpan(
                                  text:
                                      "${HelperFunction.stringToCurrency(controller_cartController.totalPrice.toString(), "€")}",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: whiteTextColor)))
                            ])),
                            InkWell(
                              onTap: () {
                                //Normal
                                // widget.controller_cartController.saveInSharePreffered(widget.targetedFood.id.toString(), "", "", widget.targetedFood.foodImage.toString(), widget.targetedFood.foodName.toString(), widget.targetedFood.pickupTimeFrom.toString()+" - "+widget.targetedFood.pickupTimeTo.toString());
                                // showBottomSheet();
                                showBottomSheetChoosePickUpTime();

                                //nO FOOD IN THE STOCK
                                // paiementFailedBottomSheet();
                              },
                              child: Container(
                                  height: 34,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: mainTextColor,
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  child: Center(
                                    child: Text("Payer",
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: whiteTextColor))),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
            backgroundColor: Color(0xffF9F9F8).withOpacity(1),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: whiteTextColor,
              elevation: 0,
              leading: Padding(
                padding: EdgeInsets.all(12.0),
                child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String _redirectPage = "";
                      _redirectPage = (prefs.getString('redirectPage') ?? '');
                      print(_redirectPage);

                      if (_redirectPage == "goToPage") {
                        print("----------------");

                        print(_redirectPage);
                        //   Get.close(1);
                        Navigator.removeRoute(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 2,
                      width: 2,
                      decoration: BoxDecoration(
                          color: Color(0xff209602).withOpacity(1),
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Center(
                            child: Icon(
                          Icons.arrow_back_ios,
                          size: 14,
                          color: Color(0xffffffff).withOpacity(1),
                        )),
                      ),
                    )),
              ),

              // GestureDetector(
              //     onTap: (){
              //       Navigator.pop(context);
              //     },
              //     child: Container(
              //       height: 2,
              //       width: 2,
              //       decoration: BoxDecoration(
              //           color: Color(0xff209602).withOpacity(1),
              //           borderRadius: BorderRadius.circular(100)
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 0),
              //         child: Center(
              //             child: Icon(
              //               Icons.arrow_back_ios,
              //               size:9,
              //               color: Color(0xffffffff).withOpacity(1),
              //             )),
              //       ),
              //     )
              // ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "image/button_icon/shopping-basket.svg",
                    height: 22,
                    width: 20,
                    color: mainTextColorwithOpachity,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Mon Panier",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0C0E10).withOpacity(1))))
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "image/button_icon/Groupe 16381.svg",
                      height: 25,
                      width: 25,
                    ),
                  ),
                )
              ],
            ),
            body: controller_cartController.quantity.value == 0
                ? Center(
                    child: Image.asset(
                      'image/empty_cart.png', // Update the file path to point to your PNG asset
                    ),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(color: whiteTextColor),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  child: Image(
                                    image: NetworkImage(
                                      "${controller_cartController.thumbnail_image.value}",
                                    ),
                                    fit: BoxFit.cover,
                                    height: 81 * 1.2,
                                    width: 82 * 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                          "${controller_cartController.food_name.value}",
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff000000)
                                                      .withOpacity(1)))),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (controller_cartController
                                                          .quantity.value ==
                                                      1) {
                                                    controller_cartController
                                                        .getTotalPrice();
                                                    //widget.controller_cartController.saveInSharePreffered(widget.targetedFood.id.toString(), "", "", widget.targetedFood.foodImage.toString(), widget.targetedFood.foodName.toString(), widget.targetedFood.pickupTimeFrom.toString()+" - "+widget.targetedFood.pickupTimeTo.toString());

                                                    return;
                                                  }

                                                  controller_cartController
                                                      .quantity.value--;
                                                  controller_cartController
                                                      .getTotalPrice();
                                                  //widget.controller_cartController.saveInSharePreffered(widget.targetedFood.id.toString(), "", "", widget.targetedFood.foodImage.toString(), widget.targetedFood.foodName.toString(), widget.targetedFood.pickupTimeFrom.toString()+" - "+widget.targetedFood.pickupTimeTo.toString());
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color:
                                                              mainTextColorwithOpachity)),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.remove,
                                                    size: 18,
                                                    color:
                                                        mainTextColorwithOpachity,
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     style: ButtonStyle(
                                              //       side: MaterialStateProperty.all(
                                              //         BorderSide(width: 7,color: Colors.black12)
                                              //       )
                                              //     ),
                                              //     color: mainTextColorwithOpachity,
                                              //     icon: Icon(
                                              //       Icons.remove,
                                              //       size: 32,
                                              //       color: mainTextColorwithOpachity,
                                              //     )),
                                              Text(
                                                  "${controller_cartController.quantity.value}",
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              mainTextColorwithOpachity))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (controller_cartController
                                                          .quantity.value ==
                                                      controller_foodStockController
                                                          .foodStock) {
                                                    controller_cartController
                                                        .getTotalPrice();
                                                    return;
                                                  }

                                                  controller_cartController
                                                      .quantity.value++;
                                                  controller_cartController
                                                      .getTotalPrice();
                                                  //widget.controller_cartController.saveInSharePreffered(widget.targetedFood.id.toString(), "", "", widget.targetedFood.foodImage.toString(), widget.targetedFood.foodName.toString(), widget.targetedFood.pickupTimeFrom.toString()+" - "+widget.targetedFood.pickupTimeTo.toString());
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          mainTextColorwithOpachity,
                                                      border: Border.all(
                                                          color:
                                                              mainTextColorwithOpachity)),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.add,
                                                    size: 18,
                                                    color: whiteTextColor,
                                                  )),
                                                ),
                                              ),
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     icon: Icon(
                                              //       Icons.add_circle,
                                              //       size: 32,
                                              //       color:
                                              //           mainTextColorwithOpachity,
                                              //     )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(""),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            "${HelperFunction.stringToCurrency(controller_cartController.totalPrice.toString(), "€")}",
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        mainTextColorwithOpachity))),
                                        GestureDetector(
                                          onTap: () {
                                            Dialogs.bottomMaterialDialog(
                                                color: bottomShetColor,
                                                msg:
                                                    'Êtes vous sure de vouloir supprimer votre panier?',
                                                msgStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                                title: 'Supprimer',
                                                titleStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                context: context,
                                                actions: [
                                                  IconsOutlineButton(
                                                    color: mainTextColor,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    text: 'Annuler',
                                                    iconData:
                                                        Icons.cancel_outlined,
                                                    textStyle: TextStyle(
                                                        color: Colors.white),
                                                    iconColor: Colors.white,
                                                  ),
                                                  IconsButton(
                                                    onPressed: () async {
                                                      controller_cartController
                                                          .reset();

                                                      Navigator.pop(context);

                                                      final String? store_id =
                                                          await getStoreId();

                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomePageClient(
                                                                    boutique_id:
                                                                        store_id!)),
                                                        (route) =>
                                                            false, // This condition ensures all pages are removed from the stack
                                                      );

                                                      Fluttertoast.showToast(
                                                        msg:
                                                            'Votre panier est maintenant vide',
                                                        toastLength:
                                                            Toast.LENGTH_LONG,
                                                        fontSize: 14.0,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.green,
                                                      );
                                                    },
                                                    text: 'Supprimer',
                                                    iconData: Icons.delete,
                                                    color: Colors.red,
                                                    textStyle: TextStyle(
                                                        color: Colors.white),
                                                    iconColor: Colors.white,
                                                  ),
                                                ]);
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 12,
                                              ),
                                              SvgPicture.asset(
                                                "image/button_icon/trashfile.svg",
                                                height: 18,
                                                width: 12,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10)
                              ],
                            ),
                          ),
                        )),
                  ))));
  }

  void showBottomSheetChoosePickUpTime() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext context) {
          return Obx(() => Container(
                height: 350,
                decoration: BoxDecoration(
                    color: bottomShetColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15, right: 16),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            height: 27,
                            width: 27,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: mainTextColorwithOpachity),
                            child: Center(
                                child: Icon(
                              Icons.clear_rounded,
                              size: 15,
                              color: whiteTextColor,
                            )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Choisir l\'heure de récupération",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: whiteTextColor))),

                    SizedBox(
                      height: 10,
                    ),

                    Divider(
                      height: 15,
                      thickness: 3,
                      endIndent: 160,
                      indent: 160,
                      color: mainTextColorwithOpachity,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: whiteTextColor,
                                size: 18,
                              ),
                              SizedBox(
                                  width:
                                      8), // You can adjust this value to change the space between the icon and the text
                              Text(
                                'Pick up date',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: whiteTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height:
                                10), // Optional spacing between the text and date
                        Center(
                          child: Text(
                              '${HelperFunction.convertDateFormatWithYear(controller_cartController.pickUp_date.value)}${HelperFunction.getTodayTomorrowOrNull(controller_cartController.pickUp_date.value)}', // Replace with your date variable
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: whiteTextColor))),
                        ),
                      ],
                    ),

                    //Pichup Hour
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Pick up Horaire",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  side: MaterialStatePropertyAll(
                                      BorderSide(color: Color(0xff5B5B5B)))),
                              onPressed: () async {
                                print(controller_cartController
                                    .pickUp_time.value);

                                int start_pickUpTime_hour = int.parse(
                                    (controller_cartController.pickUp_time.value
                                            .split('-')[0]
                                            .trim())
                                        .split(':')[0]
                                        .trim());
                                int start_pickUpTime_minute = int.parse(
                                    (controller_cartController.pickUp_time.value
                                            .split('-')[0]
                                            .trim())
                                        .split(':')[1]
                                        .trim());
                                int end_pickUpTime_hour = int.parse(
                                    (controller_cartController.pickUp_time.value
                                            .split('-')[1]
                                            .trim())
                                        .split(':')[0]
                                        .trim());
                                int end_pickUpTime_minute = int.parse(
                                    (controller_cartController.pickUp_time.value
                                            .split('-')[1]
                                            .trim())
                                        .split(':')[1]
                                        .trim());

                                TimeOfDay _selectedTime = TimeOfDay(
                                    hour: start_pickUpTime_hour,
                                    minute: start_pickUpTime_minute);

                                final TimeOfDay? picked =
                                    await myShowTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                  helpText: "Sélectionner l'heure",
                                  cancelText: "Annuler",
                                  confirmText: "D'accord",
                                  allowTimeFrom: controller_cartController
                                      .pickUp_time.value
                                      .split('-')[0]
                                      .trim(),
                                  allowTimeTo: controller_cartController
                                      .pickUp_time.value
                                      .split('-')[1]
                                      .trim(),
                                );
                                if (picked != null && picked != _selectedTime) {
                                  String timeString =
                                      '${picked.hour.toString()}:${picked.minute.toString()}';

                                  controller_cartController
                                      .customer_pickUp_time_from
                                      .value = timeString;
                                  controller_cartController
                                      .customer_pickUp_time_to
                                      .value = timeString;
                                }
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "image/clock (1).svg",
                                    height: 20,
                                    width: 20,
                                    color: whiteTextColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                      controller_cartController
                                                  .customer_pickUp_time_from
                                                  .value ==
                                              ""
                                          ? "choisissez une heure"
                                          : controller_cartController
                                              .customer_pickUp_time_from.value,
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: whiteTextColor))),
                                ],
                              )),
                          SizedBox(width: 10),
                          // Expanded(
                          //   child: TextButton(
                          //       style: ButtonStyle(
                          //           side: MaterialStatePropertyAll(
                          //               BorderSide(
                          //                   color: Color(0xff5B5B5B)
                          //               )
                          //           )
                          //       ),
                          //       onPressed: () async {
                          //         print(controller_cartController.pickUp_time.value);
                          //
                          //         int start_pickUpTime_hour = int.parse((controller_cartController.pickUp_time.value.split('-')[0].trim()).split(':')[0].trim());
                          //         int start_pickUpTime_minute = int.parse((controller_cartController.pickUp_time.value.split('-')[0].trim()).split(':')[1].trim());
                          //         int end_pickUpTime_hour = int.parse((controller_cartController.pickUp_time.value.split('-')[1].trim()).split(':')[0].trim());
                          //         int end_pickUpTime_minute = int.parse((controller_cartController.pickUp_time.value.split('-')[1].trim()).split(':')[1].trim());
                          //
                          //
                          //         showCustomTimePicker(
                          //             context: context,
                          //             // It is a must if you provide selectableTimePredicate
                          //             onFailValidation: (context) {
                          //               AwesomeDialog(
                          //                 context: context,
                          //                 dialogType: DialogType.error,
                          //                 animType: AnimType.rightSlide,
                          //                 headerAnimationLoop: false,
                          //                 title: 'Oops!',
                          //                 desc:
                          //                 'Sélection non disponible',
                          //                 btnOkOnPress: () {},
                          //                 btnOkIcon: Icons.cancel,
                          //                 btnOkColor: Colors.red,
                          //               ).show();
                          //             },
                          //             initialTime: TimeOfDay(hour: end_pickUpTime_hour, minute: end_pickUpTime_minute),
                          //             selectableTimePredicate: (time) {
                          //
                          //               if (time!.hour == start_pickUpTime_hour) {
                          //                 return time.minute >= start_pickUpTime_minute;
                          //               }
                          //               else if (time.hour == end_pickUpTime_hour) {
                          //                 return time.minute <= end_pickUpTime_minute;
                          //               }
                          //               else {
                          //                 return time.hour > start_pickUpTime_hour-1 &&
                          //                     time.hour < end_pickUpTime_hour+1 &&
                          //                     time.minute < 61;
                          //               }
                          //             }).then((time) {
                          //           controller_cartController.customer_pickUp_time_to.value  = HelperFunction.convertTo24HourFormat(time!.format(context));
                          //         });
                          //
                          //
                          //       },
                          //       child: Row(
                          //         children: [
                          //           SvgPicture.asset("image/clock (1).svg",height: 20,width: 20,color: whiteTextColor,),
                          //           SizedBox(width: 10),
                          //           Text(controller_cartController.customer_pickUp_time_to.value == "" ? "Jusqu'à" : controller_cartController.customer_pickUp_time_to.value,
                          //               style: GoogleFonts.openSans(
                          //                   textStyle: TextStyle(
                          //                       fontSize: 12,
                          //                       fontWeight: FontWeight.bold,
                          //                       color: whiteTextColor))),
                          //         ],
                          //       )
                          //
                          //
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    //Ok button
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Add your onPressed function here
                              if (controller_cartController
                                          .customer_pickUp_time_from.value !=
                                      "" ||
                                  controller_cartController
                                          .customer_pickUp_time_to.value !=
                                      "") {
                                controller_cartController.customer_pickUp_time
                                    .value = controller_cartController
                                        .customer_pickUp_time_from.value +
                                    " - " +
                                    controller_cartController
                                        .customer_pickUp_time_to.value;

                                Navigator.pop(context);

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                if (prefs.getString('isGuest') == '1') {
                                  showLoginBottomSheet();
                                } else {
                                  if (HelperFunction.isTimeInRangeFromRange(
                                              controller_cartController
                                                  .pickUp_time.value,
                                              controller_cartController
                                                  .customer_pickUp_time_from
                                                  .value) ==
                                          true &&
                                      HelperFunction.isTimeInRangeFromRange(
                                              controller_cartController
                                                  .pickUp_time.value,
                                              controller_cartController
                                                  .customer_pickUp_time_to
                                                  .value) ==
                                          true) {
                                    showBottomSheet();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please setect time  between range ${controller_cartController.pickUp_time.value}",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.SNACKBAR,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 14.0);
                                  }
                                }
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Oops!',
                                  desc:
                                      'Veuillez sélectionner l\'heure de retrait',
                                  btnOkOnPress: () {},
                                ).show();
                              }
                            },
                            child: Text(
                              'Valider',
                              style: TextStyle(color: whiteTextColor),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: mainTextColorwithOpachity,
                              onSurface: mainTextColorwithOpachity,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // Adjust the value to control the roundness of the corners
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext context) {
          return Container(
            height: 400,
            decoration: BoxDecoration(
                color: bottomShetColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () {},
                //
                //   child: Icon(Icons.clear_rounded,size: 15,color: whiteTextColor,),
                //   style: ElevatedButton.styleFrom(
                //
                //     shape: CircleBorder(),
                //     o
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainTextColorwithOpachity),
                        child: Center(
                            child: Icon(
                          Icons.clear_rounded,
                          size: 15,
                          color: whiteTextColor,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Moyen de paiement",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor))),

                SizedBox(
                  height: 10,
                ),

                Divider(
                  height: 15,
                  thickness: 3,
                  endIndent: 160,
                  indent: 160,
                  color: mainTextColorwithOpachity,
                ),
                SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      //paiementParCarte_showBottomSheetdata(context);

                      //Stripe  payment

                      await makePayment();
                    },
                    child: Container(
                      height: 45,
                      width: 330,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: whiteTextColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "image/button_icon/credit-card-fill.svg",
                            height: 17,
                            width: 22,
                            color: mainTextColor,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Paiement par carte",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 40, right: 40),
                //   child: InkWell(
                //     onTap: () async {
                //       controller_cartController.payment_status.value = 0;
                //       Navigator.pop(context);
                //       if(controller_cartController.payment_status==0) {
                //
                //
                //         Dialogue.showLoadingDialog();
                //
                //         var response = await controller_cartController.placeOrderCash();
                //
                //         if (response.statusCode == 200) {
                //           var data = json.decode(response.body);
                //
                //           if (data["status"] == "Order created successfully") {
                //
                //             controller_cartController.payment_status.value = 0;
                //             controller_cartController.order_id.value = data["data"]["id"];
                //             controller_cartController.resetValuesAfterPayment();
                //
                //
                //             Get.offAll(
                //                   () => PrepearingFoodScreen(),
                //               transition: Transition.rightToLeft,
                //             );
                //           }
                //           else if (data["status"].contains('Out of Stock')){
                //             Fluttertoast.showToast(
                //               msg: 'En rupture de stock. Available  stock is ${HelperFunction.extractNumber(data["status"])}',
                //               toastLength: Toast.LENGTH_SHORT,
                //               fontSize: 14.0,
                //               gravity: ToastGravity.BOTTOM,
                //               backgroundColor: Colors.red,
                //             );
                //           }
                //           else {
                //             Fluttertoast.showToast(
                //               msg: 'Votre commande n\'a pas abouti, Veuillez réessayer à nouveau',
                //               toastLength: Toast.LENGTH_SHORT,
                //               fontSize: 14.0,
                //               gravity: ToastGravity.BOTTOM,
                //               backgroundColor: Colors.red,
                //             );
                //           }
                //         }
                //         else {
                //           Fluttertoast.showToast(
                //             msg: 'Une erreur s\'est produite. Veuillez réessayer à nouveau',
                //             toastLength: Toast.LENGTH_SHORT,
                //             fontSize: 14.0,
                //             gravity: ToastGravity.BOTTOM,
                //             backgroundColor: Colors.red,
                //           );
                //         }
                //       }
                //
                //     },
                //     child: Container(
                //       height: 45,
                //       width: 330,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(9),
                //           color: whiteTextColor),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset(
                //             "image/button_icon/cash-coin.svg",
                //             height: 17,
                //             width: 22,
                //             color: mainTextColor,
                //           ),
                //           SizedBox(
                //             width: 15,
                //           ),
                //           Text("Paiement en espèce",
                //               style: GoogleFonts.openSans(
                //                   textStyle: TextStyle(
                //                       fontSize: 15,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.black))),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 25,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 40, right: 40),
                //   child: InkWell(
                //     onTap: () async {
                //       controller_cartController.payment_status.value = 3;
                //
                //       Navigator.pop(context);
                //
                //       if(controller_cartController.payment_status==3) {
                //
                //
                //         Dialogue.showLoadingDialog();
                //
                //         var response = await controller_cartController.placeOrderTicket();
                //
                //         if (response.statusCode == 200) {
                //           var data = json.decode(response.body);
                //
                //           if (data["status"] == "Order created successfully") {
                //
                //             controller_cartController.payment_status.value = 3;
                //             controller_cartController.order_id.value = data["data"]["id"];
                //             controller_cartController.resetValuesAfterPayment();
                //
                //
                //             Get.offAll(
                //                   () => PrepearingFoodScreen(),
                //               transition: Transition.rightToLeft,
                //             );
                //           }
                //           else if (data["status"].contains('Out of Stock')){
                //             Fluttertoast.showToast(
                //               msg: 'En rupture de stock. Available  stock is ${HelperFunction.extractNumber(data["status"])}',
                //               toastLength: Toast.LENGTH_SHORT,
                //               fontSize: 14.0,
                //               gravity: ToastGravity.BOTTOM,
                //               backgroundColor: Colors.red,
                //             );
                //           }
                //
                //
                //           else {
                //             Fluttertoast.showToast(
                //               msg: 'Order Failed", "Your order has been failed',
                //               toastLength: Toast.LENGTH_SHORT,
                //               fontSize: 14.0,
                //               gravity: ToastGravity.BOTTOM,
                //               backgroundColor: Colors.red,
                //             );
                //           }
                //           // Perform any additional actions with the transaction ID, e.g., store it in your database
                //         }
                //         else {
                //           Fluttertoast.showToast(
                //             msg: 'Something went wrong", "Please try again later',
                //             toastLength: Toast.LENGTH_SHORT,
                //             fontSize: 14.0,
                //             gravity: ToastGravity.BOTTOM,
                //             backgroundColor: Colors.red,
                //           );
                //         }
                //       }
                //     },
                //     child: Container(
                //       height: 45,
                //       width: 330,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(9),
                //           color: whiteTextColor),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset(
                //             "image/button_icon/ticket_icon.svg",
                //             height: 17,
                //             width: 22,
                //             color: mainTextColor,
                //           ),
                //           SizedBox(
                //             width: 15,
                //           ),
                //           Text("Payer avec un chèque repas",
                //               style: GoogleFonts.openSans(
                //                   textStyle: TextStyle(
                //                       fontSize: 15,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.black))),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
  }

  void showLoginBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext context) {
          return Container(
            height: 400,
            decoration: BoxDecoration(
                color: bottomShetColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () {},
                //
                //   child: Icon(Icons.clear_rounded,size: 15,color: whiteTextColor,),
                //   style: ElevatedButton.styleFrom(
                //
                //     shape: CircleBorder(),
                //     o
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainTextColorwithOpachity),
                        child: Center(
                            child: Icon(
                          Icons.clear_rounded,
                          size: 15,
                          color: whiteTextColor,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Opps!!",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor))),

                SizedBox(
                  height: 10,
                ),

                Divider(
                  height: 15,
                  thickness: 3,
                  endIndent: 160,
                  indent: 160,
                  color: mainTextColorwithOpachity,
                ),
                SizedBox(
                  height: 30,
                ),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "image/happy_face.svg",
                          width: 75,
                          height: 75,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                          "Vous devez vous connecter pour acheter de la nourriture, afin que nous puissions suivre votre commande",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor))),
                    ),
                    SizedBox(height: 60),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('isGuest', '0');

                              prefs.setString('redirectPage', 'goToPage');

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Text(
                              'Connexion',
                              style: TextStyle(color: whiteTextColor),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: mainTextColorwithOpachity,
                              onSurface: mainTextColorwithOpachity,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // Adjust the value to control the roundness of the corners
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  paiementParCarte_showBottomSheetdata(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(21), topLeft: Radius.circular(21))),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Container(
              height: 474,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff202124),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 31, top: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff209602)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 15.39,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        Text(
                          "Carte de paiement",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    height: 15,
                    thickness: 3,
                    endIndent: 160,
                    indent: 160,
                    color: mainTextColorwithOpachity,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: TextField(
                      controller: numero_de_la_Controllar,
                      cursorColor: Color(0xff209602),
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffffffff).withOpacity(0.009),
                          hintText: "Numéro de la carte",
                          hintStyle: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 13, color: Color(0xffC7C7C7))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide:
                                  BorderSide(color: Color(0xff4B4B4B78))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide:
                                  BorderSide(color: Color(0xff4B4B4B78))),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(
                                right: 10, left: 10, top: 10, bottom: 10),
                            child: SvgPicture.asset(
                              "image/button_icon/credit-card-fill.svg",
                              height: 1,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: PaiementTextFild(
                      hintText: "Titulaire de la carte",
                      controllar: titulaireDeLa_Carte_Controllar,
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: Row(
                      children: [
                        Expanded(
                          child: PaiementTextFild(
                            hintText: "Date d'expiration",
                            controllar: date_expirationControllar,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: PaiementTextFild(
                            hintText: "CVC / CVV",
                            controllar: cvc_cvv_Controllar,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 13),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      sauvegarderCetteCartePourshowBottomSheetdata(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff209602).withOpacity(1)),
                        child: Center(
                          child: Row(
                            children: [
                              Checkbox(
                                  value: checkvalue,
                                  activeColor: Colors.white,
                                  onChanged: (va) {
                                    setState(() {
                                      checkvalue = va!;
                                    });
                                  }),
                              Expanded(
                                child: Text(
                                  "Sauvegarder cette carte pour un prochain achat",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 27,
                      right: 27,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Annuler",
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 34,
                            width: 173,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Color(0xff209602).withOpacity(0.3)),
                            child: Center(
                              child: Text(
                                "Payer  € 15.00",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  sauvegarderCetteCartePourshowBottomSheetdata(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(21), topLeft: Radius.circular(21))),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Container(
              height: 380,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff202124),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 31, top: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff209602)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 15.39,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          "Carte de paiement",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Divider(
                    height: 15,
                    thickness: 3,
                    endIndent: 160,
                    indent: 160,
                    color: mainTextColorwithOpachity,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // 1st card
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      validCardBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: TextField(
                        cursorColor: Color(0xff209602),
                        enabled: false,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "**** **** **** 5875",
                            hintStyle: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffC7C7C7))),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide:
                                    BorderSide(color: Color(0xff4B4B4B78))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide:
                                    BorderSide(color: Color(0xff4B4B4B78))),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide:
                                    BorderSide(color: Color(0xff4B4B4B78))),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  right: 12, left: 12, top: 12, bottom: 12),
                              child: SvgPicture.asset(
                                "image/button_icon/credit-card-fill.svg",
                                height: 12,
                                width: 17,
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "05/",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                TextSpan(
                                    text: "23",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))
                              ])),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  // 2nd card
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        error_showBottomSheetdata(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 27, right: 27),
                        child: TextField(
                          enabled: false,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          cursorColor: Color(0xff209602),
                          decoration: InputDecoration(
                              hintText: "**** **** **** 5878",
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffC7C7C7))),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide:
                                      BorderSide(color: Color(0xff4B4B4B78))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide:
                                      BorderSide(color: Color(0xff4B4B4B78))),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide:
                                      BorderSide(color: Color(0xff4B4B4B78))),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    right: 12, left: 12, top: 12, bottom: 12),
                                child: SvgPicture.asset(
                                  "image/button_icon/credit-card-fill.svg",
                                  height: 12,
                                  width: 17,
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "08/",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  TextSpan(
                                      text: "25",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))
                                ])),
                              )),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      paiementParCarte_showBottomSheetdata(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff209602).withOpacity(1)),
                        child: Center(
                          child: Text(
                            "+ Ajouter une nouvelle carte",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 27,
                      right: 27,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Annuler",
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Container(
                          height: 34,
                          width: 173,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Color(0xff209602).withOpacity(0.3)),
                          child: Center(
                            child: Text(
                              "Payer  € 15.00",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //Valid card specially for UI presention
  validCardBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(21), topLeft: Radius.circular(21))),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Container(
              height: 380,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff202124),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 31, top: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff209602)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 15.39,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          "Carte de paiement",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    height: 15,
                    thickness: 3,
                    endIndent: 160,
                    indent: 160,
                    color: mainTextColorwithOpachity,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: TextField(
                      cursorColor: Color(0xff209602),
                      enabled: false,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "**** **** **** 5875",
                          hintStyle: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff))),
                          filled: true,
                          fillColor: Color(0xff209602),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide:
                                  BorderSide(color: Color(0xff4B4B4B78))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide:
                                  BorderSide(color: Color(0xff4B4B4B78))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide:
                                  BorderSide(color: Color(0xff4B4B4B78))),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                right: 12, left: 12, top: 12, bottom: 12),
                            child: SvgPicture.asset(
                              "image/button_icon/credit-card-fill.svg",
                              height: 12,
                              width: 17,
                              color: Colors.white,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "05/",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              TextSpan(
                                  text: "23",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ])),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: TextField(
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      cursorColor: Color(0xff209602),
                      decoration: InputDecoration(
                          hintText: "**** **** **** 5878",
                          hintStyle: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffC7C7C7))),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide:
                                  BorderSide(color: Color(0xff4B4B4B78))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide:
                                  BorderSide(color: Color(0xff4B4B4B78))),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                right: 12, left: 12, top: 12, bottom: 12),
                            child: SvgPicture.asset(
                              "image/button_icon/credit-card-fill.svg",
                              height: 12,
                              width: 17,
                              color: Colors.white,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "08/",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              TextSpan(
                                  text: "25",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ])),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      paiementParCarte_showBottomSheetdata(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff209602).withOpacity(1)),
                        child: Center(
                          child: Text(
                            "+ Ajouter une nouvelle carte",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 27,
                      right: 27,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Annuler",
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaiementValiderPage()));
                            },
                            child: Container(
                              height: 34,
                              width: 173,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: Color(0xff209602).withOpacity(1)),
                              child: Center(
                                child: Text(
                                  "Payer  € 15.00",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //Valid card specially for UI presention
  error_showBottomSheetdata(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(21), topLeft: Radius.circular(21))),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Container(
              height: 502,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff202124),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 31, top: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff209602)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 15.39,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        Text(
                          "Carte de paiement",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    height: 15,
                    thickness: 3,
                    endIndent: 160,
                    indent: 160,
                    color: mainTextColorwithOpachity,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: TextField(
                      controller: numero_de_la_Controllar,
                      cursorColor: Color(0xff209602),
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.red.withOpacity(0.3),
                          hintText: "**** **** **** 5875",
                          hintStyle: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 13, color: Color(0xffC7C7C7))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(color: Colors.red)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(color: Colors.red)),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(
                                right: 10, left: 10, top: 10, bottom: 10),
                            child: SvgPicture.asset(
                              "image/button_icon/credit-card-fill.svg",
                              height: 1,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: TextField(
                      controller: titulaireDeLa_Carte_Controllar,
                      cursorColor: Color(0xff209602),
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.red.withOpacity(0.3),
                        hintText: "John Demis",
                        hintStyle: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 13, color: Color(0xffC7C7C7))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, right: 27),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: date_expirationControllar,
                            cursorColor: Color(0xff209602),
                            style: TextStyle(fontSize: 15, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.red.withOpacity(0.3),
                              hintText: "05/23",
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 13, color: Color(0xffC7C7C7))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(color: Colors.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextField(
                            controller: cvc_cvv_Controllar,
                            cursorColor: Color(0xff209602),
                            style: TextStyle(fontSize: 15, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.red.withOpacity(0.3),
                              hintText: "185",
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 13, color: Color(0xffC7C7C7))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(color: Colors.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "image/warning.svg",
                            height: 15,
                            color: Colors.red,
                          ),
                          SizedBox(
                              width:
                                  8), // Add a small space between the icon and text
                          Text('Cette carte n\'est pas valide !',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.red, fontSize: 14))),
                        ],
                      )),
                  SizedBox(height: 13),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      sauvegarderCetteCartePourshowBottomSheetdata(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff209602).withOpacity(1)),
                        child: Center(
                          child: Row(
                            children: [
                              Checkbox(
                                  value: checkvalue,
                                  activeColor: Colors.white,
                                  onChanged: (va) {
                                    setState(() {
                                      checkvalue = va!;
                                    });
                                  }),
                              Expanded(
                                child: Text(
                                  "Sauvegarder cette carte pour un prochain achat",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 27,
                      right: 27,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Annuler",
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 34,
                            width: 173,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Color(0xff209602).withOpacity(0.3)),
                            child: Center(
                              child: Text(
                                "Payer  € 15.00",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  paiementFailedBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(21), topLeft: Radius.circular(21))),
        builder: (BuildContext context) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
                color: bottomShetColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () {},
                //
                //   child: Icon(Icons.clear_rounded,size: 15,color: whiteTextColor,),
                //   style: ElevatedButton.styleFrom(
                //
                //     shape: CircleBorder(),
                //     o
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainTextColorwithOpachity),
                        child: Center(
                            child: Icon(
                          Icons.clear_rounded,
                          size: 15,
                          color: whiteTextColor,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Oups!",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor))),
                Divider(
                  height: 15,
                  thickness: 3,
                  endIndent: 160,
                  indent: 160,
                  color: mainTextColorwithOpachity,
                ),
                SizedBox(
                  height: 26,
                ),
                SvgPicture.asset(
                  "image/noun_basket_821481.svg",
                  height: 23,
                  width: 28,
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Ce produit est épuisé!",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor))),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (_)=>PaiementValiderPage()));
                    },
                    child: Container(
                        height: 55,
                        width: 330,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: mainTextColor),
                        child: Center(
                          child: Text("Retour en arrière",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: whiteTextColor))),
                        )),
                  ),
                )
              ],
            ),
          );
        });
  }

  // Stripe
  Future<void> makePayment() async {
    // try {
    Dialogue.showLoadingDialog();
    paymentIntent = await createPaymentIntent(
        HelperFunction.convertDoubleToSmallestCurrencyUnit(
                controller_cartController.totalPrice.value!)
            .toString(),
        'EUR');

    //STEP 2: Initialize Payment Sheet
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntent![
                    'client_secret'], //Gotten from payment intent
                style: ThemeMode.dark,

                //
                //selectedCountry: "Spain",
                merchantDisplayName: 'La Spiga d\'Oro'))
        .then((value) {});

    Dialogue.dismissLoadingDialog();

    //STEP 3: Display Payment sheet
    String? transactionId = await displayPaymentSheet();

    if (transactionId != null) {
      print('Transaction ID: $transactionId');

      var response =
          await controller_cartController.placeOrderStripe(transactionId);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data["status"] == "Order created successfully") {
          controller_cartController.payment_status.value = 1;
          controller_cartController.order_id.value = data["data"]["id"];
          controller_cartController.resetValuesAfterPayment();

          Fluttertoast.showToast(
            msg: 'Votre commande est en cours de préparation',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
          );

          Get.offAll(
            () => PrepearingFoodScreen(),
            transition: Transition.rightToLeft,
          );
        } else if (data["status"].contains('Out of Stock')) {
          Fluttertoast.showToast(
            msg:
                'En rupture de stock. Available  stock is ${HelperFunction.extractNumber(data["status"])}',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Oups! un erreur s\'est produite.',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );
        }
        // Perform any additional actions with the transaction ID, e.g., store it in your database
      } else {
        Fluttertoast.showToast(
          msg: 'Oups! un erreur s\'est produite.',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Oups! un erreur s\'est produite.',
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }

    paymentIntent = null;

    // } catch (err) {
    //   Dialogue.dismissLoadingDialog();
    //
    //   throw Exception(err);
    //
    // }
  }

  Future<String?> displayPaymentSheet() async {
    try {
      return await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Paiement réussi"),
                    ],
                  ),
                ));

        // Extract the transaction ID from the PaymentIntent
        String? transactionId = paymentIntent?['id'];

        // Return the transaction ID within the then block
        return transactionId;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      // Handle the StripeException here
    } catch (e) {
      // Handle other exceptions here
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount));

    return calculatedAmout.toString();
  }
}
