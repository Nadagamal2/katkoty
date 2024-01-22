import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:katkoty/controller/auth_controller.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';
import 'package:katkoty/view/Auth/Login_Screen.dart';
import 'package:katkoty/view/screens/home.dart';

class LoginController extends GetxController {
  RxString uemail = ''.obs;
  RxString upasword = ''.obs;

  final AuthController authcontroller = Get.put(AuthController());
  var userData = Rxn<Map<String, dynamic>>();
  var accessToken = Rxn<AccessToken>();
  var checking = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthController controller = Get.find();
  String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }
  final userData2 = GetStorage();
  Future<void> signInWithEmailandPassword() async {
    const apiUrl = "https://katkoty-app.com/admin/api/community/login.php";
    final email = uemail.value; // Get the email from the TextForm
    final password = upasword.value; // Get the password from the TextForm

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "server": "LoginWithEmail",
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['seccess'] == true) {
        Get.offAll(  Home());
        userData2.write('id', data['id']);
        userData2.write('Name', data['name']);
        userData2.write('email', data['email']);
        userData2.write('photo', data['photo']);
        userData2.write('provider', data['provider']);
        userData2.write('isLogged', true);
        userData2.write('isLoggedByGoogle', false);
        Get.offAll(  Home());
        print(userData2.read('id'));
        print(userData2.read('Name'));
        print(userData2.read('email'));
      } else {}
    } else {}

  }

  Future<void> signupWithEmailandPassword(
      String email, String password, String fullName,) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://katkoty-app.com/admin/api/community/login.php'));
    request.fields.addAll({
      'server': 'Register',
      "email": email,
      "password": password,
      'fullname': fullName
    });



    http.StreamedResponse StreamedResponse = await request.send();
      var response = await http.Response.fromStream(StreamedResponse);
       final result = jsonDecode(response.body);
    if (response.statusCode == 200) {


       // Get.offAll(const Home());
if(result['seccess']==true){
  print(result);
  userData2.write('id', result['id']);
  userData2.write('Name', result['name']);
  userData2.write('email', result['email']);
  userData2.write('photo', result['photo']);
  userData2.write('provider', result['provider']);
  userData2.write('isLogged', true);
  userData2.write('isLoggedByGoogle', false);
  Get.offAll(  Home());
}
else{
  print('object');
}


      }


    else {
      print(response.reasonPhrase);
    }}
  //   const apiUrl = "https://katkoty-app.com/admin/api/community/login.php";
  //   final email = uemail.value; // Get the email from the TextForm
  //   final password = upasword.value; // Get the password from the TextForm
  //
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     body: {
  //       "server": "Register",
  //       "email": email,
  //       "password": password,
  //       'fullname': fullName
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     if (data['seccess'] == true) {
  //       Get.offAll(const Home());
  //
  //       userData2.write('id', data['id']);
  //       userData2.write('Name', data['name']);
  //       userData2.write('email', data['email']);
  //       userData2.write('photo', data['photo']);
  //       userData2.write('provider', data['provider']);
  //       userData2.write('isLogged', true);
  //       userData2.write('isLoggedByGoogle', false);
  //
  //     } else {
  //       print('false');
  //     }
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  Future<UserCredential> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      print(loginResult.status);
      print(loginResult.message);

      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);
        final UserCredential authResult = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        print(authResult);
        print("ssssssssssssssssssssssssssssssssssssssssssssss");
        final User user = authResult.user!;
        final url =
            Uri.parse('https://katkoty-app.com/admin/api/community/login.php');
        final body = ({
          'server': 'Login',
          'email': user.uid,
          'password': user.uid,
          'fullname': user.displayName,
          'urlphoto': user.photoURL,
          'provider': 'facebook',
        });
        final response = await http.post(url, body: body);
        if (response.statusCode == 200) {
          print(response);
          print(response.statusCode);
          print(response.body);
          print(body);
          print('User data sent successfully');
          print('User data sent successfully${response.body}');
        } else {
          print('Failed to send user data. Error code: ${response.statusCode}');
        }
        UserPreferences.setIsLoggedIn(true);
        UserPreferences.setUserName(user.displayName!);
        UserPreferences.setUserId(user.uid);
        UserPreferences.setUserpic(user.photoURL.toString());
        UserPreferences.setUseremail(user.uid);
        Get.offAll(() =>   Home());
        return authResult;
      } else if (loginResult.status == LoginStatus.cancelled) {
        print('Facebook sign-in cancelled by the user');
        throw Exception('Facebook sign-in cancelled');
      } else {
        print('Error signing in with Facebook: ${loginResult.message}');
        throw Exception('Failed to sign in with Facebook');
      }
    } catch (e) {
      // Handle any exceptions that occur during the sign-in process
      print('Error signing in with Facebook: $e');
      rethrow;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(authCredential);
      final User user = authResult.user!;
      await sendUserDataToAPI(user, 'Google');
      await UserPreferences.setUserName(user.displayName!);
      UserPreferences.setUserpic(user.photoURL.toString());
      UserPreferences.setUseremail(user.email!);
      controller.getNameAndBirthDate();
      await UserPreferences.setIsLoggedIn(true);
      Get.to(() =>   Home());
      return authResult;
    } catch (e) {
      print('Error signing in with Google --------------- : $e');
      rethrow;
    }
  }

  Future<void> sendUserDataToAPI(User user, String provider) async {
    final url =
        Uri.parse('https://katkoty-app.com/admin/api/community/login.php');
    final body = ({
      'server': 'Login',
      'email': user.email,
      'password': user.uid,
      'fullname': user.displayName,
      'urlphoto': user.photoURL,
      'provider': 'google',
    });
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('id')) {
        UserPreferences.setUserId(jsonResponse['id']);
      }
      print(response.headers);
      print(body);
      print('User data sent successfully');
      print('User data sent successfully${response.body}');
    } else {
      print('Failed to send user data. Error code: ${response.statusCode}');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      Get.offAll(() => LoginScreen());
      UserPreferences.setIsLoggedIn(false);
      UserPreferences.setUserName('');
      UserPreferences.setUserId('');
      UserPreferences.setUserpic('');
      UserPreferences.setUseremail('');
    } catch (e) {
      // Handle any exceptions that occur during the sign-out process
      print('Error signing out: $e');
      throw Exception('Failed to sign out');
    }
  }

  void printCredentials() {
    print(prettyPrint(accessToken.value!.toJson()));
  }
}
