import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:take/app/globar_variables/globals.dart' as globals;
//app imports
import 'package:take/app/pages/signin_page/phone_login.dart';
import 'package:take/app/pages/signin_page/sign_in.provider.dart';
import 'package:take/app/pages/signup_page/signup_provider.dart';
import 'package:take/app/pages/splashscreen.dart';
import 'package:take/app/providers/base_providers.dart';
import 'package:take/app/services/database_service.dart';
import 'package:take/app/firebase_functions/firebase_fun.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'app/models/user_model.dart';
import 'app/notificationservice/local_notification_service.dart';
import 'app/pages/responsive_layout.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    print(notification);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("onMessageOpenedApp: $message");
  });

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    print("onBackgroundMessage: $message");
  });
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'image',
      channelName: 'runforrent',
      channelDescription: "runforrent",
      enableLights: true,
      playSound: true,
      locked: true,
      defaultColor: Colors.green,
    )
  ]);

  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  LocalNotificationService.initialize();
  try {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    globals.devicetoken = fcmToken;
    print("token: ${fcmToken}");
    FirebaseFirestore.instance
        .collection('DeviceToken')
        .doc(fcmToken)
        .set({"deviceToken": fcmToken});
  } catch (e) {
    print("fcmtoken error: ${e.toString()}");
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message}');
    }
  });

  runApp(const riverpod.ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseService("")),
        ChangeNotifierProvider(create: (_) => FirebaseServices()),
        ChangeNotifierProvider(create: (_) => BaseProvider()),
        ChangeNotifierProvider(create: (_) => SigninProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        StreamProvider<UserModel?>.value(
          value: FirebaseServices().currentUserDetails,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        // initialRoute: '/',
        // routes: {
        //   '/':(context) =>  auth.currentUser == null ? LoginApp(): const SplashScreen(),
        // },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: SplashScreen(),
                  webScreenLayout: SplashScreen(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const SplashScreen();
          },
        ),
        title: '',
        theme: ThemeData(
          //#FC7676
          // visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: const Color(0xFFF27121),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
