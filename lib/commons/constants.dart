import 'dart:io';

class Constants {
  static String kBaseUrl =
      Platform.isIOS ? "http://localhost:8000/api" : 'http://10.0.2.2:8000/api';

  static String connectionError = "Error communicating to server";
  static String noInternet = "No Internet Connection";
}
