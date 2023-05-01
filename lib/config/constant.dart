import 'package:shared_preferences/shared_preferences.dart';




 //const String baseUrl = "https://kenzfood.com/";

const String baseUrl ="https://kenz-food.herokuapp.com/";

//const String baseUrl = "https://kenz-food-api.herokuapp.com/";

String apiToken = '';
var countryCode = '+974'; //Qatar
//var countryCode = '+91'; //india

saveStringValue(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getStringValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}
