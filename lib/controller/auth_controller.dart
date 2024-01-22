import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> logInForm = GlobalKey<FormState>();
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  RxBool obscureText = true.obs;
  RxString name = ''.obs;
  static String userName = "";
  static String userBirthdate = "";

  AuthController() {
    getNameAndBirthDate();
  }
  void getNameAndBirthDate() {
    userName = UserPreferences.getUserName();
    userBirthdate = UserPreferences.getBirthdate();
  }
}
