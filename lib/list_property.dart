import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:take/Widgets/cards.dart';
import 'package:take/Widgets/csc.dart';
import 'package:take/Widgets/detail_card.dart';
import 'package:image_picker/image_picker.dart';
import 'Widgets/image_upload_card.dart';
import 'Widgets/loaded_images.dart';
import 'globar_variables/const_values.dart';

class ListProperty extends StatefulWidget {
  const ListProperty({Key? key}) : super(key: key);

  @override
  State<ListProperty> createState() => _ListPropertyState();
}

class _ListPropertyState extends State<ListProperty> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  String firstName = "";
  String lastName = "";
  String bodyTemp = "";
  var measure;

  var placetext = "";
  var place = [
    'Hostel',
    'Hotel',
    'PG',
    'Home',
  ];

  var servicetype = "";
  var serviceType = [
    'On sale',
    'On rent',
  ];

  var sharingtext = "";
  var sharing = [
    'No sharing',
    'Two sharing',
    'Three sharing',
    'Many sharing',
    'Will be discussed'
  ];

  var roomstext = "";
  var rooms = [
    '1 Room',
    '2 Room',
    '3 Room',
    '4 Room',
    '5 Room',
    '6 Room',
    '7 Room',
    '8 Room',
    '9 Room',
    '10 Room',
    '11 Room',
    '12 Room',

    '> 12 Room',
  ];

  var toiletjoinedtext = "";
  var toiletjoined = [
    'Yes',
    'No',
  ];

  var tenortext = "";
  var tenor = ['per month', 'per year', 'per day', 'one time payment'];

  var advanceMoneytext = "";
  var advanceMoney = ['Yes', 'No'];

  var foodtext = "";
  var food = ['Yes', 'No'];

  var electricityBilltext = "";
  var electricityBill = ['included', 'depends upon usage'];

  var watertimingtext = "";
  var waterTiming = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];

  var ampmtext = "";
  var ampm = ['AM', 'PM'];

  final ImagePicker _picker = ImagePicker();
  dynamic _imageFile;
  List listImage = [];

  Widget bottomSheet() {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        children: <Widget>[

          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera, size: 50,),
              onPressed: () {
                Navigator.pop(context);
                takePhoto(ImageSource.camera);
                // Navigator.pop(context);
              },
              label: const Text("Camera"),
            ),
             SizedBox(
              width: MediaQuery.of(context).size.width*0.3,
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.image,
                size: 50,
              ),
              onPressed: () {
                Navigator.pop(context);
                takePhoto(ImageSource.gallery);
                // Navigator.pop(context);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  bool heightimage = false;

  void takePhoto(ImageSource source) async {

    // final XFile? image = await _picker.pickImage(source: source);
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {

      _imageFile = pickedFile;
      if (pickedFile != null) {
        heightimage = true;
      }

      listImage.add(pickedFile);
      for (var i in listImage) {
        listImage.remove(null);
      }
      print(pickedFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/home3.png"),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          text: "List Property",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        height: 104,
                        child: Column(
                          children: [
                            CSCPicker(
                              ///Enable disable state dropdown [OPTIONAL PARAMETER]
                              showStates: true,

                              /// Enable disable city drop down [OPTIONAL PARAMETER]
                              showCities: true,

                              ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                              flagState: CountryFlag.DISABLE,

                              ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                              dropdownDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1)),

                              ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                              disabledDropdownDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1)),

                              ///placeholders for dropdown search field
                              countrySearchPlaceholder: "Country",
                              stateSearchPlaceholder: "State",
                              citySearchPlaceholder: "City",

                              ///labels for dropdown
                              countryDropdownLabel: "*Country",
                              stateDropdownLabel: "*State",
                              cityDropdownLabel: "*City",

                              ///Default Country
                              defaultCountry: DefaultCountry.India,

                              ///Disable country dropdown (Note: use it with default country)
                              //disableCountry: true,

                              ///selected item style [OPTIONAL PARAMETER]
                              selectedItemStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),

                              ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                              dropdownHeadingStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),

                              ///DropdownDialog Item style [OPTIONAL PARAMETER]
                              dropdownItemStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),

                              ///Dialog box radius [OPTIONAL PARAMETER]
                              dropdownDialogRadius: 10.0,

                              ///Search bar radius [OPTIONAL PARAMETER]
                              searchBarRadius: 10.0,

                              ///triggers once country selected in dropdown
                              onCountryChanged: (value) {
                                setState(() {
                                  ///store value in country variable
                                  countryValue = value;
                                });
                              },

                              ///triggers once state selected in dropdown
                              onStateChanged: (value) {
                                setState(() {
                                  ///store value in state variable
                                  stateValue = value.toString();
                                });
                              },

                              ///triggers once city selected in dropdown
                              onCityChanged: (value) {
                                setState(() {
                                  ///store value in city variable
                                  cityValue = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Pincode",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                });
                              },
                              validator: (value) {
                                return null;

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     value.length < 3) {
                                //   return 'First Name must contain at least 3 characters';
                                // } else if (value
                                //     .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'First Name cannot contain special characters';
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              // Initial Value
                              // value: serviceType[0],
                              hint: servicetype == ''
                                  ? const Text("You want your property on?")
                                  : Text(servicetype),

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded:
                                  true, //make true to take width of parent widget
                              underline: Container(), //empty line
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              items: serviceType.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  servicetype = newValue!;
                                  // serviceType[0] = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              // Initial Value
                              // value: serviceType[0],
                              hint: placetext == ''
                                  ? const Text("Service Type")
                                  : Text(placetext),

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded:
                                  true, //make true to take width of parent widget
                              underline: Container(), //empty line
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              items: place.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  placetext = newValue!;
                                  // serviceType[0] = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              // Initial Value
                              hint: sharingtext == ''
                                  ? const Text("Sharing")
                                  : Text(sharingtext),

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded:
                                  true, //make true to take width of parent widget
                              underline: Container(), //empty line
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              // Array list of items
                              items: sharing.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  sharingtext = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              // Initial Value
                              hint: toiletjoinedtext == ''
                                  ? const Text("Joined Toilet")
                                  : Text(toiletjoinedtext),

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded:
                                  true, //make true to take width of parent widget
                              underline: Container(), //empty line
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              // Array list of items
                              items: toiletjoined.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  toiletjoinedtext = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              // Initial Value
                              hint: advanceMoneytext == ''
                                  ? const Text("Advance Money")
                                  : Text(advanceMoneytext),

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded:
                                  true, //make true to take width of parent widget
                              underline: Container(), //empty line
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              // Array list of items
                              items: advanceMoney.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  advanceMoneytext = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              // Initial Value
                              hint: foodtext == ''
                                  ? const Text("Food Service")
                                  : Text(foodtext),

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded:
                                  true, //make true to take width of parent widget
                              underline: Container(), //empty line
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              // Array list of items
                              items: food.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  foodtext = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              // Initial Value
                              hint: electricityBilltext == ''
                                  ? const Text("Electricity Bill")
                                  : Text(electricityBilltext),

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isExpanded:
                                  true, //make true to take width of parent widget
                              underline: Container(), //empty line
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              // Array list of items
                              items: electricityBill.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  electricityBilltext = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 43,
                            width: MediaQuery.of(context).size.width * 0.31,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black, //shadow for button
                                        blurRadius: 0.1) //blur radius of shadow
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(13),
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: "Amount",
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(20.0)),
                                    //   borderSide: BorderSide(
                                    //       color: Colors.grey.shade500, width: 0.0),
                                    // ),
                                    border: InputBorder.none,
                                  ),
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      firstName = value.capitalize();
                                      // firstNameList.add(firstName);
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      firstName = value.capitalize();
                                    });
                                  },
                                  validator: (value) {
                                    // if (value == null ||
                                    //     value.isEmpty ||
                                    //     value.length < 3) {
                                    //   return 'First Name must contain at least 3 characters';
                                    // } else if (value.contains(
                                    //     RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                    //   return 'First Name cannot contain special characters';
                                    // }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 43,
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black, //shadow for button
                                        blurRadius: 0.1) //blur radius of shadow
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  // Initial Value
                                  hint: tenortext == ''
                                      ? const Text(
                                          "Payment Duration",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      : Text(tenortext),

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded:
                                      true, //make true to take width of parent widget
                                  underline: Container(), //empty line
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.black,
                                  // Array list of items
                                  items: tenor.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      tenortext = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 43,
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(20)),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black, //shadow for button
                                        blurRadius: 0.1) //blur radius of shadow
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  // Initial Value
                                  hint: roomstext == ''
                                      ? const Text(
                                          "Number of rooms",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      : Text(roomstext),

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded:
                                      true, //make true to take width of parent widget
                                  underline: Container(), //empty line
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.black,
                                  // Array list of items
                                  items: rooms.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      roomstext = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Property Name",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                });
                              },
                              validator: (value) {
                                return null;

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     value.length < 3) {
                                //   return 'First Name must contain at least 3 characters';
                                // } else if (value
                                //     .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'First Name cannot contain special characters';
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Area of land (In square feet)",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                });
                              },
                              validator: (value) {
                                return null;

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     value.length < 3) {
                                //   return 'First Name must contain at least 3 characters';
                                // } else if (value
                                //     .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'First Name cannot contain special characters';
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Number of floors",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                });
                              },
                              validator: (value) {
                                return null;

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     value.length < 3) {
                                //   return 'First Name must contain at least 3 characters';
                                // } else if (value
                                //     .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'First Name cannot contain special characters';
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: "Owner's Name",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                });
                              },
                              validator: (value) {
                                return null;

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     value.length < 3) {
                                //   return 'First Name must contain at least 3 characters';
                                // } else if (value
                                //     .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'First Name cannot contain special characters';
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Mobile Number",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {

                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                });
                              },
                              validator: (value) {
                                return null;

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     value.length < 3) {
                                //   return 'First Name must contain at least 3 characters';
                                // } else if (value
                                //     .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'First Name cannot contain special characters';
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "What's app Number",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {

                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  // firstName = value.capitalize();
                                });
                              },
                              validator: (value) {
                                return null;

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     value.length < 3) {
                                //   return 'First Name must contain at least 3 characters';
                                // } else if (value
                                //     .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'First Name cannot contain special characters';
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 43,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                });
                              },
                              validator: (value) {
                                return null;

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     value.length < 3) {
                                //   return 'First Name must contain at least 3 characters';
                                // } else if (value
                                //     .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'First Name cannot contain special characters';
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Upload property Image",),
                      ),
                      heightimage
                          ? SizedBox(
                              height: 136.0,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  if (listImage != [])
                                    ...listImage.map((e) {
                                      print(
                                          "is this your are taking about :$e");

                                      return LoadedImage(e);
                                    })
                                ],
                              ),
                            )
                          : Container(),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: ImageUploadCard(null),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black, //shadow for button
                                    blurRadius: 0.1) //blur radius of shadow
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                hintText: "Owner's Description (Optional)",
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20.0)),
                                //   borderSide: BorderSide(
                                //       color: Colors.grey.shade500, width: 0.0),
                                // ),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                  // firstNameList.add(firstName);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.capitalize();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade200,
                            minimumSize: const Size.fromHeight(60)),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: const Text(
                          "List Property",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    return "${this[0].toLowerCase()}${this.substring(1)}";
  }
}
