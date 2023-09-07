import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:laspigadoro/client/controllar/liste_controller.dart';
import 'package:laspigadoro/client/model/Allergy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:laspigadoro/const/const.dart';

import '../../helper/helper_function.dart';
import '../model/FoodCat.dart' as FoodCat;




class ListeFilter extends StatefulWidget {
  final ListeController controller_listeController;

  ListeFilter({Key? key, required this.controller_listeController}) : super(key: key);

  @override
  State<ListeFilter> createState() => _ListeFilterState();
}

class _ListeFilterState extends State<ListeFilter> {



  @override
  void initState() {
    super.initState();
    widget.controller_listeController.resetDataForFilter();
    widget.controller_listeController.getDataForFilter();

  }




  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: bottomShetColor
    ));

    return Obx(()=>

       widget.controller_listeController.showFilterLoader == true
       ? loaderSquare
       :  Scaffold(
             appBar: AppBar(
               centerTitle: true,
               automaticallyImplyLeading: false,
               backgroundColor: bottomShetColor,
               elevation: 1,
               title: Text("Filtres",
                   style: GoogleFonts.openSans(
                       textStyle: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.bold,
                           color: whiteTextColor))),
               actions: [
                 Padding(
                     padding: const EdgeInsets.only(right: 15),
                     child: GestureDetector(
                       onTap: (){
                         Navigator.pop(context);
                       },
                       child:Container(
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
                     )
                 )
               ],
             ),
             backgroundColor: bottomShetColor,
             bottomNavigationBar: Column(
               mainAxisSize: MainAxisSize.min,

               children: [
                 InkWell(
                     onTap: (){
                       widget.controller_listeController.resetDataForFilter();
                     },
                     child: Container(
                       height: 54,
                       width: 339,
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.withOpacity(0.2),width: 1),
                           borderRadius: BorderRadius.circular(25),

                           color:Colors.transparent
                       ),
                       child: Center(
                         child: Text("Tout reinitialiser",
                             style: GoogleFonts.openSans(
                                 textStyle: TextStyle(
                                     fontSize: 14,
                                     fontWeight: FontWeight.bold,
                                     color: whiteTextColor))),
                       ),
                     )
                 ),
                 SizedBox(height: 10,),
                 InkWell(
                   onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                     widget.controller_listeController.listDataFilter();
                     Navigator.pop(context);
                   },
                   child: Container(
                     height: 54,
                     width: 339,
                     decoration: BoxDecoration(
                         border: Border.all(color: Colors.grey.withOpacity(0.2),width: 1),
                         borderRadius: BorderRadius.circular(25),
                         color:mainTextColor
                     ),
                     child: Center(
                       child: Text("Afficher Resultats",
                           style: GoogleFonts.openSans(
                               textStyle: TextStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold,
                                   color: whiteTextColor))),
                     ),
                   ),
                 ),
                 SizedBox(height: 35,),

               ],
             ),
             body: SingleChildScrollView(

               child: Padding(
                 padding: const EdgeInsets.only(left: 22,right:22 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 20),
                     Padding(
                       padding: const EdgeInsets.only(top: 5),
                       child: Text("Pick up",style: GoogleFonts.openSans(
                           textStyle: TextStyle(
                               fontSize: 15,
                               fontWeight: FontWeight.bold,
                               color: whiteTextColor))),
                     ),
                     SizedBox(height: 18,),

                     Row(
                       children: [
                         GestureDetector(
                           onTap: (){
                             widget.controller_listeController.pickUpDate.value = 1;
                             print(widget.controller_listeController.pickUpDate.value);

                           },
                           child:  Container(
                             height: 34,
                             width: (MediaQuery.of(context).size.width/2) - 22 -4,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(7),
                                 color: widget.controller_listeController.pickUpDate.value == 1
                                     ? mainTextColor
                                     : Color(0xff929292).withOpacity(0.1)
                             ),
                             child: Center(child: Text("Aujourd'hui",style:
                             TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.white
                             ),),),
                           ),
                         ),
                         SizedBox(width: 8,),
                         GestureDetector(
                           onTap: (){
                             widget.controller_listeController.pickUpDate.value = 2;
                             print(widget.controller_listeController.pickUpDate.value);
                           },
                           child:  Container(
                             height: 34,
                             width: (MediaQuery.of(context).size.width/2) - 22 - 4,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(7),
                                 color: widget.controller_listeController.pickUpDate.value == 2
                                     ? mainTextColor
                                     : Color(0xff929292).withOpacity(0.1)
                             ),
                             child: Center(child: Text("Demain",style:
                             TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.white
                             ),),),
                           ),
                         ),
                       ],
                     ),


                     SizedBox(height: 28,),
                     Text("Tranche d'heure",style: GoogleFonts.openSans(
                         textStyle: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.bold,
                             color: whiteTextColor))),
                     SizedBox(height: 10,),
                     Text("${widget.controller_listeController.pickUpHourText.value}",style: GoogleFonts.openSans(
                         textStyle: TextStyle(
                             fontSize: 12,
                             fontWeight: FontWeight.bold,
                             color: whiteTextColor))),
                     SizedBox(height: 28,),
                     RangeSlider(
                       min:  widget.controller_listeController.minValue.value,
                       max: widget.controller_listeController.maxValue.value,
                       activeColor: mainTextColor,
                       values: RangeValues(widget.controller_listeController.lowerValue.value, widget.controller_listeController.higherValue.value),
                       onChanged: (values) {

                         widget.controller_listeController.lowerValue.value =
                             values.start;
                         widget.controller_listeController.higherValue.value =
                             values.end;

                         print(widget.controller_listeController.lowerValue.value);
                         print(widget.controller_listeController.higherValue.value);


                         // if(widget.controller_listeController.minValue.value != values.start && widget.controller_listeController.higherValue.value != values.end) {

                         widget.controller_listeController.pickUpHourText.value = HelperFunction.formatMillisecondsSinceEpoch(widget.controller_listeController.lowerValue.value) + " - " + HelperFunction.formatMillisecondsSinceEpoch(widget.controller_listeController.higherValue.value);
                         // }
                         // else{
                         //   widget.controller_listeController.pickUpHourText.value = "Toute la journée";
                         // }
                       },
                     ),
                     SizedBox(height: 20,),
                     Text("Préférences alimentaire",style: GoogleFonts.openSans(
                         textStyle: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.bold,
                             color: whiteTextColor))),
                     SizedBox(height: 22,),
                     Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           ChipsChoice<Allergy>.multiple(
                             padding: EdgeInsets.all(0),
                             value: widget.controller_listeController.tags.value,
                             onChanged: (val) {
                               widget.controller_listeController.tags.value =val;
                               print(widget.controller_listeController.tags.value);

                             },
                             choiceItems: C2Choice.listFrom<Allergy, Allergy>(
                               source: widget.controller_listeController.allergyArray.value,
                               value: (i, v) => v,
                               label: (i, v) => v.name!,
                             ),
                             choiceStyle: C2ChoiceStyle(
                               showCheckmark: false,
                               borderRadius: BorderRadius.circular(7),
                               borderColor: Color(0xffDFE7D6).withOpacity(0.1),
                               backgroundColor: bottomShetColor,
                               color: Colors.white,


                             ),
                             choiceActiveStyle: C2ChoiceStyle(
                               showCheckmark: false,
                               borderRadius: BorderRadius.circular(7),
                               borderColor: Color(0xffDFE7D6).withOpacity(0.1),
                               backgroundColor:mainTextColor,
                               color: Colors.white,

                             ),

                             wrapped: true,
                           )
                         ]
                     ),

                     SizedBox(height: 15,),

                     Text("Catégories",
                         style: GoogleFonts.openSans(
                             textStyle: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.bold,
                                 color: whiteTextColor))),
                     SizedBox(height: 15,),

                     Column(
                         children: getCatColumn(widget.controller_listeController.foodCat)
                     ),


                     SizedBox(height: 25,),








                   ],
                 ),
               ),
             ),
           )



    );
  }


  getCatColumn(RxList<FoodCat.Data> catTypeArray){
    List<Widget> column = [];
    int cat_count  = 0;


    List<Widget> row = [];

    catTypeArray.forEach((FoodCat.Data cat) {
      cat_count++;

      row.add(
          Container(
            width : MediaQuery.of(context).size.width/2 - (22+3),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: widget.controller_listeController.selectedFoodCat.contains(cat.id)
                        ? MaterialStateProperty.all(mainTextColor)
                        : MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStatePropertyAll(
                        BorderSide(
                            color: Color(0xff5B5B5B)
                        )
                    )
                ),
                onPressed: (){
                  if(widget.controller_listeController.selectedFoodCat.contains(cat.id)){
                    widget.controller_listeController.selectedFoodCat.remove(cat.id!);
                  }
                  else{
                    widget.controller_listeController.selectedFoodCat.add(cat.id!);
                  }
                },
                child: Text(cat.name!,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteTextColor)))),
          )
      );

      if(cat_count%2 == 0){
        Widget myRow = Row(children: row);
        column.add(myRow);
        row = [];
      }
      else{
        row.add(
          SizedBox(width: 6,),
        );
      }


    });

    if(row.length > 0 ){
      Widget myRow = Row(children: row);
      column.add(myRow);
      row = [];
    }

    return column;
  }

}
