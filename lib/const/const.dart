import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final mainTextColor= Color(0xff209602).withOpacity(1);
final mainTextColorwithOpachity= Color(0xff209602);
final whiteTextColor= Color(0xffFFFFFF).withOpacity(1);
final bottomShetColor=  Color(0xff202124).withOpacity(1);
final greyTextXolor = Color(0xffA1A1A1);

final bookedcolor = Color(0xff07C1BA);

final draftcolor = Color(0xff407CE5);

final speciescolor = Color(0xff9B179F);
final ticketcolor = Color(0xffE1991F);



final statusColorNew = Color(0xffEBB02D);
final statusColorReady = Color(0xff539165);
final statusColorprocess = Color(0xff3F497F);
final statusColordelivered = Color(0xff8D6E63);
final statusColorRefunded = Color(0xffD81B60);
final statusColorCancle = Color(0xffD32F2F);



final loaderSquare = Center(
    child: SpinKitCubeGrid(
      color: mainTextColor,
      size: 70.0,
    )
);

final loaderSquareWithWhiteBackground = Container(
    color: Colors.white,
    child: Center(
        child: loaderSquare
)
);

final loaderSquareWithBlackishBackground = Container(
    color: bottomShetColor,
    child: Center(
        child: loaderSquare
    )
);
