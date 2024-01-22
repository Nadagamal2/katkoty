import 'package:katkoty/service/shared_preference/shared_preference.dart';

class UserPreferences {
  static final sharedPreferences = SharedPrefs.instance;

  static Future<void> setLang(bool lang) =>
      sharedPreferences.setBool('lang', lang);

  static bool isLoggedIn() => sharedPreferences.getBool('logg_in') ?? false;

  static Future<void> setIsLoggedIn(bool login) =>
      sharedPreferences.setBool('logg_in', login);

  static Future<void> setUserName(String userName) =>
      sharedPreferences.setString('user_name', userName);
  static Future<void> setUsersecName(String userName) =>
      sharedPreferences.setString('user_sec_name', userName);

  static Future<void> setUseremail(String useremail) =>
      sharedPreferences.setString('user_email', useremail);

  static Future<void> setBirthdate(String birthdate) =>
      sharedPreferences.setString('birthdate', birthdate);

  static Future<void> setUserId(String userid) =>
      sharedPreferences.setString('user_Id', userid);

  static Future<void> setUserpic(String userPic) =>
      sharedPreferences.setString('user_pic', userPic);
  //
  //
  //
  //
  //
  //
  //
  static bool getLanguage() => sharedPreferences.getBool('lang') ?? true;
  static bool? getisloggedin() => sharedPreferences.getBool('logg_in');
  static String getUserName() => sharedPreferences.getString('user_name') ?? "";
  static String getUsersecName() =>
      sharedPreferences.getString('user_sec_name') ?? "";
  static String getUserid() => sharedPreferences.getString('user_Id') ?? "";
  static String getUseremail() =>
      sharedPreferences.getString('user_email') ?? "";
  static String getUserpic() => sharedPreferences.getString('user_pic') ?? "";
  static String getBirthdate() =>
      sharedPreferences.getString('birthdate') ?? "";
}
