import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hommie/core/app_export.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set the background messaging handler early on, as a named top-level function
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Hive.initFlutter();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  await Hive.openBox('hommieBox');
  // Get any initial links
  // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  // print('Test init: ${initialLink.toString()}');

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  String? token = await FirebaseMessaging.instance.getToken();
  deviceID = token.toString();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var box = Hive.box('hommieBox');
  bool isGoogleLogin = false;

  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  // Future<void> initDynamicLinks() async {
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     print('Aloooooooooooooooooooooooooooooooooooooooooooooooo');
  //     final Uri uri = dynamicLinkData.link;
  //     final queryParams = uri.path;
  //     log("abc ${queryParams}");
  //     if (queryParams.isNotEmpty) {
  //       if (queryParams == "/success") {
  //         // Navigator.pushAndRemoveUntil(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //       builder: (context) => const SuccessScreen(
  //         //           content:
  //         //           "Nạp tiền thành công. Cảm ơn bạn đã sử dụng dịch vụ",
  //         //           buttonName: "Trang chủ",
  //         //           navigatorPath: '/homeScreen'),
  //         //     ),
  //         //         (route) => false);
  //         print('Thanh toán thành công nè');
  //       } else {
  //         // showFailDialog(
  //         //     context, "Thanh toán không thành công. Vui lòng thử lại sau");
  //         print('Thanh toán thất bại nè');
  //       }
  //     } else {}
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
    isGoogleLogin = (box.get('isGoogleLogin') != null) ? box.get('isGoogleLogin') : false;
    box.put('isLogin', false);
    // initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        fontFamily: 'Roboto',
        primarySwatch: MaterialColor(
          0x00e2994a,
          <int, Color>{
            50: const Color(0x00e2994a).withOpacity(0.05),
            100: const Color(0x00e2994a).withOpacity(0.1),
            200: const Color(0x00e2994a).withOpacity(0.2),
            300: const Color(0x00e2994a).withOpacity(0.3),
            400: const Color(0x00e2994a).withOpacity(0.4),
            500: const Color(0x00e2994a).withOpacity(0.5),
            600: const Color(0x00e2994a).withOpacity(0.6),
            700: const Color(0x00e2994a).withOpacity(0.7),
            800: const Color(0x00e2994a).withOpacity(0.8),
            900: const Color(0x00e2994a).withOpacity(0.9),
          },
        ),
      ),
      title: 'login',
      debugShowCheckedModeBanner: false,
      initialRoute: (!isGoogleLogin) ? AppRoutes.homeScreen : AppRoutes.googleNav,
      routes: AppRoutes.routes,
    );
  }
}
