import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart' as html;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/api.dart';
import '../api/api_get_calls.dart';
import 'dart:io' as io;
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io' show Platform;
import 'dart:io';



class HelperFunction{
  HelperFunction();

  // Check  if  it  is  correct  link  or  not
  static bool hasHttpOrHttps(String url) {
    return url.contains("http://") || url.contains("https://");
  }


  static String convertToAmPm(String time) {
    List<String> parts = time.split(":");
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    String amPm = hours >= 12 ? "PM" : "AM";
    hours = hours % 12;
    if (hours == 0) {
      hours = 12;
    }

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $amPm";
  }


  static String convertDateFormatWithoutYear(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = "${dateTime.day.toString().padLeft(2, '0')} ${_getMonthName(dateTime.month)}";
    return formattedDate;
  }

  static String convertDateFormatWithYear(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = "${dateTime.day.toString().padLeft(2, '0')} ${_getMonthName(dateTime.month)}, ${dateTime.year.toString()}";
    return formattedDate;
  }

  static String htmlLiWrapSpan(String inputhtml){
    // final document = html.parse(inputhtml);
    // final liElements = document.querySelectorAll('li');
    // for (final li in liElements) {
    //   final span = html.Element.tag('span');
    //   li.replaceWith(span);
    //   span.append(li);
    // }
    //
    // final modifiedHtml = document.outerHtml;

    // print(modifiedHtml.toString());

    var document = html.parse(inputhtml);
    var liElements = document.querySelectorAll('li');

    int counter = 1;
    for (var li in liElements) {
      li.innerHtml = '<span>$counter . </span>${li.innerHtml}';
      counter++;
    }

    String modifiedHtmlString = document.outerHtml;
    print(modifiedHtmlString);
    return modifiedHtmlString;
  }

  static String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "janvier";
      case 2:
        return "février";
      case 3:
        return "mars";
      case 4:
        return "avril";
      case 5:
        return "mai";
      case 6:
        return "juin";
      case 7:
        return "juillet";
      case 8:
        return "aout";
      case 9:
        return "septembre";
      case 10:
        return "octobre";
      case 11:
        return "novembre";
      case 12:
        return "décembre";
      default:
        return "";
    }
  }

  static String stringToCurrency(String my_amount, String prefix){
    try{
      double amount = double.parse(my_amount);

      String formattedAmount = NumberFormat.currency(
        decimalDigits: 2,
        symbol: prefix,
      ).format(amount);

      return formattedAmount;
    }
    catch(e){
      return "";
    }

  }



  static  String timeOfDayToString(TimeOfDay time) {
    final DateTime dateTime = DateTime(
      2023, // Any arbitrary year
      1, // Any arbitrary month
      1, // Any arbitrary day
      time.hour,
      time.minute,
    );
    return DateFormat('HH:mm').format(dateTime); // Format the time to "HH:mm"
  }

  static String htmlEncode(String text) {
    return htmlEscape.convert(text);
  }

  static DateTime parseTime(String timeString) {
    final timeFormat = DateFormat.Hm(); // Hm() uses 24-hour format without a leading zero
    return timeFormat.parse(timeString);
  }


  static String formatMillisecondsSinceEpochToAmPm(double millisecondsSinceEpoch) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch.toInt());
    DateFormat dateFormat = DateFormat.jm(); // jm() uses the hour, minute, and AM/PM format
    return dateFormat.format(dateTime);
  }

  static String formatMillisecondsSinceEpoch(double milliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds.toInt());
    String hours = date.hour.toString().padLeft(2, '0');
    String minutes = date.minute.toString().padLeft(2, '0');
    return "$hours:$minutes";
  }



  static bool containsIds(List<int> baseArray, List<int> targetArray) {
    bool match = false;

    for(int i = 0; i< targetArray.length; i++) {

      for(int j = 0; j< baseArray.length; j++) {

        if(targetArray[i] == baseArray[j]) {
          match = true;
          break;
        }
      }

      if(match == true) {
        break;
      }
    }


    return match;
  }

  static String formatTimeMillisecondsSinceEpochTo24Hrs(double milliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds.toInt());
    DateFormat timeFormat = DateFormat('HH:mm');
    return timeFormat.format(dateTime);
  }

  static String convertTo24HourFormat(String time12Hour) {
    try {
      DateFormat inputFormat = DateFormat('h:mm a'); // Define the input format
      DateFormat outputFormat = DateFormat('HH:mm'); // Define the output format

      DateTime parsedTime = inputFormat.parse(time12Hour); // Parse the 12-hour time string
      String convertedTime = outputFormat.format(parsedTime); // Convert to 24-hour format

      return convertedTime;
    }
    catch(e){
      return time12Hour;
    }
  }


  static bool isTimeInRange(String startTime, String endTime, String targetTime) {
    List<String> start = startTime.split(':');
    List<String> end = endTime.split(':');
    List<String> target = targetTime.split(':');

    int startHour = int.parse(start[0].trim());
    int startMin = int.parse(start[1].trim());
    int endHour = int.parse(end[0].trim());
    int endMin = int.parse(end[1].trim());
    int targetHour = int.parse(target[0].trim());
    int targetMin = int.parse(target[1].trim());

    if (startHour < endHour ||
        (startHour == endHour && startMin <= endMin)) {
      return (targetHour > startHour || (targetHour == startHour && targetMin >= startMin)) &&
          (targetHour < endHour || (targetHour == endHour && targetMin <= endMin));
    } else {
      return (targetHour > startHour || (targetHour == startHour && targetMin >= startMin)) ||
          (targetHour < endHour || (targetHour == endHour && targetMin <= endMin));
    }
  }
  static String getTodayTomorrowOrNull(String date){
    DateTime now = DateTime.now();

    String today = DateTime.now().toString();
    today = today.split(" ")[0].trim();

    String tomorrow = DateTime(now.year, now.month, now.day + 1).toString();
    tomorrow = tomorrow.split(" ")[0].trim();


    if(today.contains(date)){
      return "( Aujourd'hui )";
    }

    else if(tomorrow.contains(date)){
      return "( Demain )";
    }
    else{
      return "";
    }
  }

  static String getTodayTomorrowOrDate(String date){
    DateTime now = DateTime.now();

    String today = DateTime.now().toString();
    today = today.split(" ")[0].trim();

    String tomorrow = DateTime(now.year, now.month, now.day + 1).toString();
    tomorrow = tomorrow.split(" ")[0].trim();


    if(today.contains(date)){
      return "Aujourd'hui";
    }

    else if(tomorrow.contains(date)){
      return "Demain";
    }
    else{
      return convertDateFormatWithoutYear(date);
    }
  }
  static String getTodayTomorrowOrDateWithYear(String date){
    DateTime now = DateTime.now();

    String today = DateTime.now().toString();
    today = today.split(" ")[0].trim();

    String tomorrow = DateTime(now.year, now.month, now.day + 1).toString();
    tomorrow = tomorrow.split(" ")[0].trim();


    if(today.contains(date)){
      return "Aujourd'hui";
    }

    else if(tomorrow.contains(date)){
      return "Demain";
    }
    else{
      return convertDateFormatWithYear(date);
    }
  }


  static String splitTime(String time) {
    List<String> parts = time.split("-");
    String part1 = parts[0].trim();
    String part2 = parts[1].trim();


    String Timefrom = convertToAmPm(part1);
    String Timeto = convertToAmPm(part2);

    return "${Timefrom} - ${Timeto}";
  }

  static String dynamicToCurrency(dynamic my_amount, int quantity, String prefix) {
    num amounta = num.tryParse(my_amount.toString()) ?? 0;
    num amount = amounta * quantity;

    String formattedAmount = NumberFormat.currency(
      decimalDigits: 2,
      symbol: prefix,
    ).format(amount);

    return formattedAmount;
  }


  static int convertDoubleToSmallestCurrencyUnit(double value) {
    return (value * 100).round();
  }

  static Future<int> getFoodStock(int foodId) async {
    var response = await ApiGetCalls.getApiResponse(Api.listeSurprisApi);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          if (data[i]["food_stock"] == foodId) {
            return data[i]["food_stock"];
          }
        }

        return -1;
      }
      else{
        return -1;
      }
    }
    else{
      return -1;
    }
  }

  static int? extractNumber(String text) {
    RegExp regExp = RegExp(r'\d+');
    Match match = regExp.firstMatch(text) as Match;
    return match != null ? int.parse(match.group(0)!) : null;
  }

  static void printArrayAndLength(List array, String arrayName) {
    print('$arrayName: $array');
    print('$arrayName length: ${array.length}');
  }


  static Future<void> saveQrCode(GlobalKey _qrKey) async {
    if (Platform.isAndroid) {
      // Android-specific code
      RenderRepaintBoundary boundary = _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      if (await Permission.storage.request().isGranted) {
        try {
          final directory = await getExternalStorageDirectory();
          String newPath = '';
          List<String>? folders = directory?.path.split('/');
          for (int x = 1; x < folders!.length; x++) {
            String folder = folders![x];
            if (folder != 'Android') {
              newPath += '/' + folder;
            } else {
              break;
            }
          }
          newPath = newPath + '/Download';
          Directory newDirectory = Directory(newPath);
          if (!await newDirectory.exists()) {
            await newDirectory.create(recursive: true);
          }

          String currentTime = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
          String fileName = 'La Spiga D\'oro qr_code_$currentTime.png'.replaceAll(' ', '_');
          File file = File(newPath + '/' + fileName);
          await file.writeAsBytes(pngBytes!);
          await ImageGallerySaver.saveFile(newPath + '/' + fileName);

          Fluttertoast.showToast(
            msg: 'Le QR code à été enregistrée dans le fichier de téléchargement',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
          );

        } catch (e) {
          print(e);
          Fluttertoast.showToast(
            msg: 'Une erreur s\'est produite lors du téléchargement du QR code',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );


        }
      } else {

        Fluttertoast.showToast(
          msg: 'Permission denied. Unable to save QR Code.',
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );


      }
    }

    else if (Platform.isIOS) {
      // iOS-specific code
      RenderRepaintBoundary boundary = _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      if (await Permission.photos.request().isGranted) {
        try {
          final directory = await getTemporaryDirectory();
          String newPath = directory.path;
          newPath = newPath + '/Download';
          io.Directory newDirectory = io.Directory(newPath);
          if (!await newDirectory.exists()) {
            await newDirectory.create(recursive: true);
          }

          String currentTime = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
          String fileName = 'La Spiga D\'oro qr_code_$currentTime.png'.replaceAll(' ', '_');
          io.File file = io.File(newPath + '/' + fileName);
          await file.writeAsBytes(pngBytes!);

          final result = await ImageGallerySaver.saveFile(file.path);
          print(result);

          String toastMessage;
          if (io.Platform.isIOS) {
            toastMessage = 'Le QR code a été enregistré dans votre galerie de photos';
          } else {
            toastMessage = 'Le QR code à été enregistrée dans le fichier de téléchargement';
          }

          Fluttertoast.showToast(
            msg: toastMessage,
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
          );

        } catch (e) {
          print(e);
          Fluttertoast.showToast(
            msg: 'Une erreur s\'est produite lors du téléchargement du QR code',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 14.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
          );
        }
      }
      else {
        Fluttertoast.showToast(
          msg: 'Permission denied. Unable to save QR Code.',
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );

        openAppSettings();

      }
    }
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }


  static String checkEmailHasOrNot(String input){
    if (input.contains('@laspigadoro.com')) {
      return 'You hide your email during login';
    } else {
      return input;
    }
  }


  static Future<void> launchGoogleMaps(String address) async {
     String googleMapsUrl = 'https://www.google.com/maps?q=${Uri.encodeComponent(address)}';
     Uri myGoogleMapUrl = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(myGoogleMapUrl)) {
      await launchUrl(myGoogleMapUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }


  static bool isValid(String? input) {
    if(input == null){
      return false;
    }
    else{
      return input.trim().isNotEmpty;
    }
  }

  static bool isTimeInRangeFromRange(String range, String time) {
    List<String> times = range.split(' - ');
    print(times);

    DateTime startTime = DateTime.parse('1970-01-01 ' + times[0]);
    DateTime endTime = DateTime.parse('1970-01-01 ' + times[1]);
    DateTime checkTime = DateTime.parse('1970-01-01 ' + time);

    if (endTime.isBefore(startTime)) {
      if (checkTime.isBefore(startTime)) {
        checkTime = checkTime.add(Duration(days: 1));
      }
      endTime = endTime.add(Duration(days: 1));
    }

    return (checkTime.isAfter(startTime) || checkTime.isAtSameMomentAs(startTime))
        && (checkTime.isBefore(endTime) || checkTime.isAtSameMomentAs(endTime));
  }

 //  checkImageOrientation(String imageUrl) {
 //
 //
 //    ImageProvider imageProvider = NetworkImage(imageUrl);
 //
 //    Image(image: imageProvider).image.resolve(ImageConfiguration()).addListener(
 //      ImageStreamListener((ImageInfo info, bool _) {
 //        final double aspectRatio = info.image.width.toDouble() / info.image.height.toDouble();
 //
 //        if (aspectRatio > 1) {
 //
 //
 //          print('Image is in landscape orientation');
 //        } else {
 //
 //          print('Image is in portrait orientation');
 //        }
 //      }),
 //    );
 //
 //  }



  static int checkImageOrientation(String imageUrl) {
    // final Completer<int> completer = Completer<int>();
    // final ImageStream stream = NetworkImage(imageUrl).resolve(ImageConfiguration());
    // late ImageStreamListener listener;

    // listener = ImageStreamListener((ImageInfo info, bool _) {
    //   final double aspectRatio = info.image.width.toDouble() / info.image.height.toDouble();
    //   completer.complete(aspectRatio > 1 ? 0 : 1);
    //
    //   // Remove the listener after it's been called once to prevent memory leaks.
    //   stream.removeListener(listener);
    // });
    //
    // stream.addListener(listener);

    // return completer.future;
    return 0;
  }


}

