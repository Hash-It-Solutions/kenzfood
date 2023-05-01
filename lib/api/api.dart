

import '../config/constant.dart';

class Api {
  static String signUp = "${baseUrl}insert_users";
  static String login = "${baseUrl}sign_in";
  static String getUserwithMobile = "${baseUrl}get_users/phone?phone=";
  static String phoneVerification = '${baseUrl}verify/';
  static String updatePassword = '${baseUrl}update_password/';
  static String updateUser = '${baseUrl}update_user';
  static String deactivateUser = '${baseUrl}user_deactivate';
  static String getUser = "${baseUrl}get_user/current";
}
