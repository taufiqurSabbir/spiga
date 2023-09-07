import 'package:laspigadoro/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class LongTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const longText = 'This is a very long text, wt reaches the edge of the screen or container.';

    return Text(
      longText,
      style:  GoogleFonts.openSans(
          textStyle: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: whiteTextColor)),
      softWrap: true, // Enable text wrapping
      overflow: TextOverflow.clip,
      // Clip the text when it overflows the container
    );
  }
}