// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:take/Widgets/bottom_nav_bar.dart';
import 'package:take/globar_variables/globals.dart';
import 'package:take/pages/signin_page/phone_signup.dart';
import 'package:take/pages/signin_page/sign_in.provider.dart';
import 'package:take/pages/signup_page/signup_page.dart';

class LoginApp extends StatefulWidget {
  String page;
  LoginApp(this.page, {Key? key}) : super(key: key);

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verify(code) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.page, smsCode: code);

    dynamic result = await _auth.signInWithCredential(credential);

    dynamic user = result.user;

    if (user != null) {
      print("user 2");
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomBottomNavigation("")));
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14.0);
    TextStyle linkStyle =
        const TextStyle(color: Color.fromARGB(255, 9, 114, 199));
    return Consumer<SigninProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SingleChildScrollView(
              child: widget.page == "phone"
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.purpleAccent,
                            Colors.amber,
                            Colors.blue,
                          ])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 180,
                            width: 450,
                            child: Container(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 325,
                            height: 320,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Hello",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Please Login to Your Account",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 260,
                                  height: 60,
                                  child: TextField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        suffix: Icon(
                                          FontAwesomeIcons.phone,
                                          color: Colors.red,
                                        ),
                                        labelText: "Phone Number",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final provider =
                                        Provider.of<SigninProvider>(context,
                                            listen: false);
                                    provider.loginUser(
                                        _phoneController.text, context);

                                    // loginUser(_phoneController.text, context);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => LoginApp("")));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 261,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              // Color(0xFF8A2387),
                                              Color.fromRGBO(242, 113, 33, 1),
                                              Color(0xFFF27121),
                                            ])),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: defaultStyle,
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text: "Don't have an account?"),
                                      TextSpan(
                                          text: 'Sign Up',
                                          style: linkStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              print("signup");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpPage()));
                                            })
                                    ],
                                  ),
                                ),
                                // const Text(
                                //   "Don't have an account? Sign Up",
                                //   style: TextStyle(fontWeight: FontWeight.bold),
                                // ),
                                // const SizedBox(height: 15,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     IconButton(
                                //         onPressed: click,
                                //         icon: const Icon(FontAwesomeIcons.facebook,color: Colors.blue)
                                //     ),
                                //     IconButton(
                                //         onPressed: click,
                                //         icon: const Icon(FontAwesomeIcons.google,color: Colors.redAccent,)
                                //     ),
                                //     IconButton(
                                //         onPressed: click,
                                //         icon: const Icon(FontAwesomeIcons.twitter,color: Colors.orangeAccent,)
                                //     ),
                                //     IconButton(
                                //         onPressed: click,
                                //         icon: const Icon(FontAwesomeIcons.linkedinIn,color: Colors.green,)
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.purpleAccent,
                            Colors.amber,
                            Colors.blue,
                          ])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 180,
                            width: 450,
                            child: Container(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 325,
                            height: 320,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 45,
                                ),
                                const Text(
                                  "otp verification",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Enter the otp send on your number",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 260,
                                  height: 60,
                                  child: TextField(
                                    controller: _codeController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: "OTP",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        )),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 12,
                                // ),
                                // Container(
                                //   width: 260,
                                //   height: 60,
                                //   child: const TextField(
                                //     obscureText: true,
                                //     decoration: InputDecoration(
                                //         suffix: Icon(
                                //           FontAwesomeIcons.eyeSlash,
                                //           color: Colors.red,
                                //         ),
                                //         labelText: "OTP",
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.all(Radius.circular(8)),
                                //         )),
                                //   ),
                                // ),
                                // Padding(
                                //   padding:const EdgeInsets.fromLTRB(20, 0, 30, 0),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       // TextButton(
                                //       //   onPressed: click,
                                //       //   child:const Text("Forget Password",
                                //       //     style: TextStyle(
                                //       //         color: Colors.deepOrange
                                //       //     ),
                                //       //   ),
                                //       // )
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    verify(_codeController.text);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 262,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFF8A2387),
                                              Color(0xFFE94057),
                                              Color(0xFFF27121),
                                            ])),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        'Verify',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: defaultStyle,
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text: "Don't have an account?"),
                                      TextSpan(
                                          text: 'Sign Up',
                                          style: linkStyle,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              print("signup");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpPage()));
                                            })
                                    ],
                                  ),
                                ),
                                // const Text(
                                //   "Don't have an account? Sign Up",
                                //   style: TextStyle(fontWeight: FontWeight.bold),
                                // ),
                                // const SizedBox(height: 15,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     IconButton(
                                //         onPressed: click,
                                //         icon: const Icon(FontAwesomeIcons.facebook,color: Colors.blue)
                                //     ),
                                //     IconButton(
                                //         onPressed: click,
                                //         icon: const Icon(FontAwesomeIcons.google,color: Colors.redAccent,)
                                //     ),
                                //     IconButton(
                                //         onPressed: click,
                                //         icon: const Icon(FontAwesomeIcons.twitter,color: Colors.orangeAccent,)
                                //     ),
                                //     IconButton(
                                //         onPressed: click,
                                //         icon: const Icon(FontAwesomeIcons.linkedinIn,color: Colors.green,)
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
        );
      },
    );
  }
}
