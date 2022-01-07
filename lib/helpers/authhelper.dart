import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

//Future<bool> checkVerified(context) async {
//  SharedPreferences pref = await SharedPreferences.getInstance();
//  var phone = await pref.get("verified_phone");
//  if (phone == null) {
//    return Navigator.of(context)
//        .push(MaterialPageRoute(builder: (context) => new PhoneVerif()));
//  } else {
//    return Navigator.of(context).push(MaterialPageRoute(
//        builder: (context) => new SignUp(
//          phone: phone,
//        )));
//  }
//}

Future<dynamic> checkLogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var isLoggedIn = pref.get('is_loggedIn') == null ? false : true;
  if (isLoggedIn == false) {
    return isLoggedIn;
  }
  var type = await getUserType(pref);
  var name = await getName(pref);
  var email = await getEmail(pref);
  var phone = await getPhone(pref);
  var userId = await getUserId(pref);
  var avatar = await getAvatar(pref);
  var pw = await getPw(pref);
  var token = await getToken(pref);
  return {
    'user_type': type,
    'email': email,
    'phone': phone,
    'id': userId,
    'status': isLoggedIn,
    'name': name,
    'avatar': avatar,
    'pw': pw,
    'token': token
  };
}

Future<void> storeVCode(data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt('vcode', data['vcode']);
  pref.setInt('vuid', data['id']);
}

Future<bool> getNotfStatus() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var status = pref.getBool('notf');
  if (status != true) {
    return false;
  }
  return status;
}

Future<bool> setNotfStatus(bool status) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool('notf', status);
  return status;
}

Future<bool> verifyCode(code) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var vcode = pref.getInt('vcode');
  if (vcode == int.parse(code)) {
    return true;
  }
  return false;
}

Future<dynamic> getVCodeInfo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var vuid = pref.getInt('vuid');
  var vcode = pref.getInt('vcode');
  return {'vcode': vcode, 'vuid': vuid};
}

Future<dynamic> userLogin(state) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool('is_loggedIn', true);
  pref.setBool('remember_me', state['remember_me']);
  pref.setString('user_type', state['type']);
  pref.setString('name', state['name']);
  pref.setString('avatar', state['avatar'] ?? '');
  pref.setString('email', state['email'] ?? '');
  pref.setString('phone', state['phone'] ?? '');
  pref.setString('pw', state['pw']);
  pref.setString('token', state['access_token']);
  pref.setString('user_id', "${state['id']}");
}

Future<String> getToken(SharedPreferences pref) async {
  return pref.get('token');
}

Future<Map<String, dynamic>> xFirstTimexLogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var nt = pref.getBool('notFirstTime');
  var lg = pref.getBool('is_loggedIn');
  var result = {'notFirstTime': nt, 'isLoggedIn': lg};
  return result;
}

Future<void> sFirstTime() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool('notFirstTime', true);
}

Future<String> getPw(SharedPreferences pref) async {
  return pref.get('pw');
}

Future<String> getUserId(SharedPreferences pref) async {
  return pref.get('user_id');
}

Future<String> getUserType(SharedPreferences pref) async {
  return pref.get('user_type');
}

Future<String> getPhone(SharedPreferences pref) async {
  return pref.get('phone');
}

Future<String> getName(SharedPreferences pref) async {
  return pref.get('name');
}

Future<String> getAvatar(SharedPreferences pref) async {
  return pref.get('avatar');
}

Future<String> getEmail(SharedPreferences pref) async {
  return pref.get('email');
}

Future<dynamic> userLogout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove('user_type');
  await pref.remove('is_loggedIn');
  bool rMe = pref.getBool('remember_me') ?? false;
  if (!rMe) {
    await pref.remove('email');
    await pref.remove('pw');
  }
  await pref.remove('user_id');
  await pref.remove('name');
  return true;
}

Future<bool> getSocialLogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var val = pref.getBool("hasSocialLogin");
  return val == null ? false : val;
}

Future setSocialLogin(bool val) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("hasSocialLogin", val);
}