import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take/pages/signin_page/signin__page.dart';
import 'package:take/globar_variables/globals.dart' as globals;
import '../Widgets/bottom_nav_bar.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool direction = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delay();
  }

  void delay() async {
    String? getStudentInformationEndpoint = "";
    try {
      var prefs = await SharedPreferences.getInstance();
      // SharedPreferences.setMockInitialValues({});
      getStudentInformationEndpoint = prefs.getString('login');
      print("getStudentInformation: ${getStudentInformationEndpoint}");
      if (prefs.getString('login') != null) {
        direction = true;
      }
    } catch (e) {
      print("error in splashscreen : $e");
    }

    // await GetStudentAccessToken()
    //     .getStudentAcessToken(getStudentInformationEndpoint);
    //globals.direction
    if (true) {
      Future.delayed(const Duration(seconds: 2)).then((value) => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CustomBottomNavigation("City")))
      });
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()))
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(

            height: 220.0,
            width: 220.0,
            child: Image.asset('assets/runforrent1.png')),
      ),
    );
  }
}
