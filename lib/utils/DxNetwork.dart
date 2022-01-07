import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'CustomException.dart';

class DxNet {
  // final appId = "com.example.lonux";
  // static const _apiKey = "AIzaSyCBoeN56JTOlbsPvfK4ltGPAdDaRSrFaog";

  // String get apiKey => _apiKey;
  var queryLink;
  final http.Client dxClient;
  // static final baseUrl = "http://192.168.43.119/bloomzon-store/";
  static final baseUrl = "https://bloomzon.com/";
  static final localUrl = "https://bloomzon.com/api/v1/";
  // static final localUrl = "http://192.168.43.119/bloomzon-store/api/v1/";
  static const SSK = "04a5cd34a972eb13c74261d8457b2d7a";
  final defaultHeader = {'Accept': "application/json", 'ssk': SSK};
  DxNet({this.dxClient});

  //use this as get request for apis
  Future<dynamic> get(String url, {body, headers}) async {
    var responseJson;

    try {
      final response = await dxClient.get(Uri.parse(localUrl + url),
          headers: headers ?? defaultHeader);
      if (response.statusCode == 200) {
        responseJson = _response(response);
      } else {
        throw Exception('Request Error: ${response.statusCode}');
      }
    } on SocketException {
      print("caught error ");
    }

    return responseJson;
  }

  Future<bool> shake(String url,
      {body, headers = const {'Accept': "Application/json"}}) async {
    try {
      final response = await dxClient.get(Uri.parse(url), headers: headers);
      if (response.statusCode >= 200 || response.statusCode < 300 ) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      print("caught error ");
    }
  }

//using post method on api

  Future<dynamic> post(String url,
      {body, headers = const {'Accept': "Application/json"}, encoding}) async {
    var responseJson;
    try {
      final result = await http
          .post(Uri.parse(localUrl + url),
              body: body, headers: headers, encoding: encoding)
          .then((http.Response response) {
        final String res = response.body;

        final int statusCode = response.statusCode;
        if (statusCode < 200 || json == null) {
          throw new Exception(
              "Error while fetching data, Error: ${response.statusCode}");
        }
        // if (statusCode >= 500) {
        //   throw new Exception("Oops!!! Internal server error"+ statusCode.toString());
        //
        // }
        // if (statusCode >= 400 && statusCode < 500) {
        //   throw new Exception("Could not match your details - please try again with correct input");
        //
        // }
        responseJson = _response(response);
      });
    } catch (e) {
      print(e);
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

//   Future<dynamic> postBogio(String url,
//       {body, headers = const {'Accept': "Application/json"}, encoding}) async {
//     var responseJson;
//     try {
//       final result = await http
//           .post(bogio + url,
//               body: body, headers: bogioHeaders, encoding: encoding)
//           .then((http.Response response) {
//         final String res = response.body;
//
//         final int statusCode = response.statusCode;
//         if (statusCode < 200 || json == null) {
//           throw new Exception(
//               "Error while fetching data, Error: ${response.statusCode}");
//         }
// //        if (statusCode >= 500) {
// //          throw new Exception("Oops!!! Internal server error"+ statusCode.toString());
// //
// //        }
// //        if (statusCode >= 400 && statusCode < 500) {
// //          throw new Exception("Could not match your details - please try again with correct input");
// //
// //        }
//         responseJson = _response(response);
//       });
//     } on SocketException {
//       throw FetchDataException('No Internet connection');
//     }
//     return responseJson;
//   }

  //handles the response from api
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson;
        if (response.body.isNotEmpty) {
          responseJson = json.decode(response.body);
        } else {
          responseJson = json.decode("[result]");
        }
        return responseJson;
      case 201:
        var responseJson;
        if (response.body.isNotEmpty) {
          responseJson = json.decode(response.body);
        } else {
          responseJson = json.decode("[result]");
        }
        return responseJson;
        break;
      case 203:
        var responseJson;
        if (response.body.isNotEmpty) {
          responseJson = json.decode(response.body);
        } else {
          responseJson = json.decode("[result]");
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 422:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw InternalServerError(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communicating with Server with StatusCode : ${response.statusCode}');
    }
  }
}
