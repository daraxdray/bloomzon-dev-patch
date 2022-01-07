import 'dart:developer';

import 'package:bloomzon/helpers/authhelper.dart';
import 'package:bloomzon/utils/DxNetwork.dart';
import 'package:http/http.dart' as http;

class AuthRepository{

  static final http.Client client = http.Client();
  DxNet _helper = DxNet(dxClient: client );
  var user;

  Future<dynamic> login(rMe, username,password,bool isEmail) async {

    var userInfo = isEmail == true? {"email":username,"password":password,"notRider":"true"}: {"phone":"$username","password":password,"notRider":"true"};

    final response = await _helper.post("auth/login",body:userInfo);
    log("USER DETAILS",error: response);
    if(response['user'] == null )
    {
      return response;
    }

      response['user']['pw'] = password;
      response['user']['access_token'] = response['access_token'];
      response['user']['remember_me'] = rMe;
      userLogin(response['user']);
      return response;

  }

  Future<dynamic> validCode() async {
    var info = await getVCodeInfo();
    var userInfo = {"userId":  "${info['vuid']}","code":"${info['vcode']}"};
    final response = await _helper.post("users/activate",body:userInfo);
    return response;
  }
Future<dynamic> tryit() async {
    final response = await _helper.get("");
    print(response);
    return response;
  }

  Future<dynamic> register(data) async {
    final response = await _helper.post("auth/signup",body:data);
    return response;
  }




}