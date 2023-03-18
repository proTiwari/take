import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:flutter_autoupdate/flutter_autoupdate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:version/version.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:take/app/Widgets/update.dart';
import 'package:take/app/globar_variables/globals.dart';
import 'package:take/app/pages/chat/group_list.dart';
import 'package:take/app/pages/list_property/list_property.dart';
import 'package:take/app/pages/explore_page/search.dart';
import 'package:take/app/pages/signin_page/phone_login.dart';
import 'package:take/app/providers/base_providers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../firebase_functions/firebase_fun.dart';
import '../notificationservice/local_notification_service.dart';
import '../pages/chat/chat_page.dart';
import '../pages/list_property/flutter_flow/flutter_flow_theme.dart';
import '../pages/list_property/flutter_flow/lat_lng.dart';
import '../pages/list_property/home_page/home_page_widget.dart';
import '../pages/list_property/search_place_provider.dart';
import '../pages/profile_page/profile_page.dart';
import '../globar_variables/globals.dart' as globals;
import '../pages/property_detail/property_detail.dart';
import '../services/deeplink_service.dart';
import '../services/location_services.dart';

class CustomBottomNavigation extends StatefulWidget {
  String profile;
  var secondcall;
  CustomBottomNavigation(
    city,
    this.secondcall,
    this.profile,
  );

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class valuenotic {
  ValueNotifier<LatLng> valuenoticifierlatlong =
      ValueNotifier(LatLng(0.0, 0.0));
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  late int pageIndex = 0;
  var profilepage;
  String? _currentAddress;
  Position? _currentPosition;

  final pages = [
    Search(city, secondcall),
    const GroupListPage(),
    const ListPropertyPage(),
    const ProfilePage(),
    LoginApp()
  ];
  BaseProvider? _userProvider;
  var count = 0;
  var totalchatcount = 0;

  @override
  void initState() {
    super.initState();
    // updatefun();
     FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        try {
          print("FirebaseMessaging.instance.getInitialMessage");
          if (message != null) {
            print("New Notification");
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

    getgroups();
    countfeature();
    checkVersion();
    checkinternet();
    getuser();
    locationcheck();
    // initPlatformState();
    deeplink();
    // locationcheck();
    calculateMessageCount();
    if (widget.secondcall == "uploadproperty") {
      setState(() {
        pageIndex = 2;
      });
    }
    if (widget.secondcall == "login") {
      setState(() {
        pageIndex = 4;
      });
    }
    if (widget.profile == 'profile') {
      setState(() {
        pageIndex = 3;
      });
    }
  }

  var groups = [];
  getgroups() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      groups = value.data()!['groups'];
    });
  }

  countfeature() async {
    print("groups: ${groups}");
    try {
      List sd = [];
      for (var i in groups) {
        try {
          i = i.toString().split("_")[0];
          print("groups id: ${i}");
          var snapshot = await FirebaseFirestore.instance
              .collection("groups")
              .doc(i)
              .collection("messages")
              .snapshots();
          snapshot.forEach((element) async {
            try {
              print("iwjeofiwj: 1");
              print("elementsnn: ${element.docs}");
              count = 0;
              for (var j in element.docs) {
                try {
                  if (j['sender'] != FirebaseAuth.instance.currentUser!.uid) {
                    print("yyyyyyyyy: ${j['status']}");
                    if (j['status'] != true) {
                      setState(() {
                        count += 1;
                      });
                    }
                  }
                } catch (e) {
                  print("wjoefjw: $e");
                }
              }
              sd.add(count);
              print("yusyuwyue: ${sd}");
              await FirebaseFirestore.instance
                  .collection("groups")
                  .doc(i)
                  .update({"count": count});
            } catch (e) {
              print("iwjef: $e");
            }
          });
        } catch (e) {
          print('ijfow: $e');
        }
      }
    } catch (e) {
      print("jiuhh: ${e.toString()}");
    }
  }

  bool update = false;
  bool result = true;
  checkinternet() async {
    result = await InternetConnectionChecker().hasConnection;
    setState(() {
      result;
    });
    if (result == true) {
      // print('YAY! Free cute dog pics!');
    } else {
      showToast("No internet connection");
      print('No internet :( Reason:');
      print(InternetConnectionChecker().onStatusChange);
      setState(() {
        result;
      });
    }
  }

  final _checker = AppVersionChecker();
  void checkVersion() async {
    if (result) {
      _checker.checkUpdate().then((value) {
        print("version on play store starts from here");
        print(value.canUpdate); //return true if update is available
        print(value.currentVersion); //return current app version
        if (value.errorMessage == null) {
          if (value.currentVersion.toString() != value.newVersion.toString()) {
            setState(() {
              update = true;
            });
          }
        }

        print(value.newVersion); //return the new app version
        print(value.appURL); //return the app url
        print("error: ${value.errorMessage}");
        print("error: ${value.errorMessage.runtimeType}");
        //return error message if found else it will return null
      });
    }
  }

  updatefun() {
    try {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
        String appName = packageInfo.appName;
        String packageName = packageInfo.packageName;
        String version = packageInfo.version;
        String buildNumber = packageInfo.buildNumber;
        print("version: ${version}");
        String presentversion = "";
        await FirebaseFirestore.instance
            .collection("Controllers")
            .doc('variables')
            .get()
            .then((value) {
          presentversion = value.data()!['updateversion'].toString();
        });
        if (presentversion != "") {
          if (version.toString() != presentversion) {
            print("presentversion: ${presentversion}");
            setState(() {
              update = true;
            });
          }
        }
      });
    } catch (e) {
      print("update fun error: ${e.toString()}");
    }

    // FirebaseFirestore.instance.collection("Users").
  }

  var referralCode;

  void deeplink() async {
    final deepLinkRepo = DeepLinkService.instance;
    referralCode = deepLinkRepo?.referrerCode.value;
    print(
        "sddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd $referralCode");
  }

  // UpdateResult? _result;
  // DownloadProgress? _download;
  var _startTime = DateTime.now().millisecondsSinceEpoch;
  var _bytesPerSec = 0;

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   UpdateResult? result;

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   if (Platform.isAndroid || Platform.isIOS) {
  //     var status = await Permission.storage.status;
  //     if (status.isDenied) {
  //       await Permission.storage.request();
  //     }
  //   }

  //   var versionUrl;
  //   if (Platform.isAndroid) {
  //     versionUrl =
  //         'https://storage.googleapis.com/download-dev.feedmepos.com/version_android_sample.json';
  //   } else if (Platform.isWindows) {
  //     versionUrl =
  //         'https://storage.googleapis.com/download-dev.feedmepos.com/version_windows_sample.json';
  //   }

  //   /// Android/Windows
  //   var manager = UpdateManager(versionUrl: versionUrl);

  //   /// iOS
  //   // var manager = UpdateManager(appId: 1500009417, countryCode: 'my');
  //   print("started kkklll");
  //   try {
  //     result = await manager.fetchUpdates();
  //     setState(() {
  //       _result = result;
  //     });
  //     if (Version.parse('1.1.0+15') < result?.latestVersion) {
  //       var controller = await result?.initializeUpdate();
  //       print("latest version kk:${result?.latestVersion}");
  //       controller?.stream.listen((event) async {
  //         setState(() {
  //           if (DateTime.now().millisecondsSinceEpoch - _startTime >= 1000) {
  //             _startTime = DateTime.now().millisecondsSinceEpoch;
  //             _bytesPerSec = event.receivedBytes - _bytesPerSec;
  //           }
  //           _download = event;
  //         });
  //         if (event.completed) {
  //           print("Downloaded completed");
  //           await controller.close();
  //           await result?.runUpdate(event.path, autoExit: true);
  //         }
  //       });
  //     } else {
  //       print("latest version:${result?.latestVersion}");
  //     }
  //   } on Exception catch (e) {
  //     print("sdjflksd${e}");
  //   }
  // }

  updatedeviceid() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"devicetoken": fcmToken});
      print("fcmToken: ${fcmToken}");
    } catch (e) {
      print("fmcToken: ${e.toString()}");
    }
    return;
  }

  calculateMessageCount() async {
    try {
      var groupidlist = [];
      var countchat = 0;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        groupidlist = value.data()!["groups"];
      });
      for (var i in groupidlist) {
        i = i.toString().split("_")[0];
        try {
          await FirebaseFirestore.instance
              .collection("groups")
              .doc(i)
              .collection("messages")
              .get()
              .then((value) {
            for (var i in value.docs) {
              if (i['sender'] != FirebaseAuth.instance.currentUser!.uid) {
                print("yyyyyyyyy: ${i['status']}");
                if (i['status'] != true) {
                  setState(() {
                    count += 1;
                  });
                }
              }
            }
            if (count > 0) {
              countchat += 1;
              count = 0;
            }
          });
        } catch (e) {
          print(e.toString());
        }
      }
      setState(() {
        totalchatcount = countchat;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  locationcheck() async {
    await updatedeviceid();
  }

  void getuser() async {
    try {
      _userProvider = Provider.of<BaseProvider>(context, listen: false);
      await _userProvider!.refreshUser();
    } catch (e) {
      print(e.toString());
    }
  }

  // void _moveToScreen2(BuildContext context) => Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => CustomBottomNavigation(globals.city, "", "")));

  void _moveToScreen2(BuildContext context) {
    try {
      if (pageIndex != 0) {
        setState(() {
          pageIndex = 0;
        });
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(''),
            content: const Text('Do You Want To Exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  exit(0);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      }

      // context.pushNamed('customnav');
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             CustomBottomNavigation(globals.city, "", "")));
    } catch (e) {
      print(e.toString());
    }
  }

  navigatefun(BuildContext context) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CustomBottomNavigation(globals.city, "", ""),
        ),
      );

  // onWillPop: () async {
  //   _moveToScreen2(
  //     context,
  //   );
  //   return false;
  // },
  @override
  Widget build(BuildContext context) {
    // countfeature();
    // checkinternet();
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        _moveToScreen2(
          context,
        );
        return false;
      },
      child: result
          ? Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              body: update
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                      child: SizedBox(height: 230, child: Update()),
                    )
                  : pages[pageIndex],
              bottomNavigationBar: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 0, horizontal: width < 800 ? 8 : width * 0.24),
                height: 70,
                // decoration: BoxDecoration(
                //   boxShadow: const [
                //     BoxShadow(
                //         color: Color.fromARGB(255, 248, 243, 243),
                //         offset: Offset(9, 8),
                //         blurRadius: 2,
                //         spreadRadius: 2),
                //     BoxShadow(
                //         color: Color.fromARGB(255, 205, 202, 202),
                //         offset: Offset(5, 15),
                //         blurRadius: 5,
                //         spreadRadius: 3)
                //   ],
                //   color: const Color.fromARGB(255, 255, 255, 255),
                //   // color: Theme.of(context).primaryColor,
                //   borderRadius: BorderRadius.circular(22),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: pageIndex == 0
                            ? FlutterFlowTheme.of(context).alternate
                            : Colors.white,
                      ),
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () async {
                          getgroups();
                          countfeature();
                          final deepLinkRepo = await DeepLinkService.instance;
                          referralCode = await deepLinkRepo?.referrerCode.value;
                          setState(() {
                            print(referralCode);
                            print(
                                "hello there: ${FirebaseAuth.instance.currentUser}");
                            if (FirebaseAuth.instance.currentUser != null) {
                              pageIndex = 0;
                            }
                            pageIndex = 0;
                          });
                        },
                        icon: Column(
                          children: [
                            Image.asset(
                              "assets/search.png",
                              color: pageIndex == 0
                                  ? Colors.white
                                  : const Color(0xfff24086a),
                              height: 30,
                            ),
                            Text(
                              "Search",
                              style: GoogleFonts.poppins(
                                  color: pageIndex == 0
                                      ? Colors.white
                                      : const Color(0xfff24086a),
                                  fontSize: 8),
                            )
                          ],
                        ),
                      ),
                    ),
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 6.9, 0, 0),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: pageIndex == 1
                                ? FlutterFlowTheme.of(context).alternate
                                : Colors.white,
                          ),
                          child: IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              getgroups();
                              countfeature();
                              setState(() {
                                if (FirebaseAuth.instance.currentUser == null) {
                                  pageIndex = 4;
                                } else {
                                  pageIndex = 1;
                                }
                                totalchatcount = 0;
                              });
                            },
                            icon: Column(
                              children: [
                                Image.asset(
                                  "assets/chatpp.png",
                                  color: pageIndex == 1
                                      ? Colors.white
                                      : const Color(0xfff24086a),
                                  height: 30,
                                ),
                                Text(
                                  "Chat",
                                  style: GoogleFonts.poppins(
                                      color: pageIndex == 1
                                          ? Colors.white
                                          : const Color(0xfff24086a),
                                      fontSize: 8),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      pageIndex != 1
                          ? totalchatcount == 0
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(35, 0, 0, 0),
                                  child: Align(
                                      alignment:
                                          AlignmentDirectional(-10, -0.7),
                                      child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          child: Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                '$totalchatcount',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontSize: 11,
                                                        ),
                                              ),
                                            ),
                                          ))),
                                )
                          : Container()
                    ]),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: pageIndex == 2
                            ? FlutterFlowTheme.of(context).alternate
                            : Colors.white,
                      ),
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            if (FirebaseAuth.instance.currentUser == null) {
                              pageIndex = 4;
                            } else {
                              pageIndex = 2;
                            }
                          });
                        },
                        icon: Column(
                          children: [
                            Image.asset(
                              "assets/list.png",
                              color: pageIndex == 2
                                  ? Colors.white
                                  : const Color(0xfff24086a),
                              height: 30,
                            ),
                            Text(
                              "Add",
                              style: GoogleFonts.poppins(
                                  color: pageIndex == 2
                                      ? Colors.white
                                      : const Color(0xfff24086a),
                                  fontSize: 8),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: pageIndex == 3
                              ? FlutterFlowTheme.of(context).alternate
                              : Colors.white),
                      child: IconButton(
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                            if (FirebaseAuth.instance.currentUser == null) {
                              pageIndex = 4;
                            } else {
                              pageIndex = 3;
                            }
                          });
                        },
                        icon: Column(
                          children: [
                            Image.asset(
                              "assets/me.png",
                              color: pageIndex == 3
                                  ? Colors.white
                                  : const Color(0xfff24086a),
                              height: 30,
                            ),
                            Text(
                              "Me",
                              style: GoogleFonts.poppins(
                                  color: pageIndex == 3
                                      ? Colors.white
                                      : const Color(0xfff24086a),
                                  fontSize: 8),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              body: Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                child: Container(
                  height: 250,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  child: AlertDialog(
                    title: const Text('Please check your internet connection!'),
                    content: Column(
                      children: const [
                        // Text('- update now to enjoy new features'),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Retry'),
                        onPressed: () {
                          checkinternet();
                        },
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
