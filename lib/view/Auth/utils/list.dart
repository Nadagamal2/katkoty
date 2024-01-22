import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class LoginControllerTwo extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInUsingFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          final AccessToken accessToken = result.accessToken!;
          final AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);

          final UserCredential authResult =
              await _auth.signInWithCredential(credential);
          final User? user = authResult.user;
          if (user != null) {
            
            Get.toNamed('/home');
          }
          break;
        case LoginStatus.cancelled:
       
          break;
        case LoginStatus.failed:
          Get.snackbar(
            'Login Failed',
            'An error occurred during Facebook login: ${result.message}',
            snackPosition: SnackPosition.BOTTOM,
          );
          break;
        case LoginStatus.operationInProgress:
          break;
      }
    } catch (e) {
      print("Error during Facebook login: $e");
      Get.snackbar(
        'Login Error',
        'An error occurred during Facebook login: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  Future<void> signOutFacebook() async {
    try {
      await FacebookAuth.instance.logOut(); // Sign out from Facebook

      // Clear user data
      await FirebaseAuth.instance.signOut();

      // Clear the user's data from the app's database
      // ...

      // Do any other necessary cleanup
    } catch (e) {
      // Handle sign-out error
    }
  }
}
