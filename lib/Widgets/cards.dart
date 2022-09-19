import 'package:flutter/material.dart';
import 'package:take/Widgets/smaill_card.dart';
import 'package:take/globar_variables/globals.dart' as globals;

import 'filter_card.dart';

class CardsWidget extends StatelessWidget {
  const CardsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(5, 15),
              blurRadius: 5,
              spreadRadius: 3)
        ],
        // color: Colors.white,
        // // color: Theme.of(context).primaryColor,
        // borderRadius: BorderRadius.circular(58),
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: InkWell(
          onTap: () => print("ciao"),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                child: Image.asset(
                    'assets/home.jpg',
                    // width: 300,
                    height: globals.height*0.34,
                    fit:BoxFit.fill
                ),
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: EdgeInsets.fromLTRB(0, 2.0, 2.0, 2.0),
                     child: Row(
                       children: const [
                         SizedBox(
                           height: 31,
                           child: SmallCard("Allahabad"),
                         ),
                         SizedBox(
                           height: 31,
                           child: SmallCard("sainik colony 211011"),
                         ),

                       ],
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.fromLTRB(0, 2.0, 2.0, 2.0),
                     child: Row(
                       children: [
                         SizedBox(
                           height: 31,
                           child: SmallCard("2000/month"),
                         ),
                       ],
                     ),
                   )
                 ],
               ),
             ),
              Divider(
                color: Colors.grey.shade500,
                indent: 10,
                endIndent: 10,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(9, 6, 9, 15),
                child: Row(
                  children: [
                    SizedBox(width: globals.width*0.87,
                        child: Text("Feedback 0"),
                    ),
                RichText(
                  text: TextSpan(
                    text: "0",
                  style: TextStyle(
                  color: Colors.black45,
                      fontSize: 17
                  ),),),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
