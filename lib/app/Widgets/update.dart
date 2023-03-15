import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:take/app/pages/list_property/flutter_flow/flutter_flow_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_store/open_store.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      child: AlertDialog(
        title: const Text('Update is available!'),
        content: Column(
          children: const [
            Text('- update now to enjoy new features'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Exit'),
            onPressed: () {
              exit(0);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Update'),
            onPressed: () async {
              OpenStore.instance.open(
                  // appStoreId: '284815942', // AppStore id of your app for iOS
                  // appStoreIdMacOS:
                  //     '284815942', // AppStore id of your app for MacOS (appStoreId used as default)
                  androidAppBundleId:
                      'com.runforrent.take', // Android app bundle package name
                  // windowsProductId:
                  //     '9NZTWSQNTD0S' // Microsoft store id for Widnows apps
                  );
              // await launchUrl(Uri.parse(
              //     'https://play.google.com/store/apps/details?id=com.runforrent.take'));
            },
          ),
        ],
      ),
    ));
  }
}
