import 'package:flutter/material.dart';
import 'package:take/Widgets/contact_detail.dart';
import 'package:take/Widgets/detail_button.dart';
import 'package:take/Widgets/detail_card.dart';

import '../../Widgets/Image_animation.dart';

class Property extends StatefulWidget {
  const Property({Key? key}) : super(key: key);

  @override
  State<Property> createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: const [
              ImageAnimation(),
              SizedBox(
                height: 15,
              ),
              DetailCard(),
              ContactDetail(),
            ],
          ),
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(6.0),
          child: DetailButton(),
        ),
      ),
    );
  }
}
