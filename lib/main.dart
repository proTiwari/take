import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take/Widgets/bottom_nav_bar.dart';
import 'package:take/pages/explore_page/search.dart';
import 'package:take/pages/property_detail/property_detail.dart';
import 'package:take/pages/signin_page/phone_login.dart';
import 'package:take/pages/signin_page/sign_in.provider.dart';
import 'package:take/pages/signup_page/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:take/pages/splashscreen.dart';
import 'package:take/providers/base_providers.dart';
import 'Widgets/csc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/list_property/list_property.dart';
import 'pages/signin_page/signin__page.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseProvider()),
        ChangeNotifierProvider(create: (_) => SigninProvider())
      ],
      child: ScreenUtilInit(
        builder: (_, __) => MaterialApp(
          title: '',
          theme: ThemeData(
              //#FC7676
              primaryColor: Color(0xFFF27121)),
          debugShowCheckedModeBanner: false,
          home: CustomBottomNavigation(""),//LoginApp("phone")
        ),
      ),
    );
  }
}
