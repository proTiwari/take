import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:take/app/globar_variables/globals.dart' as globals;
import 'chat/chat_page.dart';
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
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

   
    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print("huihiuhiu");
        // try {
        //   print("FirebaseMessaging.onMessage.listen${message.data}");
        //   if (message.notification != null) {
        //     print(message.notification!.title);
        //     print(message.data);
        //     print("message1 ${message.data}");
        //     LocalNotificationService.createanddisplaynotification(message);
        //     if (message.data['navigator'] == '') {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => ChatPage(
        //             groupId: message.data['groupId'],
        //             groupName: message.data['groupName'],
        //             userName: message.data['userName'],
        //             profileImage: message.data['profileImage'],
        //             owneruid: message.data['ownerId'],
        //           ),
        //         ),
        //       );
        //     }
        //   }
        // } catch (e) {
        //   print("firebasemessaging error: ${e.toString()}");
        // }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        try {
          print("FirebaseMessaging.onMessageOpenedApp.listen");
          if (message.notification != null) {
            print(message.notification!.title);
            print(message.notification!.body);
            print("message.data22 ${message.data}");
            if (message.data['navigator'] == '') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    groupId: message.data['groupId'],
                    groupName: message.data['groupName'],
                    userName: message.data['userName'],
                    profileImage: message.data['profileImage'],
                    owneruid: message.data['ownerId'],
                  ),
                ),
              );
            }
          }
        } catch (e) {
          print("messaging error: ${e.toString()}");
        }
      },
    );

    Timer(
        Duration(seconds: 2),
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
              height: 230.0,
              width: 230.0,
              child: Image.asset('assets/rfr15.png')),
        ),
      ),
    );
  }
}
