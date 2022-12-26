import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
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

import 'app/models/user_model.dart';
import 'app/pages/responsive_layout.dart';

void main() async {

  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
