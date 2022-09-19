import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:take/list_property.dart';
import 'package:take/search.dart';

import 'me.dart';


class CustomBottomNavigation extends StatefulWidget {
  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  late int pageIndex = 0;

  final pages = [
    const Search(),
    const ListProperty(),
    const Me()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          height: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(5, 15),
                  blurRadius: 5,
                  spreadRadius: 3)
            ],
            color: Colors.white,
            // color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:
                  pageIndex == 0 ? const Color(0xFFEF9A9A) : Colors.white,
                ),
                child: IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: Column(
                    children: [
                      Image.asset(
                        "assets/search.png",
                        color: pageIndex == 0
                            ? Colors.white
                            : const Color(0xfff24086a),
                        height: 30,
                      ),
                      Text(
                        "Search",
                        style: GoogleFonts.poppins(
                            color: pageIndex == 0
                                ? Colors.white
                                : const Color(0xfff24086a),
                            fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:
                  pageIndex == 1 ? const  Color(0xFFEF9A9A) : Colors.white,
                ),
                child: IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: Column(
                    children: [
                      Image.asset(
                        "assets/list.png",
                        color: pageIndex == 1
                            ? Colors.white
                            : const Color(0xfff24086a),
                        height: 30,
                      ),
                      Text(
                        "Add",
                        style: GoogleFonts.poppins(
                            color: pageIndex == 1
                                ? Colors.white
                                : const Color(0xfff24086a),
                            fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:
                  pageIndex == 2 ?   Color(0xFFEF9A9A): Colors.white
                ),
                child: IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  icon: Column(
                    children: [
                      Image.asset(
                        "assets/me.png",
                        color: pageIndex == 2
                            ? Colors.white
                            : const Color(0xfff24086a),
                        height: 30,
                      ),
                      Text(
                        "Me",
                        style: GoogleFonts.poppins(
                            color: pageIndex == 2
                                ? Colors.white
                                : const Color(0xfff24086a),
                            fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}