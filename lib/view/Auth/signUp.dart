import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/controller/login_controller.dart';
import 'package:katkoty/view/Auth/Login_Screen.dart';
import 'package:katkoty/view/Auth/widget/Button_sign.dart';
import 'package:katkoty/view/Auth/widget/input_signUp.dart';

import '../../utils/color.dart';

//Color orangeColors = const Color(0xffF5591F);
Color appColors = const Color(0xffF6C116);
Color orangeLightColors = const Color(0xffF2861E);

class SignupScreen extends StatefulWidget {
  static const String path = "lib/src/pages/login/signup3.dart";

  const SignupScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupThreePageState createState() => _SignupThreePageState();
}

class _SignupThreePageState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginController c = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height *
                    0.35, // Assign a fixed height
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [appColors, orangeLightColors],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                  ),
                ),
                child: const Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Text(
                        "إنشاء حساب",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        textInput(
                          controller: _fullNameController,
                          hint: "الاسم",
                          icon: Icons.person,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          }, color: Colors.grey.shade200,
                        ),
                        textInput(
                          controller: _emailController,
                          hint: "البريد الإلكتروني",
                          color: Colors.grey.shade200,
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        textInput(
                          controller: _passwordController,
                          hint: "كلمة المرور",
                          color: Colors.grey.shade200,
                          icon: Icons.vpn_key,
                          obscureText: !_passwordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('ok');
                            c.signupWithEmailandPassword(

                              _emailController.text,
                              _passwordController.text,
                              _fullNameController.text,);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(25))),
                            width: double.infinity,
                            height: 50,
                            child: const Center(child: Text("إنشاء حساب",  style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),)),
                          ),
                        ),
                        // ButtonWidget(
                        //   btnText: "إنشاء حساب",
                        //   onClick: () {
                        //     print('ok');
                        //
                        //       c.signupWithEmailandPassword(
                        //
                        //           _emailController.text,
                        //           _passwordController.text,
                        //         _fullNameController.text,);
                        //
                        //   },
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Get.offAll(LoginScreen());

                          },
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "هل تمتلك حساب ؟ ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: "تسجيل الدخول",
                                  style: TextStyle(color:AppbarColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
