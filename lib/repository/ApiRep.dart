import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloomzon/helpers/authhelper.dart';
import 'package:bloomzon/utils/DxNetwork.dart';

class ApiRep {
  static final http.Client client = http.Client();
  DxNet _helper = DxNet(dxClient: client);

  Future<dynamic> get(url, {body = const {}}) async {
    var shake = true;
    await _helper.shake("https://google.com");
    if(shake){
      var result = await _helper.get(url, body: body);
      return result;
    }
    return {};
  }

  Future<List> post(url, {body = const {}}) async {
    var result = await _helper.get(url, body: body);
    return result;
  }
  Future<bool> shake(url, {body = const {}}) async {
    var result = await _helper.shake(url, body: body);
    debugPrint(result.toString());
    return result;
  }


}
