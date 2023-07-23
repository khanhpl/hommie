import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hommie/core/app_export.dart';
import 'package:path_provider/path_provider.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
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
      ?.resolvePlatformSpecificImplementation<
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
    flutterLocalNotificationsPlugin?.show(
      notification.hashCode,
      "${notification.title}",
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

void showFlutterNotificationForgeround(RemoteMessage message) {
  // print(message.data);
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    print('vo foreground');
    flutterLocalNotificationsPlugin?.show(
      notification.hashCode,
      "${notification.title!}Foreground",
      notification.body!,
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
 FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  var box = await Hive.openBox('hommieBox');
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  String? token = await FirebaseMessaging.instance.getToken();
  deviceID = token.toString();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute: AppRoutes.googleNav,
      routes: AppRoutes.routes,
    );
  }
}
