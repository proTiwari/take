import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:take/app/globar_variables/globals.dart' as globals;
import 'list_property/flutter_flow/flutter_flow_util.dart';
import 'list_property/search_place_provider.dart';

// optional distance parameter. Default is 1.0

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool direction = false;

  @override
  void initState() {
    super.initState();
    CurrentLocation().getCurrentPosition();
    Timer(
        Duration(seconds: 0),
        () => {
              context.pushNamed(
                'customnav',
                queryParams: {
                  'city': serializeParam(
                    '${globals.city}',
                    ParamType.String,
                  ),
                  'secondcall': serializeParam(
                    'Prayagraj',
                    ParamType.String,
                  ),
                  'profile': serializeParam(
                    'Prayagraj',
                    ParamType.String,
                  )
                }.withoutNulls,
                extra: <String, dynamic>{
                  kTransitionInfoKey: const TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 600),
                  ),
                },
              )
            });

    // delay();
  }

  delay() async {
    if (FirebaseAuth.instance.currentUser != null) {
      globals.logined = true;
      try {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) => {
                  globals.userdata = value,
                });
      } catch (e) {
        if (kDebugMode) {
          print("getuser error: ${e.toString()}");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
              height: 200.0,
              width: 200.0,
              child: Image.asset('assets/white_back_black_front.png')),
        ),
      ),
    );
  }
}
