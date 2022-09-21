import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:take/pages/signin_page/sign_in.provider.dart';
import 'package:take/providers/base_providers.dart';
import 'package:take/globar_variables/globals.dart' as globals;
import '../../Widgets/bottom_nav_bar.dart';
import '../../utils/exit_dialog_box.dart';
import '../signup_page/signup_page.dart';
import 'login.api.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SigninProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () async {
            ExitDialogBox().exit(context);
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: Image.asset("assets/login.png")),
                const SizedBox(height: 20),
                Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/email_logo.png",
                      scale: 1.5,
                      // color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Consumer<SigninProvider>(
                        builder: (context, provider, child) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Email",
                              errorText: provider.email.error == "null" ? null: provider.email.error,
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            onChanged: (String value) {
                              print('provider.email.error ${provider.email.error}');
                              provider.changeEmail(value);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 9.0),
                      child: Image.asset(
                        "assets/lock_logo.png",
                        scale: 1.5,
                        // color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Consumer<SigninProvider>(
                          builder: (context, provider, child) {
                        return TextFormField(
                          // controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            errorText: provider.password.error == "null" ? null: provider.password.error,
                            suffixIcon: IconButton(
                              icon: const Icon(
                                true ? Icons.visibility : Icons.visibility_off,
                                color: Color(0xffef9a9a),
                              ),
                              onPressed: () {},
                            ),
                            hintText: "Password",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.grey),
                          ),
                          onChanged: (String value) {
                            print('provider.password.error ${provider.password.value}');
                            provider.changePassword(value);
                          },
                          obscureText: !true,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forget Password?",
                      style:
                          GoogleFonts.poppins(color: const Color(0xffef9a9a)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Consumer<SigninProvider>(builder: (context, provider, child) {
                  return InkWell(
                    onTap: () async {
                        print("${provider.email.value} ${provider.password.value}");
                        var data = await LoginApi().loginRequest(provider.email.value, provider.password.value);
                        if(data['message'] == 'Success'){
                          globals.logintoken = data['data']['token'];
                        }
                        print("global token : ${globals.logintoken}");

                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffef9a9a),
                      ),
                      child: true
                          ? Center(
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : const Center(
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to RunForRent?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "SignUp",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: const Color(0xffef9a9a)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
