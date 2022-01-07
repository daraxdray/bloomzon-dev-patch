import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:bloomzon/helpers/authhelper.dart';
import 'package:bloomzon/utils/DxNetwork.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloomzon/UI/BzWebview.dart';
import 'package:bloomzon/bloc/auth/authBloc.dart';
import 'package:bloomzon/bloc/auth/authEvent.dart';
import 'package:bloomzon/bloc/auth/authState.dart';
import 'package:bloomzon/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloomzon/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:bloomzon/UI/LoginOrSignup/Signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class lgs extends StatefulWidget {
  @override
  _lgsState createState() => _lgsState();
}

/// Component Widget this layout UI
class _lgsState extends State<lgs> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  AuthBloc _authBloc = new AuthBloc();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController phoneCtr = TextEditingController();

  //END OF FORM FIELDS
  List<bool> isSelected = [true, false];
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'NG');
  var tap = 0;
  bool rMe = true;

  Future<Null> getRme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool prefRme = pref.getBool('remember_me') ?? false;
    String prefEmail = pref.getString('email');
    String prefPw = pref.getString('pw');
    emailController.text = prefEmail;
    passController.text = prefPw;
    setState(() {
      rMe = prefRme;
    });
  }

  @override

  /// set state animation controller
  void initState() {
    rMe = false;
    isSelected = [true, false];
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    getRme();
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    super.dispose();
    // sanimationController.dispose();
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
    // mediaQueryData.size.width;
    // mediaQueryData.size.height;
    return BlocConsumer(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthFailed) {
            Fluttertoast.showToast(
                msg: "${state.getMessage()} - Please try again",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red[900]);
          }

          if (state is AuthSuccessful) {
            Fluttertoast.showToast(
                msg: "Successful Login",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green[900]);
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                tap = 1;
              });
              new LoginAnimation(
                animationController: sanimationController.view,
              );
              _PlayAnimation();
              return tap;
            });
          }
        },
        builder: (context, state) {
          // state = AuthInitial();
          return ListView(
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
                                    top: mediaQueryData.padding.top + 20.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage("assets/blogo.png"),
                                  height: 50.0,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0)),

                                /// Animation text BloomZon accept from signup layout (Click to open code)
                                Hero(
                                  tag: "bz",
                                  child: Text(
                                    "BloomZon",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.6,
                                        color: Colors.white,
                                        fontFamily: "Sans",
                                        fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),

                            /// ButtonCustomFacebook
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttonCustomFacebook(),
                                buttonCustomGoogle(),
                              ],
                            ),
                            Platform.isIOS || Platform.isMacOS
                                ? buttonCustomApple()
                                : Center(),

                            /// ButtonCustomGoogle
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 7.0)),

                            /// Set Text
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0)),
                            Text(
                              "OR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                  fontFamily: 'Sans',
                                  fontSize: 17.0),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0)),
                            ToggleButtons(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                ],
                                selectedBorderColor: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                onPressed: (index) {
                                  for (int i = 0; i < isSelected.length; i++) {
                                    setState(() {
                                      if (i == index) {
                                        isSelected[i] = true;
                                      } else {
                                        isSelected[i] = false;
                                      }
                                    });
                                  }
                                },
                                isSelected: isSelected),

                            /// TextFromField Email
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0)),
                            isSelected[0]
                                ? textFromField(
                                    icon: Icons.email,
                                    password: false,
                                    email: "Email",
                                    inputType: TextInputType.emailAddress,
                                    txController: emailController,
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Container(
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 10.0,
                                                  color: Colors.black12)
                                            ]),
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 30.0,
                                            top: 0.0,
                                            bottom: 0.0),
                                        child: Theme(
                                            data: ThemeData(
                                              hintColor: Colors.transparent,
                                            ),
                                            child:
                                                InternationalPhoneNumberInput(
                                              onInputChanged:
                                                  (PhoneNumber number) {
                                                phoneCtr.text =
                                                    number.phoneNumber;
                                              },
                                              onInputValidated: (bool value) {
                                                print(value);
                                              },
                                              selectorConfig: SelectorConfig(
                                                selectorType:
                                                    PhoneInputSelectorType
                                                        .DIALOG,
                                                useEmoji: true,
                                              ),
                                              ignoreBlank: false,
                                              autoValidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              selectorTextStyle: TextStyle(
                                                  color: Colors.black),
                                              initialValue: _phoneNumber,
                                              formatInput: false,
                                              searchBoxDecoration:
                                                  InputDecoration(
                                                icon: Icon(Icons.search),
                                                hintText: "Search your country",
                                                disabledBorder:
                                                    InputBorder.none,
                                                border: InputBorder.none,
                                              ),
                                            )))),

                            /// TextFromField Password
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0)),
                            textFromField(
                              icon: Icons.vpn_key,
                              password: true,
                              email: "Password",
                              inputType: TextInputType.text,
                              txController: passController,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: rMe,
                                  activeColor: Constant.primaryColor,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      rMe = newValue;
                                    });
                                  },
                                ),
                                Text("Remember me")
                              ],
                            ),

                            /// Button Signup
                            Container(
                                child: TextButton(
                                    //
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Signup()));
                                    },
                                    child: Text(
                                      "Not Have Acount? Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Sans"),
                                    ))),
                            Container(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new BzWebView(
                                                    data: {
                                                      'url':
                                                          "${DxNet.baseUrl}/password/reset?"
                                                    },
                                                  )
                                          ));
                                    },
                                    child: Text(
                                      "Forgot Password? Click Here",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Sans"),
                                    ))),

                            tap == 0
                                ? InkWell(
                                    splashColor: Colors.yellow,
                                    onTap: () {
                                      if ((emailController.text.isEmpty &&
                                              phoneCtr.text.isEmpty) ||
                                          passController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Email/Phone or Password cannot be empty",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red[900]);
                                        return;
                                      }
                                      String emPhone = isSelected[0] == true
                                          ? emailController.text
                                          : phoneCtr.text;
                                      bool isEmail =
                                          isSelected[0] == true ? true : false;
                                      _authBloc.add(AuthSignInEvent(rMe,
                                          isEmail: isEmail,
                                          usernameOrEmail: emPhone,
                                          password: passController.text));
                                    },
                                    child: state is AuthProcessing
                                        ? buttonBlackBottom(
                                            Constant.bzLoaderWhite)
                                        : buttonBlackBottom(null),
                                  )
                                : new LoginAnimation(
                                    animationController:
                                        sanimationController.view,
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// Set Animaion after user click buttonLogin
                ],
              ),
            ],
          );
        });
  }
}

class loginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // mediaQueryData.devicePixelRatio;
    // mediaQueryData.size.width;
    // mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        /// Set Background image in layout (Click to open code)
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/loginscreenbackground.png"),
          fit: BoxFit.cover,
        )),
        child: Container(

            /// Set gradient color in image (Click to open code)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.0),
                  Color.fromRGBO(0, 0, 0, 0.3)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),

            /// Set component layout
            child: lgs()),
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
  TextEditingController txController;

  textFromField(
      {this.email,
      this.icon,
      this.inputType,
      this.password,
      this.txController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
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
            controller: txController,
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

///buttonCustomFacebook class
class buttonCustomFacebook extends StatelessWidget {
  final labelText;
  buttonCustomFacebook({this.labelText});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: InkWell(
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => new BzWebView(
                    data: {
                      'url': "${DxNet.baseUrl}/social-login/redirect/facebook?"
                    },
                  ))),
          child: Container(
            alignment: FractionalOffset.center,
            padding: EdgeInsets.all(10),
            height: 49.0,
            decoration: BoxDecoration(
              color: Color.fromRGBO(107, 112, 248, 1.0),
              borderRadius: BorderRadius.circular(40.0),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15.0)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/img/icon_facebook.png",
                  height: 20.0,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
                Text(
                  labelText == null
                      ? "Login With Facebook"
                      : "$labelText With Facebook",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Sans'),
                ),
              ],
            ),
          ),
        ));
  }
}

// https://www.bloomzon.com
///buttonCustomGoogle class
class buttonCustomGoogle extends StatelessWidget {
  final labelText;

  buttonCustomGoogle({this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => new BzWebView(
                    data: {
                      'url': "${DxNet.baseUrl}/social-login/redirect/google?"
                    },
                  ))),
          child: Container(
            alignment: FractionalOffset.center,
            padding: EdgeInsets.all(10),
            height: 49.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.0)],
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/img/google.png",
                  height: 20.0,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
                Text(
                  labelText == null
                      ? "Login With Google"
                      : "$labelText With Google",
                  style: TextStyle(
                      color: Colors.black26,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Sans'),
                )
              ],
            ),
          )),
    );
  }
}

// https://www.bloomzon.com
///buttonCustomGoogle class
class buttonCustomApple extends StatelessWidget {
  final labelText;
  buttonCustomApple({this.labelText});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Center(
        child: SignInWithAppleButton(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          onPressed: () async {
            try {
              final credential = await SignInWithApple.getAppleIDCredential(
                scopes: [
                  AppleIDAuthorizationScopes.email,
                  AppleIDAuthorizationScopes.fullName,
                ],
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => new BzWebView(
                    data: {
                      'url':
                          "${DxNet.baseUrl}social-login/apple/callback?auth_id=${credential.identityToken}"
                    },
                  ),
                ),
              );
            } catch (_) {
              print("aborted");
              Fluttertoast.showToast(
                  msg: "Aborted by user",
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  toastLength: Toast.LENGTH_LONG);
              return;
            }
          },
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
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: content == null
            ? Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontFamily: "Sans",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              )
            : content,
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
