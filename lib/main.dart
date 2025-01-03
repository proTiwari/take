import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
//app imports
import 'package:take/app/pages/signin_page/phone_login.dart';
import 'package:take/app/pages/signin_page/sign_in.provider.dart';
import 'package:take/app/pages/signup_page/signup_provider.dart';
import 'package:take/app/pages/splashscreen.dart';
import 'package:take/app/providers/base_providers.dart';
import 'package:take/app/services/database_service.dart';
import 'package:take/app/firebase_functions/firebase_fun.dart';

void main() async {

  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
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
        ChangeNotifierProvider(create: (_) => SignupProvider())
      ],
      child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/':(context) =>  auth.currentUser == null ? LoginApp(): const SplashScreen(),
          },
          // home: auth.currentUser == null ? LoginApp(): const SplashScreen(),
          title: '',
          theme: ThemeData(
              //#FC7676
              visualDensity: VisualDensity.adaptivePlatformDensity,
             // primaryColor: const Color(0xFFF27121),
          ),
          debugShowCheckedModeBanner: false,
        ),
      );
  }
}
