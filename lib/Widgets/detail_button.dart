import 'package:flutter/material.dart';

class DetailButton extends StatelessWidget {
  const DetailButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(

        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(5, 15),
              blurRadius: 5,
              spreadRadius: 3)
        ],
        color: Colors.red.shade200,
        // color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  text: "I am interested in your service",
                ),
              ),
            ),
          )),
    );
  }
}
