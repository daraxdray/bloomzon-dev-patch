import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloomzon/bloc/auth/authState.dart';

abstract class AuthEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => const [];
}

class AuthSignInEvent extends AuthEvent{
  final usernameOrEmail;
  final password;
  final bool isEmail;
  final bool rememberMe;
  AuthSignInEvent(this.rememberMe, {this.isEmail,this.usernameOrEmail, this.password});

}

class AuthSignUpEvent extends AuthEvent{
 final data;
  AuthSignUpEvent({@required this.data});

}

class AuthSignOutEvent extends AuthEvent{
  final phone;
  final password;

  AuthSignOutEvent(this.phone, this.password);


}

class AuthVerificationEvent extends AuthEvent{
  final code;

  AuthVerificationEvent(this.code);
}


class AuthCheckStatus extends AuthEvent{}

