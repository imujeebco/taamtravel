import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {
  RxInt myID = 1.obs;
  RxString myEmail = ''.obs;
  RxString myName = ''.obs;
  RxString myUsername = ''.obs;
  RxString myToken = ''.obs;
  RxString myRefToken = ''.obs;
  RxInt myRoleSupportID = 1.obs;
  RxInt myRoleId = 1.obs;
  RxBool myLoggedIn = false.obs;

//////////////////////////////////////////////////////Get Stored Data
  Future<void> loadMyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _loggedIn = prefs.getBool('loggedInStatus') ?? false;
    int? _id = prefs.getInt('savedID') ?? 1;
    String? _email = prefs.getString('savedEmail') ?? "Error";
    String? _name = prefs.getString('savedName') ?? "Error";
    String? _username = prefs.getString('savedUsername') ?? "Error";
    String? _token = prefs.getString('savedToken') ?? "Error";
    String? _refToken = prefs.getString('savedRefToken') ?? "Error";
    int? _roleSupportID = prefs.getInt('savedRoleSupportId') ?? 1;
    int? _myRoleId = prefs.getInt("roleID") ?? 4;

    update();
    myID.value = _id;
    myLoggedIn.value = _loggedIn;
    myEmail.value = _email;
    myName.value = _name;
    myUsername.value = _username;
    myToken.value = _token;
    myRefToken.value = _refToken;
    myRoleId.value = _myRoleId;
    myRoleSupportID.value = _roleSupportID;

    update();
  }
}
