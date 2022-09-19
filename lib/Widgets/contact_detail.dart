import 'package:flutter/material.dart';

class ContactDetail extends StatelessWidget {
  const ContactDetail({Key? key}) : super(key: key);

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
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "Phone no.",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      text: "+918988389483",
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
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "What's app no.",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      text: "+918988389483",
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "email",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      text: "dkfmsk@gmail.com",
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
