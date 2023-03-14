import 'dart:io';
import 'package:take/app/pages/list_property/flutter_flow/flutter_flow_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
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
                await launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.runforrent.take'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
