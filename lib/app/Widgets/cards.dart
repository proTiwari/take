import 'package:flutter/material.dart';
import 'package:take/app/Widgets/smaill_card.dart';
import 'package:take/app/globar_variables/globals.dart' as globals;
import 'package:take/app/pages/property_detail/property_detail.dart';

import '../pages/list_property/flutter_flow/flutter_flow_theme.dart';

class CardsWidget extends StatefulWidget {
  var property;
  CardsWidget(this.property, {Key? key}) : super(key: key);

  @override
  State<CardsWidget> createState() => _CardsWidgetState();
}

class _CardsWidgetState extends State<CardsWidget> {
  var property = '';

  var firstpropertyimage;
  @override
  Widget build(BuildContext context) {
    try {
      firstpropertyimage = widget.property['propertyimage'][0];
    } catch (e) {
      firstpropertyimage =
          'https://icons.iconarchive.com/icons/paomedia/small-n-flat/256/house-icon.png';
    }

    final width = MediaQuery.of(context).size.width;
    if (widget.property['wantto'] == 'Rent property') {
      setState(() {
        property = "Rental property";
      });
    } else {
      setState(() {
        property = 'Seller property';
      });
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 12),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 0, horizontal: width < 800 ? 6 : width * 0.24),
        // margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Property(detail: widget.property)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                child: Image.network(
                  firstpropertyimage,
                  height: 200,
                  fit: width < 800 ? BoxFit.cover : BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2.0, 2.0, 2.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 31,
                              child: SmallCard(
                                  "${widget.property['city']}"), //widget.property['city']
                            ),
                            SizedBox(
                              height: 31,
                              child: widget.property['wantto'] ==
                                      'Rent property'
                                  ? SmallCard(
                                      "₹${widget.property['amount']}/${widget.property['paymentduration']}")
                                  : SmallCard(
                                      "₹${widget.property['amount']}/-"), //widget.property['streetaddress']
                            ),
                            SizedBox(
                              height: 31,
                              child: SmallCard(
                                  "$property"), //widget.property['streetaddress']
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2.0, 2.0, 2.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 31,
                              child: SmallCard(
                                  "${widget.property['streetaddress']}"), //
                            ),
                            SizedBox(
                              height: 31,
                              child:
                                  SmallCard("${widget.property['pincode']}"), //
                            ),
                            SizedBox(
                              height: 31,
                              child: SmallCard(
                                  "${widget.property['whatsappnumber']}"), //
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Divider(
              //   color: Colors.grey.shade500,
              //   indent: 10,
              //   endIndent: 10,
              // ),
              //
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(9, 6, 9, 15),
              //   child: Row(
              //     children: [
              //       SizedBox(width: globals.width*0.87,
              //           child: Text("Feedback 0"),
              //       ),
              //   RichText(
              //     text: TextSpan(
              //       text: "0",
              //     style: TextStyle(
              //     color: Colors.black45,
              //         fontSize: 17
              //     ),),),
              //       Icon(
              //         Icons.star,
              //         color: Colors.yellow,
              //         size: 20.0,
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
