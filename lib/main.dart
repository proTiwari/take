import 'package:flutter/material.dart';
import 'package:take/bottom_nav_bar.dart';
import 'package:take/property_detail.dart';

import 'Widgets/csc.dart';
import 'list_property.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //#FC7676
        primaryColor: Colors.red.shade200
      ),
      debugShowCheckedModeBanner: false,
      home: CustomBottomNavigation(),
    );
  }
}
