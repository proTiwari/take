import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../signin_page/sign_in.provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailfield = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  static final RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\”]+(\.[^<>()[\]\\.,;:\s@\”]+)*)|(\”.+\”))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$');
  TabController? tabController;
  int selectedIndex = 0;

  var listImage = [
    "https://images.unsplash.com/photo-1599202937077-3f7cdc53f2e1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzJ8fGJlZHJvb218ZW58MHx8MHx8&w=1000&q=80",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14.0);
    TextStyle linkStyle =
        const TextStyle(color: Color.fromARGB(255, 9, 114, 199));
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.959,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       // IconButton(
              //       //   onPressed: () {},
              //       //   icon: const Icon(
              //       //     Icons.arrow_back_ios,
              //       //     size: 30.0,
              //       //   ),
              //       // ),

              //       IconButton(
              //         onPressed: () {},
              //         icon: const Icon(
              //           Icons.more_horiz,
              //           size: 30.0,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 10.0),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80"),
                radius: 40.0,
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Shubham Tiwari",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20.0),

              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TabBar(
                      isScrollable: true,
                      controller: tabController,
                      indicator:
                          const BoxDecoration(borderRadius: BorderRadius.zero),
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.black26,
                      onTap: (tapIndex) {
                        setState(() {
                          selectedIndex = tapIndex;
                        });
                      },
                      tabs: const [
                        Tab(text: "Properties"),
                        Tab(text: "Profile"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.67,
                  child: Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 200.0, crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: NetworkImage(listImage[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 37.0,
                                      right: 37.0,
                                      top: 185.0,
                                      bottom: 15.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: const Text("1.234k"),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: 1,
                        ),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 60,
                                  child: TextFormField(
                                    controller: name,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return 'Please enter Name';
                                      }

                                      if (value.toString().length < 3) {
                                        return 'name cannot be less than 3 character';
                                      }
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        labelText: "Name",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 60,
                                  child: TextFormField(
                                    controller: emailfield,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return 'Please enter Email';
                                      }
                                      if (!email.hasMatch(value!)) {
                                        return 'Please enter a valid Email';
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        suffix: Icon(
                                          FontAwesomeIcons.envelope,
                                          color: Colors.red,
                                        ),
                                        labelText: "Email",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 60,
                                  child: TextFormField(
                                    controller: address,
                                    validator: (value) {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        suffix: Icon(
                                          FontAwesomeIcons.solidAddressCard,
                                          color: Colors.red,
                                        ),
                                        labelText: "Complete Address",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(27.0,0,0,0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 60,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: _phoneController,
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Please enter phone number';
                                        }

                                        if (value.toString().length < 10) {
                                          return 'Please enter a valid phone number';
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      // ignore: prefer_const_constructors
                                      decoration: InputDecoration(
                                          enabled: false,
                                          suffix: const Icon(
                                            FontAwesomeIcons.phone,
                                            color: Colors.red,
                                          ),
                                          labelText: "+916306846970",
                                          // border: const OutlineInputBorder(
                                          //   borderRadius: BorderRadius.all(
                                          //       Radius.circular(50)),
                                          // ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      final provider =
                                          Provider.of<SigninProvider>(context,
                                              listen: false);
                                      provider.loginUser(
                                          _phoneController.text, context);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              // Color(0xFF8A2387),
                                              Color(0xFFF27121),
                                              Color(0xFFF27121),
                                            ])),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
