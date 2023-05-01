import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/color_palette.dart';

class WidgetHelper {
  static Future<bool?> showToast(String msg,
      {Toast length = Toast.LENGTH_SHORT}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: primarycolor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
