import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:take/app/globar_variables/globals.dart' as globals;

import '../models/property_model.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class FirebaseServices extends ChangeNotifier {
  List valuedata = [];
  List owerpropertydata = [];
  getProperties() async {
    await getUser();
    valuedata = [];
    try {
      print("ffff");
      var data = globals.userdata['properties'];
      print("jjjj$data");

      for (var i in data) {
        List dd = i.split("/");
        print("this is first value in the list: ${dd[0]}");
        print(dd[1]);
        // PropertyModel? propertyModel;
        PropertyModel propertyModel;
        await FirebaseFirestore.instance
            .collection("State")
            .doc("City")
            .collection(dd[0])
            .doc(dd[1])
            .get()
            .then((value) => {
                  propertyModel = PropertyModel(
                    city: value.get("city"),
                    state: value.get("state"),
                    propertyId: value.get("propertyId"),
                    propertyimage: value.get("propertyimage"),
                    pincode: value.get("pincode"),
                    streetaddress: value.get("streetaddress"),
                    wantto: value.get("wantto"),
                    advancemoney: value.get("advancemoney"),
                    numberofrooms: value.get("numberofrooms"),
                    amount: value.get("amount"),
                    propertyname: value.get("propertyname"),
                    areaofland: value.get("areaofland"),
                    numberoffloors: value.get("numberoffloors"),
                    ownername: value.get("ownername"),
                    mobilenumber: value.get("mobilenumber"),
                    whatsappnumber: value.get("whatsappnumber"),
                    email: value.get("email"),
                    description: value.get("description"),
                    servicetype: value.get("servicetype"),
                    sharing: value.get('sharing'),
                    foodservice: value.get("foodservice"),
                    paymentduration: value.get("paymentduration"),
                  ),
                  valuedata.add(propertyModel),

                })
            .whenComplete(() => {}).catchError((error) {
          //This is my third error handler
          valuedata = [];
          print("Missed first two error handlers. Got this error:");
          print(error);
        }); // valuedata.add(propertyModel)
      }

      print("valuabledata${valuedata}");

      globals.listofproperties = valuedata;

      valuedata = globals.listofproperties;
      notifyListeners();
    } catch (e) {
      valuedata = [];
      notifyListeners();
      print("here is the error: ${e.toString()}");
    }
  }

  getOwnerProperties(data) async {
    await getUser();
    owerpropertydata = [];
    try {
      print("jjjj$data");

      for (var i in data) {
        List dd = i.split("/");
        print("this is first value in the list: ${dd[0]}");
        print(dd[1]);
        // PropertyModel? propertyModel;
        PropertyModel propertyModel;
        await FirebaseFirestore.instance
            .collection("State")
            .doc("City")
            .collection(dd[0])
            .doc(dd[1])
            .get()
            .then((value) => {
          propertyModel = PropertyModel(
            city: value.get("city"),
            state: value.get("state"),
            propertyId: value.get("propertyId"),
            propertyimage: value.get("propertyimage"),
            pincode: value.get("pincode"),
            streetaddress: value.get("streetaddress"),
            wantto: value.get("wantto"),
            advancemoney: value.get("advancemoney"),
            numberofrooms: value.get("numberofrooms"),
            amount: value.get("amount"),
            propertyname: value.get("propertyname"),
            areaofland: value.get("areaofland"),
            numberoffloors: value.get("numberoffloors"),
            ownername: value.get("ownername"),
            mobilenumber: value.get("mobilenumber"),
            whatsappnumber: value.get("whatsappnumber"),
            email: value.get("email"),
            description: value.get("description"),
            servicetype: value.get("servicetype"),
            sharing: value.get('sharing'),
            foodservice: value.get("foodservice"),
            paymentduration: value.get("paymentduration"),
          ),
          owerpropertydata.add(propertyModel),

        })
            .whenComplete(() => {}).catchError((error) {
          //This is my third error handler
          owerpropertydata = [];
          print("Missed first two error handlers. Got this error:");
          print(error);
        }); // valuedata.add(propertyModel)
      }

      print("valuabledata${owerpropertydata}");

      owerpropertydata;
      notifyListeners();
    } catch (e) {
      owerpropertydata = [];
      notifyListeners();
      print("here is the error: ${e.toString()}");
    }
  }
}





void listProperty({
  var state,
  var city,
  var propertyimage,
  var pincode,
  var streetaddress,
  var wantto,
  var advancemoney,
  var numberofrooms,
  var amount,
  var propertyname,
  var areaofland,
  var numberoffloors,
  var ownername,
  var mobilenumber,
  var whatsappnumber,
  var email,
  var description,
  var servicetype,
  var sharing,
  var foodservice,
  var paymentduration,
  var propertyId,
}) async {
  await FirebaseFirestore.instance
      .collection("State")
      .doc("City")
      .collection(city)
      .doc(propertyId)
      .set({
    'id': _auth.currentUser!.uid,
    'state': state,
    'city': city,
    'propertyId': propertyId,
    'propertyimage': propertyimage,
    'pincode': pincode,
    'streetaddress': streetaddress,
    'wantto': wantto,
    'advancemoney': advancemoney,
    'numberofrooms': numberofrooms,
    'amount': amount,
    'propertyname': propertyname,
    'areaofland': areaofland,
    'numberoffloors': numberoffloors,
    'ownername': ownername,
    'mobilenumber': mobilenumber,
    'whatsappnumber': whatsappnumber,
    'email': email,
    'description': description,
    'servicetype': servicetype,
    'sharing': sharing,
    'foodservice': foodservice,
    'paymentduration': paymentduration,
  }).whenComplete(() async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(_auth.currentUser!.uid)
          .update({
        "properties": FieldValue.arrayUnion(["$city/$propertyId"]),
      }).whenComplete(() => print("compelete inclusion"));
    } catch (e) {
      print("printdd$e");
    }
  });
}

getUser() async {
  var data;
  if (_auth.currentUser != null) {
    print(
        "lllllllllllllll${_auth.currentUser!.email}llllllllllllllllllllllll${_auth.currentUser!.uid}");

    data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => {
              // print(value.get("name")),
              globals.userdata = value,
            })
        .whenComplete(() => {
              print("completed${globals.userdata}"),
            });
    // print("globals userdata : ${globals.userdata["name"]}");
  }
}

getproperty(city) async {
  var valuedata;
  valuedata = await FirebaseFirestore.instance
      .collection("State")
      .doc("City")
      .collection(city)
      .get()
      .then((value) => value.docs
          .map((doc) => {
                'id': doc['id'],
                'state': doc['state'],
                'city': doc['city'],
                'propertyId': doc['propertyId'],
                'propertyimage': doc['propertyimage'],
                'pincode': doc['pincode'],
                'streetaddress': doc['streetaddress'],
                'wantto': doc['wantto'],
                'advancemoney': doc['advancemoney'],
                'numberofrooms': doc['numberofrooms'],
                'amount': doc['amount'],
                'propertyname': doc['propertyname'],
                'areaofland': doc['areaofland'],
                'numberoffloors': doc['numberoffloors'],
                'ownername': doc['ownername'],
                'mobilenumber': doc['mobilenumber'],
                'whatsappnumber': doc['whatsappnumber'],
                'email': doc['email'],
                'description': doc['description'],
                'servicetype': doc['servicetype'],
                'sharing': doc['sharing'],
                'foodservice': doc['foodservice'],
                'paymentduration': doc['paymentduration'],
              })
          .toList());
  print("valuedata ${valuedata}");
  globals.property = valuedata;
  return valuedata;
}
