import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../notification_screens/notification_client_on_order_status_change.dart';
import '../notification_screens/notification_owner_order_details_show.dart';
import '../notification_screens/notification_owner_out_of_stock.dart';

class FlutterLocalNotification{
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<String> initializeLocalNotifications() async {
    final AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    final IOSInitializationSettings iosInitializationSettings =
    IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            Map<String, dynamic> data = jsonDecode(payload);
            print(data['redirect_page']);
            print(data['redirect_page'] == 'order_details');
            if (data['redirect_page'] == 'order_details') {
              Get.to(() => OwnerOrderDetailsForNotification(id: int.parse(data['id'])));

            }
            else if (data['redirect_page'] == 'food_offers') {
              Get.to(() => NotificationOwnerOutOfStock(id: int.parse(data['id'])));
            }
            else if (data['redirect_page'] == 'order_status_change'){
              Get.to(() => NotificationClientOnOrderStatusChange());
            }

            return  payload;

          }
          else{
            print("payload is null");
            return "";
          }
        });


    return "";
  }
}