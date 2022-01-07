import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloomzon/bloc/auth/authEvent.dart';
import 'package:bloomzon/bloc/auth/authState.dart';
import 'package:bloomzon/helpers/authhelper.dart';
import 'package:bloomzon/repository/AuthRepository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _authrep;
  StreamController _authStreamCtr;

  AuthBloc() : super(null) {
    _authrep = new AuthRepository();
  }

  dispose() {
    _authStreamCtr.close();
  }

  // TODO: implement initialState
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // TODO: implement mapEventToState
    if (event is AuthSignInEvent) {
      yield AuthProcessing();
      try {

        var response = await _authrep.login(event.rememberMe,event.usernameOrEmail, event.password,event.isEmail);

        if(response.runtimeType != String && (response['errors'] == null && response['message'] == null)){
          // await storeVCode(response);
          yield AuthSuccessful(data: response);
        }else{
          yield AuthFailed(error: response);
        }

      } catch (e) {
        yield AuthFailed(error: "Unable to login");
      }
    }
    if (event is AuthSignUpEvent) {
      yield AuthProcessing();
      try {
        var response = await _authrep.register(event.data);
        if(response['errors'] == null){
          // await storeVCode(response);
          yield AuthSuccessful(data: response);
        }else{
          yield AuthFailed(error: response);
        }
      } catch (e) {
        ////////////////////////////////////
        ////////////
        //////////////////////////////////
        //////////////////////////////////
        yield AuthFailed(
            error: "Unable to register details - Unknown Error");
      }
    }

    if(event is AuthVerificationEvent){
      yield AuthProcessing();
      try{
        bool isValid  = await verifyCode(event.code);

        if(isValid){
         var res = await _authrep.validCode();

         if(res['status']){
          yield AuthVerificationValid();
         }
        }else{
        yield AuthVerificationFailed();
        }
      }catch(e){
        print(e);
      }
    }
  }
}
