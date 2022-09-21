import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:take/providers/base_providers.dart';

import '../../Widgets/bottom_nav_bar.dart';
import 'phone_login.dart';

class SigninModel {
  final String value;
  final String error;

  SigninModel(this.value, this.error);
}

enum ViewState { Idle, Busy }

abstract class LoaderState {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  void setState(ViewState viewState);
}

class ValidatorType {
  static final RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\”]+(\.[^<>()[\]\\.,;:\s@\”]+)*)|(\”.+\”))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$');
  static final RegExp password = RegExp(r'^(?=.*)(.){6,15}$');
}

class SigninProvider extends BaseProvider implements LoaderState {
  SigninProvider() {
    setState(ViewState.Idle);
  }

  SigninModel _email = SigninModel("null", "null");
  SigninModel _password = SigninModel("null", "null");
  SigninModel get email => _email;
  SigninModel get password => _password;

  bool get isValid {
    if (_password.value != "null" && _email.value != "null") {
      return true;
    } else {
      return false;
    }
  }

  //Setters
  void changeEmail(String value) {
    if (ValidatorType.email.hasMatch(value)) {
      _email = SigninModel(value, "null");
    } else if (value.isEmpty) {
      _email = SigninModel("null", "null");
    } else {
      _email = SigninModel("null", "Enter a valid email");
    }
    notifyListeners();
  }

  void changePassword(String value) {
    if (ValidatorType.password.hasMatch(value)) {
      print(value);
      _password = SigninModel(value, "null");
    } else if (value.isEmpty) {
      _password = SigninModel("null", "");
    } else {
      _password = SigninModel("null", "Must have at least 6 characters");
    }
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> loginUser(String phone, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: "+91${phone}",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();

        dynamic result = await _auth.signInWithCredential(credential);

        dynamic user = result.user;

        if (user != null) {
          print("user 1");
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomBottomNavigation("")));
        } else {
          print("Error");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (dynamic exception) {
        print(exception);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginApp(verificationId)));
      },
      // ignore: avoid_returning_null_for_void
      codeAutoRetrievalTimeout: (verificationId) => null,
    );
    return true;
  }

  @override
  late ViewState _state;

  @override
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  @override
  ViewState get state => _state;

  // Future<LoginResponse> submitLogin() async {
  //
  //   setState(ViewState.Busy);
  //   final Mapable response = await apiClient.serverDataProvider.login(_email.value, _password.value,);
  //   setState(ViewState.Idle);
  //   if (response is LoginResponse) {
  //     print(‘response.token ${response.token}’);
  //
  //     return response;
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }
}
