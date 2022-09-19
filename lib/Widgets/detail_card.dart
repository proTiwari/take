import 'package:flutter/material.dart';
import '../globar_variables/globals.dart' as globals;
import '../globar_variables/const_values.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),

      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(5, 15),
              blurRadius: 5,
              spreadRadius: 3)
        ],
        color: Colors.white,
        // color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                RichText(
                  text:
                      TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          fontWeight: FontWeight.bold,

                        ),
                        text: "Address",
                      ),
                ),
                SizedBox(width: 10,),
                RichText(
                  text:
                  TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,

                    ),
                    text: "211011/ sainik colony/ allahabad",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                RichText(
                  text:
                  TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,

                    ),
                    text: "Property Name",
                  ),
                ),
                SizedBox(width: 10,),
                RichText(
                  text:
                  TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,

                    ),
                    text: "Tiwari family",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: [
                  DataTable(
                      columns: const [

                        DataColumn(
                          label: Text('Rooms'),
                        ),
                        DataColumn(
                          label: Text('Sharing'),
                        ),
                        DataColumn(
                          label: Text('food'),
                        ),
                        DataColumn(
                          label: Text('Amount'),
                        ),
                      ],
                      rows: const [

                        DataRow(cells: [
                          DataCell(Text('1')),
                          DataCell(Text('No')),
                          DataCell(Text('mon-fri\n(2 time)')),
                          DataCell(Text('1000/month')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('1')),
                          DataCell(Text('2 sharing')),
                          DataCell(Text('---')),
                          DataCell(Text('800/month')),
                        ])
                      ],
                  )
                ],
              ),
            )
          ],
        )
      ),

    );
  }
}
