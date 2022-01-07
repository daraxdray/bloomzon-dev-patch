import 'dart:developer';

import 'package:equatable/equatable.dart';

class AuthState extends Equatable{
  @override

  List<Object> get props => const [];

}

class AuthSuccessful extends AuthState{
   final data;
   AuthSuccessful({this.data});
}

class AuthFailed extends AuthState{
  final error;

  AuthFailed({this.error});

  factory AuthFailed.toJson(dynamic json){
    return AuthFailed(error: json['msg']);
  }

  getError(){
    Map<String,dynamic> err = this.error['errors'];
    print(err);
    var newErr;
    err.forEach((key, value) {
      newErr = value;
    });
    return newErr[0];
  }

  getMessage(){
    if(this.error.runtimeType == String){
    return this.error;
    }

    return this.error['message'];

  }
}

class AuthInitial extends AuthState{}

class AuthProcessing extends AuthState{}

class AuthVerificationValid extends AuthState{}
class AuthVerificationFailed extends AuthState{}

class AuthIsLoggedIn extends AuthState{
  final data;
  AuthIsLoggedIn(this.data);
}

class AuthIsLoggedOut extends AuthState{}
