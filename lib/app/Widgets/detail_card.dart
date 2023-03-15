import 'package:flutter/material.dart';

import '../pages/list_property/flutter_flow/flutter_flow_theme.dart';

class DetailCard extends StatelessWidget {
  var detail;
  DetailCard(this.detail, {Key? key}) : super(key: key);
  bool rent = false;
  @override
  Widget build(BuildContext context) {
    if (detail["wantto"] == "Rent property") {
      rent = true;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 0, spreadRadius: 0)
        ],
        color: FlutterFlowTheme.of(context).secondaryBackground,
        // color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(38.0, 18, 18, 18),
          child: Column(
            children: [
              rent
                  ? const SizedBox()
                  : const SizedBox(
                      height: 10,
                    ),
              rent
                  ? const SizedBox()
                  : Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "Property Name",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text: "${detail["propertyname"]}",
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "Advance money",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: detail["advancemoney"] == 'true'
                        ? TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text: "Yes",
                          )
                        : TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text: "No",
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              rent
                  ? Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "Amount",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text:
                                "₹${detail['amount']}/${detail['paymentduration']}",
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "Amount",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text: "₹${detail['amount']}/-",
                          ),
                        ),
                      ],
                    ),
              rent
                  ? const SizedBox()
                  : const SizedBox(
                      height: 10,
                    ),
              rent
                  ? const SizedBox()
                  : Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "Area of land",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text:
                                "${detail["areaofland"]} ${detail["areaoflandunit"]}",
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "City",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      text: "${detail["city"]}",
                    ),
                  ),
                ],
              ),
              // detail["description"] == "null"
              //     ? const SizedBox()
              //     : const SizedBox(
              //         height: 10,
              //       ),
              rent
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              rent
                  ? Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "Food service",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: detail["foodservice"] == 'true' || detail["foodservice"] == 'Yes'
                              ? TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  text: "Yes",
                                )
                              : TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  text: "No",
                                ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              rent
                  ? SizedBox()
                  : Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "Number of floors",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text: "${detail["numberoffloors"]}",
                          ),
                        ),
                      ],
                    ),
              rent
                  ? const SizedBox()
                  : const SizedBox(
                      height: 10,
                    ),
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "Number of rooms",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      text: "${detail["numberofrooms"]}",
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "Pincode",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      text: "${detail["pincode"]}",
                    ),
                  ),
                ],
              ),
              rent
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(),
              rent
                  ? Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "Service type",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text: "${detail["servicetype"]}",
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              rent
                  ? Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "Sharing",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            text: "${detail["sharing"]}",
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              rent
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //
              //   child: Row(
              //     children: [
              //       DataTable(
              //           columns: const [
              //
              //             DataColumn(
              //               label: Text('Rooms'),
              //             ),
              //             DataColumn(
              //               label: Text('Sharing'),
              //             ),
              //             DataColumn(
              //               label: Text('food'),
              //             ),
              //             DataColumn(
              //               label: Text('Amount'),
              //             ),
              //           ],
              //           rows: const [
              //
              //             DataRow(cells: [
              //               DataCell(Text('1')),
              //               DataCell(Text('No')),
              //               DataCell(Text('mon-fri\n(2 time)')),
              //               DataCell(Text('1000/month')),
              //             ]),
              //             DataRow(cells: [
              //               DataCell(Text('1')),
              //               DataCell(Text('2 sharing')),
              //               DataCell(Text('---')),
              //               DataCell(Text('800/month')),
              //             ])
              //           ],
              //       )
              //     ],
              //   ),
              // )
            ],
          )),
    );
  }
}
