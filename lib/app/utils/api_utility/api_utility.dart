// ignore_for_file: invalid_use_of_protected_member, avoid_print

import 'dart:convert';


// some functions specifically used to handle api calls
class ApiUtility {
  // encrypting the credentials to base64 format for security
  static String encryptBase64Credentials(String username, String password) {
    String credentials = '$username:$password';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    return encoded;
  }

// payload for login post method
  static Map<String, String> setBodyData() {
    var bodyHashMap = <String, String>{
      "WebUserLogId": "asdas",
      "IPAddress": "asdas",
      "IsMobile": "asdas",
      // ignore: equal_keys_in_map
      "IsMobile": "asdas",
      // ignore: equal_keys_in_map
      "IsMobile": "asdas",
      "SessionId": "asdas"
    };
    return bodyHashMap;
  }

// extracts host and port from the url for http client
  // static String extractHostFromUrl(String url) {
  //   Uri uri = Uri.parse(url);
  //   String host = uri.host;
  //   if (uri.port != 80 && uri.port != 443) {
  //     host = '$host:${uri.port}';
  //   }
  //   return host;
  // }
/*
// in task manager module support person is logged in they can handle task of their employees and for that url saved s different
// this function handles the base url selection based on a boolen of isSupportMenu
  static String requestApiUrl(bool isSupportMenu) {
    var urlstore = UrlsStore.to;
    try {
      return isSupportMenu == false ? urlstore.apiUrl.value : urlstore.apiUrlTS.value;
    } catch (e) {
      print(e);
      return 'error';
    }
  }

// base url for attatchments
  static String requestBaseUrl2(bool isSupportMenu) {
    var urlstore = UrlsStore.to;
    try {
      return isSupportMenu == false ? urlstore.apiUrl.value : urlstore.apiUrlTS.value;
    } catch (e) {
      print(e);
      return 'error';
    }
  }

// handle headers based on support menu
  static Map<String, String> requestHeaders(bool isSupportMenu) {
    var profile = UserStore.to.profile.value;
    var urlstore = UrlsStore.to;
    try {
      Map<String, String> headers;
      if (isSupportMenu) {
        headers = {
          'Content-type': 'application/json',
          'TS-AuthSign': urlstore.tsAuthSign.value,
          'TS-ClientId': profile['TSCId'].toString(),
          'TS-AppKey': UserStore.to.appKeyForLogin.value,
          //additional headers for logging etc ------------
          'Client-UserId': profile['UserId'].toString(),
          'Client-Token': profile['GUID'].toString(),
          'WebUserLogId': profile['WebUserLogId'].toString()
        };
      } else {
        headers = {
          'Content-Type': 'application/json',
          'UserId': profile['UserId'].toString(),
          'Token': profile['GUID'].toString(),
          'WebUserLogId': profile['WebUserLogId'].toString(),
        };
      }
      return headers;
    } catch (e) {
      print(e);
      return {};
    }
  }
  */
}
