import 'dart:async';
import 'dart:convert';

import 'package:laspigadoro/sharePreference/sharePreference_getFCM.dart';
import 'package:laspigadoro/sharePreference/sharePreference_getToken.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';
import 'api/api_get_calls.dart';
import 'api/api_post_calls.dart';
import 'client/controllar/order_details_controller.dart';
import 'client/screen/choisir_votre_client.dart';
import 'client/screen/slider_page_8.dart';
import 'flutterLocalNotification/FlutterLocalNotification.dart';
import 'login_page/login_page.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'model/PushNotification.dart';
import 'model/UserInfo.dart';
import 'notification_screens/notification_client_on_order_status_change.dart';
import 'notification_screens/notification_owner_order_details_show.dart';
import 'notification_screens/notification_owner_out_of_stock.dart';
import 'owner/choisir_votre_admin_47.dart';
import 'owner/controller/order_number_controller.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

void main() async {
  Get.put(
      OrderNumberController()); // This will initialize MyController globally
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  // initializing the firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

  //Assign publishable key to flutter_stripe for Test
  //Stripe.publishableKey = "pk_test_51KAD0uIUx1qYvujU7jd0IKspJ3JjmQ4kYz3uAjuloS3H90g3YTyuHnedQigblC1Kc7TPHVzqN4lxEzAWhoiRJJu000lhwGV81I";

  //Assign publishable key to flutter_stripe for Production
  Stripe.publishableKey =
      "pk_live_51N1YX4Ik5wPBCp89kUhjaiLvuZlnsp29dezdja0BiKw9tIpV84LPuwwGKtkXd4920nsZ7INmMlhoSQwbZRAjH8Sv00WkblXSSk";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");

  //Run the app
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print('Background message received: ${message.notification?.body}');

  // Initialize the local notifications plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Prepare notification details
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    'your_channel_description',
    importance: Importance.max,
    styleInformation: BigTextStyleInformation(''), // Add this line
    priority: Priority.high,
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  // Show the notification
  await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
      message.notification?.body, platformChannelSpecifics,
      payload: jsonEncode(message.data));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return OverlaySupport(
          child: GetMaterialApp(
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!),
        debugShowCheckedModeBanner: false,
        title: 'La Spiga D’oro',
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,

        theme: ThemeData(
          primarySwatch: createMaterialColor(
              Color(0xff209602)), // Using custom color as primarySwatch
        ),
        home: MyHomePage(),
      ));
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _message = '';
  late int _totalNotifications;
  PushNotification? _notificationInfo;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    locallySharePreferenceValueAltered();
    _configureFirebaseMessaging();
    FlutterLocalNotification.initializeLocalNotifications();

    Timer(Duration(seconds: 2), () async {
      String payload =
          await FlutterLocalNotification.initializeLocalNotifications();
      print("payload: $payload");
      print("payload length:" + payload.length.toString());

      List loginOrNotData = await logInOrNot();
      print(loginOrNotData);

      if (loginOrNotData.length > 0) {
        if (loginOrNotData[0] == 'user' && loginOrNotData[1] == 0) {
          if (payload.length == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SliderPage()),
            );
          } else {
            Map<String, dynamic> data = jsonDecode(payload);

            if (data['redirect_page'] == 'order_details') {
              Get.to(() =>
                  OwnerOrderDetailsForNotification(id: int.parse(data['id'])));
            } else if (data['redirect_page'] == 'food_offers') {
              Get.to(
                  () => NotificationOwnerOutOfStock(id: int.parse(data['id'])));
            } else if (data['redirect_page'] == 'order_status_change') {
              Get.to(() => NotificationClientOnOrderStatusChange());
            }
          }
        } else if (loginOrNotData[0] == 'user' && loginOrNotData[1] == 1) {
          if (payload.length == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Choisir_Scren_Client()),
            );
          } else {
            Map<String, dynamic> data = jsonDecode(payload);

            if (data['redirect_page'] == 'order_details') {
              Get.to(() =>
                  OwnerOrderDetailsForNotification(id: int.parse(data['id'])));
            } else if (data['redirect_page'] == 'food_offers') {
              Get.to(
                  () => NotificationOwnerOutOfStock(id: int.parse(data['id'])));
            } else if (data['redirect_page'] == 'order_status_change') {
              Get.to(() => NotificationClientOnOrderStatusChange());
            }
          }
        } else if (loginOrNotData[0] == 'admin') {
          if (payload.length == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Choisir_Scren_Admin()),
            );
          } else {
            Map<String, dynamic> data = jsonDecode(payload);

            if (data['redirect_page'] == 'order_details') {
              Get.to(() =>
                  OwnerOrderDetailsForNotification(id: int.parse(data['id'])));
            } else if (data['redirect_page'] == 'food_offers') {
              Get.to(
                  () => NotificationOwnerOutOfStock(id: int.parse(data['id'])));
            } else if (data['redirect_page'] == 'order_status_change') {
              Get.to(() => NotificationClientOnOrderStatusChange());
            }
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  locallySharePreferenceValueAltered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('isGuest', '0');
    prefs.setString('redirectPage', '');
  }

  Future<List> logInOrNot() async {
    final String? bearerToken = await getToken();
    print("Token => ${bearerToken}");
    if (bearerToken != null || bearerToken != "") {
      var response = await ApiGetCalls.getApiResponse(Api.userInfoApi);
      if (response.statusCode == 200) {
        try {
          var data = UserInfo.fromJson(json.decode(response.body));

          return [data.userType, data.tutorialSteps];
        } catch (e) {
          print(e);
          return [];
        }
      }
      return [];
    } else {
      return [];
    }
  }

  Future<void> _initializeLocalNotifications() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    final IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
        Map<String, dynamic> data = jsonDecode(payload);
        print(data['redirect_page']);
        print(data['redirect_page'] == 'order_details');
        if (data['redirect_page'] == 'food_offers') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OwnerOrderDetailsForNotification(
                  id: int.parse(data['order_id'])),
            ),
          );
        }
      }
    });
  }

  Future<void> _configureFirebaseMessaging() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
        });
      });

      if (_notificationInfo != null) {
        // For displaying the notification as an overlay
        showSimpleNotification(
          Text(_notificationInfo!.title!),
          // leading: NotificationBadge(totalNotifications: _totalNotifications),
          subtitle: Text(_notificationInfo!.body!),
          background: Colors.cyan.shade700,
          duration: Duration(seconds: 2),
        );
      }

      // For handling the message opened from notification
    } else {
      print('User declined or has not accepted permission');
    }

    // Add this part: For handling the notification tap event
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data['redirect_page']);
      print(message.data['redirect_page'] == "order_details");
      print(message.data['id'] == "order_details");
      if (message.data['redirect_page'] == "order_details") {
        int orderId = int.parse(message.data['id']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OwnerOrderDetailsForNotification(id: orderId),
          ),
        );
      } else if (message.data['redirect_page'] == "food_offers") {
        int orderId = int.parse(message.data['id']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NotificationOwnerOutOfStock(id: int.parse(message.data['id'])),
          ),
        );
      }
      // For order_status_change this  time  will  go  NotificationClientOnOrderStatusChange();
      else if (message.data['redirect_page'] == "order_status_change") {
        int orderId = int.parse(message.data['id']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationClientOnOrderStatusChange(),
          ),
        );
      }
    });

    // Add this part: For handling the notification tap event when the app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null &&
        initialMessage.data['redirect_page'] == "order_details") {
      int orderId = int.parse(initialMessage.data['order_id']);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OwnerOrderDetailsForNotification(id: orderId),
          ),
        );
      });
    }
    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.body}');
      print('Order received: ${message.data['order_id']}');

      _showNotification(message);
    });

    // Subscribe to a topic
    await _firebaseMessaging.subscribeToTopic('example_topic');

    // Get device token
    String? token = await _firebaseMessaging.getToken();
    print('Device token: $token');

    // Device token is saved to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fcm_id', token!);

    var fcm_id_response = await ApiPostCalls.postApiResponse(
        Api.fcmIdApi, {"fcmid": await getFcmId()});
    if (fcm_id_response.statusCode == 200) {
      print("Fcm id saved");
    } else {
      print("Fcm id not saved");
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'your_channel_id', 'your_channel_name', 'your_channel_description',
            importance: Importance.max,
            styleInformation: BigTextStyleInformation(''), // Add this line
            priority: Priority.high);

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    print("Asddfddddddddddddddddddd => =>");
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: jsonEncode(message.data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff209602),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color(0xff209602),

          // Status bar brightness (optional)
          // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          // statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Container(
        color: Color(0xff209602),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 70),
                child: Image.asset(
                  'image/splash_logo.png',
                  width: MediaQuery.of(context).size.width / 1.6,
                ),
              ),
              // Text('SoClose',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
      // color: Colors.white,
      // child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}
