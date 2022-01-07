import 'dart:async';

import 'package:bloomzon/bloc/auth/authBloc.dart';
import 'package:bloomzon/bloc/auth/authEvent.dart';
import 'dart:io' show Platform;
import 'package:bloomzon/bloc/auth/authState.dart';
import 'package:bloomzon/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:bloomzon/UI/BottomNavigationBar.dart';
import 'package:bloomzon/UI/LoginOrSignup/Login.dart';
import 'package:bloomzon/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:bloomzon/UI/LoginOrSignup/Signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;
  //AUTHBLOC INSTANCE
  AuthBloc _authBloc = AuthBloc();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'NG');
  //INSTANTIATE ALL FORM FIELD CONTROLLER
  TextEditingController firstNameCtr = TextEditingController();
  TextEditingController lastNameCtr = TextEditingController();
  TextEditingController middleNameCtr = TextEditingController();
  TextEditingController emailCtr    = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController cPasswordCtr = TextEditingController();
  TextEditingController _roleCtr = TextEditingController();
  TextEditingController phoneCtr    = TextEditingController();
  //END OF FORM FIELDS
  List<bool> isSelected = [true,false];
  List<Map<String,dynamic>> roleList  = [{'value':'buyer','label':'Buyer'},
    {'value': 'seller','label':'Seller'},
    {'value': 'professional_service','label':'Professional Service'},
    {'value': 'fast_food_grocery','label':'Fast Food Grocery'},
    {'value': 'networking_associate','label':'Networking Associate'},
    {'value': 'manufacturer','label':'Manufacturer'},
  ];

  var tap = 0;

  /// Set AnimationController to initState
  @override
  void initState() {
    isSelected = [true,false];
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animationController
  @override
  void dispose() {
    super.dispose();
    sanimationController.dispose();
    _authBloc.close();
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }
  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            /// Set Background image in layout
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/img/backgroundgirl.png"),
              fit: BoxFit.cover,
            )),
            child: Container(
              /// Set gradient color in image
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.2),
                    Color.fromRGBO(0, 0, 0, 0.3)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              /// Set component layout
              child: BlocConsumer(
                bloc: _authBloc,
                listener: (context,state){
                  if(state is AuthFailed){
                    Fluttertoast.showToast(
                        msg: state.getError(),
                        toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,backgroundColor: Colors.red[900]);
                  }

                  if(state is AuthSuccessful){
                    Fluttertoast.showToast(
                        msg: "Successful Registration",
                        toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,backgroundColor: Colors.green[900]);
                    Future.delayed(Duration(seconds: 2),(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> new loginScreen()));
                    });
                  }
                },
                builder: (context,state){
                  return ListView(
                    padding: EdgeInsets.all(0.0),
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: AlignmentDirectional.topCenter,
                                child: Column(
                                  children: <Widget>[
                                    /// padding logo
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                            mediaQueryData.padding.top + 40.0)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage("assets/blogo.png"),
                                          height: 70.0,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0)),
                                        /// Animation text BloomZon accept from login layout
                                        Hero(
                                          tag: "Treva",
                                          child: Text(
                                            "BloomZon",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 0.6,
                                                fontFamily: "Sans",
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.0)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        buttonCustomFacebook(labelText:'Signup'),
                                        buttonCustomGoogle(labelText:'Signup'),
                                      ],
                                    ),
                                    Platform.isIOS ? buttonCustomApple() : Center(),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 10.0)),
                                    Container(
                                      height: 40.0,
                                      width: 200,
                                      alignment: AlignmentDirectional.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14.0),
                                           color: Colors.white,
                                          boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),

                                      child: SelectFormField(
                                        controller: _roleCtr,
                                        type: SelectFormFieldType.dropdown,
                                        cursorColor: Constant.whiteColor,
                                        decoration: InputDecoration(
                                          hintText: "Register As?",
                                          icon: Icon(Icons.location_on,color: Constant.whiteColor,),
                                          suffixIcon:Icon(Icons.arrow_drop_down,color: Constant.primaryColor ,),
                                          hintStyle: TextStyle(color: Colors.black26),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        items:roleList,
                                        onChanged: (val) => print(val),
                                        onSaved: (val) => print(val),
                                      ),
                                    ),/// TextFromField Email
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),
                                    /// TextFromField Email
                                    textFromField(
                                      icon: Icons.account_circle,
                                      password: false,
                                      email: "First name",
                                      inputType: TextInputType.name,
                                      controller: firstNameCtr,

                                    ),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),
                                    /// TextFromField Email
                                    textFromField(
                                      icon: Icons.account_circle,
                                      password: false,
                                      email: "Last name",
                                      inputType: TextInputType.name,
                                      controller: lastNameCtr,

                                    ),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),
                                    /// TextFromField Email
                                    textFromField(
                                      icon: Icons.account_circle,
                                      password: false,
                                      email: "Middle name",
                                      inputType: TextInputType.name,
                                      controller: middleNameCtr,

                                    ),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),
                                    ToggleButtons(
                                        children: [
                                     Icon(Icons.email,color: Colors.white,),
                                     Icon(Icons.phone,color: Colors.white,),
                                    ],
                                     selectedBorderColor: Colors.blue,
                                     borderRadius: BorderRadius.circular(20),
                                     onPressed: (index){
                                       for(int i = 0; i < isSelected.length; i++) {

                                         setState(() {
                                           if(i == index){
                                             isSelected[i] = true;
                                           }else{
                                             isSelected[i] = false;
                                           }
                                         });
                                       }

                                     },
                                     isSelected:isSelected),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),
                                    /// TextFromField Email
                                    isSelected[0]? textFromField(
                                      icon: Icons.email,
                                      password: false,
                                      email: "Email",
                                      inputType: TextInputType.emailAddress,
                                      controller: emailCtr,
                                    ) : Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                                      child: Container(
                                          height: 72.0,
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14.0),
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                                        padding:
                                        EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                                        child: Theme(
                                          data: ThemeData(
                                            hintColor: Colors.transparent,
                                          ),
                                          child:
                                          InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    phoneCtr.text = number.phoneNumber;
                  },
                  onInputValidated: (bool value) {
                  print(value);
                  },
                  selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,useEmoji: true,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  initialValue: _phoneNumber,
                  formatInput: false,
                  searchBoxDecoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search your country",
                  disabledBorder: InputBorder.none,
                    border: InputBorder.none,


                ),

                  )))),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),

                                    /// TextFromField Password
                                    textFromField(
                                      icon: Icons.vpn_key,
                                      password: true,
                                      email: "Password",
                                      inputType: TextInputType.text,
                                      controller: passwordCtr,
                                    ),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5.0)),

                                    /// TextFromField Password
                                    textFromField(
                                      icon: Icons.vpn_key,
                                      password: true,
                                      email: "Confirm Password",
                                      inputType: TextInputType.text,
                                      controller: cPasswordCtr,
                                    ),

                                    /// Button Login
                                   Container(
                                       padding: EdgeInsets.only(top: 10.0),
                                       child: TextButton(

                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                  new loginScreen()));
                                        },
                                        child: Text(
                                          "Have Acount? Sign In",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Sans"),
                                        ))),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: mediaQueryData.padding.top + 50.0,
                                          bottom: 0.0),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          /// Set Animaion after user click buttonLogin
                          tap == 0
                              ? InkWell(
                            splashColor: Colors.yellow,
                            onTap: () {
                             if( lastNameCtr.text.isEmpty || firstNameCtr.text.isEmpty || passwordCtr.text.isEmpty || (emailCtr.text.isEmpty && phoneCtr.text.isEmpty) || _roleCtr.text.isEmpty){
                               print(phoneCtr.text);
                               Fluttertoast.showToast(
                                   msg:
                                   "${firstNameCtr.text.isEmpty?'First Name,':''} ${lastNameCtr.text.isEmpty?'Last Name,':''} ${passwordCtr.text.isEmpty?'Password,':''} ${emailCtr.text.isEmpty && phoneCtr.text.isEmpty?'Email/Phone, ':''} ${_roleCtr.text.isEmpty?'Role':''} cannot be empty",
                                   toastLength: Toast.LENGTH_LONG,
                                   gravity: ToastGravity.BOTTOM,
                                   backgroundColor: Colors.red[900]);
                               return;
                             }
                             if(passwordCtr.text.length < 6){
                               Fluttertoast.showToast(
                                   msg:
                                   "Password length must be greater than 6",
                                   toastLength: Toast.LENGTH_LONG,
                                   gravity: ToastGravity.BOTTOM,
                                   backgroundColor: Colors.red[900]);
                               return;
                             }
                             if(passwordCtr.text != cPasswordCtr.text ){
                               Fluttertoast.showToast(
                                   msg:
                                   "Password does not match ",
                                   toastLength: Toast.LENGTH_LONG,
                                   gravity: ToastGravity.BOTTOM,
                                   backgroundColor: Colors.red[900]);
                               return;
                             }
                             Map<String,dynamic> data;
                             //check if email is used
                             if(isSelected[0] == true){
                              data = {
                               'email':emailCtr.text,
                               'password':passwordCtr.text,
                               'password_confirmation':cPasswordCtr.text,
                               'firstname':firstNameCtr.text,
                               'lastname':lastNameCtr.text,
                               'middlename':middleNameCtr.text ?? '',
                               'account_type': _roleCtr.text
                             };
                             }//else phone is used
                             else{
                             data =  {
                              'phone': phoneCtr.text,
                              'password':passwordCtr.text,
                              'password_confirmation':cPasswordCtr.text,
                              'firstname':firstNameCtr.text,
                              'lastname':lastNameCtr.text,
                              'middlename':middleNameCtr.text,
                              'account_type': _roleCtr.text
                              };
                             }

                             _authBloc.add(AuthSignUpEvent(
                                 data: data
                                 ));
                            },
                            child: state is AuthProcessing? buttonBlackBottom(Constant.bzLoaderWhite)
                                : buttonBlackBottom(null),
                          )
                              : new LoginAnimation(
                            animationController: sanimationController.view,
                          )
                        ],
                      ),
                    ],
                  );
              },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// textfromfield custom class
class textFromField extends StatelessWidget {
  bool password;
  String email;
  IconData icon;
  TextInputType inputType;
  TextEditingController controller;
  textFromField({this.email, this.icon, this.inputType, this.password, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 50.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            controller: controller,
            obscureText: password,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: email,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}



///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  Widget content;
  buttonBlackBottom(this.content);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: content == null?Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ):content,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Color(0xFF121940), Constant.secondaryColor])),
      ),
    );
  }
}
