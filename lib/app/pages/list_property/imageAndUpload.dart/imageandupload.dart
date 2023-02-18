import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../app_state.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../flutter_flow/upload_media.dart';

class UploadProperty extends StatefulWidget {
  const UploadProperty({Key? key}) : super(key: key);

  @override
  _UploadPropertyState createState() => _UploadPropertyState();
}

class _UploadPropertyState extends State<UploadProperty> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  bool loading = false;
  String image = '';
  List imagelist = [];
  List<dynamic> downloadUrl = [];

  bool isMediaUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  uploadImage() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    if (imagelist.isNotEmpty) {
      try {
        for (var i = 0; i < imagelist.length; i++) {
          var file = imagelist[i];
          final firebaseStorage = FirebaseStorage.instance;

          if (file != null) {
            //Upload to Firebase
            var snapshot;
            try {
              var pathpass = generateRandomString(34);
              var selectedImage = File(file);
              print(file);
              snapshot = await firebaseStorage
                  .ref()
                  .child('property/$uid/$pathpass')
                  .putFile(selectedImage)
                  .whenComplete(() =>
                      {print("success....................................")});
            } catch (e) {
              loading = false;
              print("failed....................................");
              print(e);
            }

            var download = await snapshot.ref.getDownloadURL();
            downloadUrl.add(download);
            print(downloadUrl);
          } else {}
        }
        print("urllll: ${downloadUrl}");
      } catch (e) {}
    } else {
      showToast(
        "atleast one property image is needed!",
        context: context,
        animation: StyledToastAnimation.none,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: imagelist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CircleAvatar(
                          radius: 50.0,
                          backgroundImage: FileImage(File(imagelist[index])),
                        );
                        // Image.network(
                        //   'https://picsum.photos/seed/460/600',
                        //   width: 100,
                        //   height: 100,
                        //   fit: BoxFit.cover,
                        // );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    // alignment: AlignmentDirectional(0, 2.5),
                    child: InkWell(
                      onTap: () async {
                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          maxWidth: 700.00,
                          maxHeight: 500.00,
                          imageQuality: 0,
                          allowPhoto: true,
                        );
                        print(
                            "yyyyyyyyyyyyy: ${selectedMedia!.first.filePath}");
                        setState(() {
                          image = selectedMedia!.first.filePath!;
                          imagelist.add(image);
                        });
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          setState(() => isMediaUploading = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];
                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                    ))
                                .toList();
                          } finally {
                            isMediaUploading = false;
                          }
                          if (selectedUploadedFiles.length ==
                              selectedMedia.length) {
                            setState(() {
                              uploadedLocalFile = selectedUploadedFiles.first;
                              print("uuuuuuuuuuuuu: ${uploadedLocalFile}");
                            });
                          } else {
                            setState(() {});
                            return;
                          }
                        }
                      },
                      child: Material(
                        color: Color.fromARGB(0, 105, 83, 83),
                        elevation: 0,
                        shape: const CircleBorder(),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Icon(
                              Icons.add_a_photo,
                              color: FlutterFlowTheme.of(context).grayIcon,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 10),
                      child: InkWell(
                        onTap: () async {
                          try {
                            if (imagelist.isNotEmpty) {
                              setState(() {
                                loading = true;
                              });
                              var propertyid = generateRandomString(24);
                              await uploadImage();

                              final cityCreateData = createCityRecordData(
                                advancemoney:
                                    FFAppState().advanceMoney.toString(),
                                amount: FFAppState().sellerform
                                    ? FFAppState().selleramount
                                    : FFAppState().amountrange,
                                areaofland: FFAppState().areaofland,
                                city: FFAppState().cityname,
                                description: FFAppState().description,
                                email: FFAppState().email,
                                foodservice:
                                    FFAppState().foodService.toString(),
                                mobilenumber: FFAppState().phone,
                                numberoffloors: FFAppState().numberoffloors,
                                numberofrooms: FFAppState().numberofrooms,
                                pincode: FFAppState().pincode,
                                propertyname: FFAppState().propertyname,
                                servicetype: FFAppState().serviceType,
                                sharing: FFAppState().sharingcount,
                                state: '',
                                streetaddress: FFAppState().streetaddress,
                                wantto: FFAppState().sellerform
                                    ? 'Sell property'
                                    : 'Rent property',
                                ownername: FFAppState().name,
                                paymentduration: FFAppState().payingduration,
                                profileImage: '',
                                propertyId: propertyid,
                                whatsappnumber: FFAppState().phone,
                                uid: FirebaseAuth.instance.currentUser!.uid,
                                lat: FFAppState().lat,
                                lon: FFAppState().lon,
                                areaoflandunit: FFAppState().areaoflandunit,
                              );
                              await CityRecord.collection
                                  .doc(propertyid)
                                  .set(cityCreateData)
                                  .onError((error, stackTrace) {
                                loading = false;
                                print(error);
                                print(stackTrace);
                                showToast(error.toString(), context: context);
                              });
                              await FirebaseFirestore.instance
                                  .collection("City")
                                  .doc(propertyid)
                                  .update({
                                "propertyimage": downloadUrl
                              }).whenComplete(() {
                                setState(() {
                                  loading = false;
                                  showToast("Successfully uploaded",
                                      context: context);
                                });
                              });
                            } else {
                              showToast("Atleast one image is necessary",
                                  context: context);
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          alignment:
                              AlignmentDirectional(0, -0.44999999999999996),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: loading
                                ? const Center(
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        )))
                                : Text(
                                    'Upload Property',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
