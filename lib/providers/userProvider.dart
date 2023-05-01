import 'dart:convert';



import '../api/api.dart';
import '../config/constant.dart';

import '../models/userReturnModel.dart';
import '../widgets/widgetHelper.dart';
import 'baseProvider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

class UserProvider extends BaseProvider {
  // User? _user;
  // User? get user => _user;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<UserModel?> isMobileNumExists(String mobileNum) async {
    var uri = Uri.parse(Api.getUserwithMobile + mobileNum);
    try {
      _userModel = UserModel();
      setBusy();
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        var data = UserModel.fromJson(extractedData);
        _userModel = data;
        notifyListeners();
        // print("extractedData : $extractedData");
        // print("extractedData : ${extractedData["return"]}");
        setIdle();
        return _userModel;
      }
    } catch (e) {
      setIdle();
      print('Error : $e');
    }
  }

  Future<UserModel?> signUp({
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? phone,
    String? password,
  }) async {
    var uri = Uri.parse(Api.signUp);
    var headers = {'Content-Type': 'application/json'};
    var parameters = {
      "ip_address": "0.0.0.0",
      "user_type": "admin",
      "username": userName,
      "firstname": firstName,
      "lastname": lastName,
      "password": password,
      "email": email,
      "phone": phone,
    };

    try {
      _userModel = UserModel();
      notifyListeners();
      setBusy();
      final response =
          await http.post(uri, body: json.encode(parameters), headers: headers);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        var data = UserModel.fromJson(extractedData);
        _userModel = data;
        print("Data : ${data}");

        print("extractedData : ${extractedData["return"]}");
        setIdle();
        notifyListeners();
        //return extractedData["return"];
      } else {
        print("error occured");
        setIdle();
      }
    } catch (e) {
      setIdle();
      print('Error : $e');
    }
    return _userModel;
  }

  Future<UserModel?> login(String userName, String pswd) async {
    bool isLoggedIn = false;
    var uri = Uri.parse(Api.login);
    var headers = {'Content-Type': 'application/json'};
    var arguments = {"email": userName, "password": pswd};
    try {
      _userModel = UserModel();
      setBusy();
      final response =
          await http.post(uri, body: jsonEncode(arguments), headers: headers);
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);
        var data = UserModel.fromJson(extractedData);
        _userModel = data;
        print("data : " + data.toString());
        isLoggedIn = true;
        apiToken = extractedData["token"];
        saveStringValue("token", extractedData["token"]);
        //var data = User.fromJson(extractedData);
        // _user = data;
        // print(data.phone);
        notifyListeners();

        setIdle();
      } else {
        isLoggedIn = false;
        setIdle();
      }
    } catch (e) {
      isLoggedIn = false;
      notifyListeners();
      print('login error :$e');
      setIdle();
    }
    return _userModel;
  }

  Future verifyPhoneNum(String userId) async {
    var uri = Uri.parse(Api.phoneVerification + userId);
    try {
      var response = await http.put(uri);
      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future updatePassword(String userId, String password) async {
    var uri = Uri.parse(Api.updatePassword + userId);
    var args = {"new_password": password};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response =
          await http.put(uri, body: jsonEncode(args), headers: headers);
      print(response.body);
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  Future updateProfile(var file, String? fname, String? lname, String? email,
      String? phone) async {
    var dio = Dio();
    String fileName = file != null ? file!.path.split('/').last : "";
    var parameters = {
      "firstname": fname,
      "lastname": lname,
      "email": email,
      "phone": phone,
      "user_image": file == null
          ? null
          : await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: MediaType('image', 'png')),
    };
    var headers = {'x-access-token': apiToken};
    dio.options.headers = headers;
    try {
      setBusy();
      FormData formData = FormData.fromMap(parameters);
      var response = await dio.put(
        Api.updateUser,
        data: formData,
      );
      if (response.statusCode == 200) {
        setIdle();
        print(response.data);

        WidgetHelper.showToast('Profile Updated Successfully');
      } else {
        setIdle();
        WidgetHelper.showToast('failed');
      }
    } catch (e) {
      setIdle();
      print(e);
    }
  }

  Future deactivateAccount(String password) async {
    var uri = Uri.parse(Api.deactivateUser);
    var headers = {
      'x-access-token': apiToken,
      'Content-Type': 'application/json'
    };
    var args = {"password": password};
    try {
      setBusy();
      var response =
          await http.put(uri, body: jsonEncode(args), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        setIdle();
        WidgetHelper.showToast("User Successfully Deactivated");
      } else {
        setIdle();
        WidgetHelper.showToast("Error Occured");
      }
      return response;
    } catch (e) {
      setIdle();
      print(e);
    }
  }

  Future<UserModel?> getUserDetails() async {
    var uri = Uri.parse(Api.getUser);
    var headers = {
      'x-access-token': apiToken,
    };
    try {
      _userModel = UserModel();
      setBusy();
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        var data = UserModel.fromJson(extractedData);
        _userModel = data;
        notifyListeners();
        // print("extractedData : $extractedData");
        // print("extractedData : ${extractedData["return"]}");
        setIdle();
        return _userModel;
      }
    } catch (e) {
      setIdle();
      print('Error : $e');
    }
    return _userModel;
  }
}
