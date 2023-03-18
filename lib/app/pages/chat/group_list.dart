import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/char_services.dart';
import '../../services/database_service.dart';
import '../list_property/flutter_flow/flutter_flow_theme.dart';
import 'chat_page.dart';
import 'group_tile.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({Key? key}) : super(key: key);

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  String userName = "";
  String email = "";
  AuthChatService authService = AuthChatService();
  var groups;
  bool _isLoading = false;
  String groupName = "";
  bool shownomassagetext = false;
  var count = 0;
  bool groupexists = false;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserDatka() async {
    var snap = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    print("sdfsdfsdssssffg${snap}");
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get user {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    var snap;
    try {
      print("sdfsdfsdfs");
      var snapshots = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

      print("sdfsdfgggggggd: ${snapshots.runtimeType}");
      print("kkkm: ${snapshots.forEach((element) {
        snap = element['groups'];
        print(snap);
      })}");
      setState(() {
        groups = snap;
        try {
          // print("sdfsfsdfsds${snapshots["groups"]}");
        } catch (e) {
          setState(() {
            shownomassagetext = true;
          });
        }
      });
    } catch (e) {
      setState(() {
        shownomassagetext = true;
      });
      print("sdfsdfs${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text("chats", style: TextStyle(color: Colors.black)),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      body: groupList(),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a group",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        )
                      : TextField(
                          onChanged: (val) {
                            setState(() {
                              groupName = val;
                            });
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     if (groupName != "") {
                //       setState(() {
                //         _isLoading = true;
                //       });
                //       DatabaseService(
                //               uid: FirebaseAuth.instance.currentUser!.uid, "sdfs")
                //           .createGroup(userName,
                //               FirebaseAuth.instance.currentUser!.uid, groupName)
                //           .whenComplete(() {
                //         _isLoading = false;
                //       });
                //       Navigator.of(context).pop();
                //       showSnackbar(
                //           context, Colors.green, "Group created successfully.");
                //     }
                //   },
                //   style: ElevatedButton.styleFrom(
                //       primary: Theme.of(context).primaryColor),
                //   child: const Text("CREATE"),
                // )
              ],
            );
          }));
        });
  }

  getprofile(groupId) async {
    print("oifjoiejf");
    try {
      await FirebaseFirestore.instance
          .collection("groups")
          .doc(groupId)
          .get()
          .then((value) {
        var list = value.get("members");
        print(list);
        for (var i in list) {
          if (i != FirebaseAuth.instance.currentUser!.uid) {
            try {
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(i)
                  .get()
                  .then((value) {
                String profileimage = value.get("profileImage");
                print("this is profile image: ${profileimage}");
                return profileimage;
              });
            } catch (e) {
              print("error In group list:: $e");
            }
          }
        }
      });
    } catch (e) {
      print("group_list:: $e");
    }
  }

  groupList() {
    //FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots()
    try {
      var width = MediaQuery.of(context).size.width;
      return Container(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("groups")
              .where("membersuid",
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            // print("snapshotPP: ${snapshot.data.docs}");
            // var data = snapshot.data.docs;

            // var dat = snapshot.data.documents.map((e) => Customers_items.fromJson(e.data)).toList();
            try {
              int reverseIndex;
              // print("sdfsdfsddewreww${snapshot.data["groups"]}");
              // make some checks
              print("snapshot: ${snapshot.hasData}");
              if (snapshot.data.docs.length == 0) {
                return noGroupWidget();
              }

              if (snapshot.hasData) {
                try {
                  print("ijeiw ${snapshot.data.docs}");
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      reverseIndex = snapshot.data.docs.length - index - 1;
                      print("fowekfw");
                      var recentmessage =
                          snapshot.data.docs[reverseIndex]["recentMessage"];
                      print("fowekfw");
                      var recentmessagesendby = snapshot.data.docs[reverseIndex]
                          ["recentMessageSender"];
                      print("fowekfw");
                      var owneruid;
                      print("fowekfw");

                      var profileimage =
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
                      if (snapshot.data.docs[reverseIndex]['profileImage1']
                              .toString()
                              .split("(*/*/*)")[1] ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        profileimage = snapshot
                            .data.docs[reverseIndex]['profileImage2']
                            .toString()
                            .split("(*/*/*)")[0];
                      } else {
                        profileimage = snapshot
                            .data.docs[reverseIndex]['profileImage1']
                            .toString()
                            .split("(*/*/*)")[0];
                      }
                      var userName = FirebaseAuth.instance.currentUser!.uid;
                      var groupName =
                          snapshot.data.docs[reverseIndex]['groupName'];
                      var groupId = snapshot.data.docs[reverseIndex]['groupId'];
                      for (var i in snapshot.data.docs[reverseIndex]
                          ['members']) {
                        if (i != FirebaseAuth.instance.currentUser!.uid) {
                          owneruid = i;
                        }
                      }
                      ;
                      var countnumber = 0;
                      try {
                        countnumber = snapshot.data.docs[reverseIndex]['count'];
                      } catch (e) {
                        countnumber = 0;
                        print("count feild does not exist: ${e.toString()}");
                      }

                      return Container(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        margin: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: width < 800 ? 10 : width * 0.24),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              Future.delayed(const Duration(milliseconds: 0),
                                  () async {
                                var bcount = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                        owneruid: owneruid,
                                        groupId: groupId,
                                        groupName: groupName,
                                        userName: userName,
                                        profileImage: profileimage),
                                  ),
                                );

                                setState(() {
                                  countnumber = bcount;
                                });
                              });
                            } catch (e) {
                              print("grouptilenavigationerror: ${e}");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    CachedNetworkImageProvider(profileimage),
                                child: Text(
                                  groupName.substring(0, 1).toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              title: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              groupName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          recentmessage == null
                                              ? const Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              : Align(
                                                  alignment: Alignment.topLeft,
                                                  child: recentmessagesendby ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                      ? Text(
                                                          "You: ${recentmessage}"
                                                              .toString()
                                                              .trim()
                                                              .replaceAll(
                                                                  "\n", "  "),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        )
                                                      : Text(
                                                          "${recentmessage}"
                                                              .toString()
                                                              .trim()
                                                              .replaceAll(
                                                                  "\n", "  "),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    countnumber != 0
                                        ? Expanded(
                                            child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.green,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "$countnumber",
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.green,
                                                          fontSize: 12,
                                                        ),
                                              ),
                                            ),
                                          ))
                                        : Container()
                                  ],
                                ),
                              ),
                              // subtitle: Text(
                              //   "Join the conversation as ${widget.userName}",
                              //   style: const TextStyle(fontSize: 13),
                              // ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  return Container();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                );
              }
            } catch (e) {
              return noGroupWidget();
            }
          },
        ),
      );
    } catch (e) {
      return const Center(child: CircularProgressIndicator());
    }
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          // GestureDetector(
          //   onTap: () {
          //     popUpDialog(context);
          //   },
          //   child: Icon(
          //     Icons.add_circle,
          //     color: Colors.grey[700],
          //     size: 75,
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "There is no chat with the property owner!",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
