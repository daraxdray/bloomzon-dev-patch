import 'dart:developer';
import 'package:bloomzon/UI/LoginOrSignup/Signup.dart';
import 'package:bloomzon/UI/home-de.dart';
import 'package:bloomzon/bloc/browser/browser_cubit.dart';
import 'package:bloomzon/constant/constant.dart';
import 'package:bloomzon/helpers/authhelper.dart';
import 'package:bloomzon/utils/DxNetwork.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginOrSignup/Login.dart';
import 'LoginOrSignup/ChoseLoginOrSignup.dart';

class BzWebView extends StatefulWidget {
  final data; //expect subscription model for this WebView

  BzWebView({this.data});
  @override
  _BzWebViewState createState() => _BzWebViewState();
}

class _BzWebViewState extends State<BzWebView> {
  InAppWebViewController _webViewController;
  int currentIndex = 0;
  DateTime currentBackPressTime;
  double progress = 0;
  Codec<String, String> stringToB64 =
      utf8.fuse(base64); //instantiate the encoder
  bool isLoading, showErrorPage;
  bool isSocial = false;
  String mobile = "&xmd=a103650ce9d64de3bc4df68a3df53e418617fc39";

  var _logged;
  BrowserCubit bwCubit = new BrowserCubit(0);
  void getLogStatus() async {
    var data;

    try {
      data = await checkLogin();
    } catch (e) {
      print(e);
    }
    setState(() {
      _logged = data;
    });
    bwCubit.setState(1);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    showErrorPage = false;
    getLogStatus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bwCubit.close();
    super.dispose();
  }

  void showError() {
    setState(() {
      showErrorPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: WillPopScope(
          child: BlocBuilder(
            bloc: bwCubit,
            builder: (context, state) {
              if (state == 1) {
                var params = '';
                if (_logged != null && _logged != false) {
                  params =
                      "&mdxEmail=${_logged['email']}&mdxPw=${_logged['pw']}&mdxPhone=${_logged['phone']}";
                }
                // print(
                //     "${widget.data['url']}&xmd=a103650ce9d64de3bc4df68a3df53e418617fc39$params");
                return Stack(
                  children: <Widget>[
                    InAppWebView(
                      initialUrlRequest: URLRequest(url: Uri.parse("${widget.data['url']}&xmd=a103650ce9d64de3bc4df68a3df53e418617fc39$params")),
                       // 
                      // shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
                      //   if(Platform.isAndroid || shouldOverrideUrlLoadingRequest.iosWKNavigationType == IOSWKNavigationType.LINK_ACTIVATED)
                      //   {
                      //     controller.loadUrl(url: shouldOverrideUrlLoadingRequest.url, headers: {"Authorization":"Bearer $token}"});
                      //     return ShouldOverrideUrlLoadingAction.CANCEL;
                      //   }
                      //   return ShouldOverrideUrlLoadingAction.ALLOW;
                      // },
                      initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(),
                          crossPlatform: InAppWebViewOptions(
                            userAgent:                             // "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36",
                                "Mozilla/5.0 (iPhone; CPU iPhone OS 15_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1",
                            useShouldOverrideUrlLoading: true// patch ++ WebView browser version
                          ),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                        // print(_webViewController.getUrl());
                      },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url;
              uri.queryParameters.addAll({'xmd':'a103650ce9d64de3bc4df68a3df53e418617fc39'});
              },
                      onLoadStart: (controller, url) {
                        _webViewController = controller;

                        loading(true);
                          if (url.path == "${DxNet.baseUrl}logout") {
                            setSocialLogin(false);
                          }
                          if (url.path == "${DxNet.baseUrl}users/login" ||
                              url.path == "${DxNet.baseUrl}login") {
                            // _webViewController.goBack();
                            userLogout().then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        new loginScreen()))); //go back to homepage

                          }
                          if (url.path == "${DxNet.baseUrl}users/registration" ||
                              url.path == "${DxNet.baseUrl}registration") {
                            // _webViewController.goBack();
                            userLogout().then((value) =>
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new Signup()))); //go back to homepage

                          }
                          if (url.path.contains("${DxNet.baseUrl}social-login") &&
                              url.path.contains("apple/callback")) {
                            isSocial = true;
                          }
                      },
                      onLoadStop: (controller, url) async {
                        loading(false);
                        //
                          if (isSocial &&
                              url.path != "${DxNet.baseUrl}users/login" &&
                              url.path != "${DxNet.baseUrl}login") {
                            setSocialLogin(true);
                            isSocial = false;
                          }
                      },
                      onLoadError: (controller, url, i, s){
                        controller.stopLoading();
                        // loading(false);
                    if(i == -1009 || i == -2){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new CustomMenu()));
                        Fluttertoast.showToast(msg:s,backgroundColor: Colors.red,gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                      }else if(i != -999){
                        Fluttertoast.showToast(msg:s,backgroundColor: Colors.red,gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                        showError();
                      }
                      },
                      // onLoadStart: (InAppWebViewController controller,
                      //     String url) async {
                      //   // print(url);
                      //   _webViewController = controller;
                      //   loading(true);
                      //   if (url == "${DxNet.baseUrl}logout") {
                      //     setSocialLogin(false);
                      //   }
                      //   if (url == "${DxNet.baseUrl}users/login" ||
                      //       url == "${DxNet.baseUrl}login") {
                      //     // _webViewController.goBack();
                      //     userLogout().then((value) => Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 new loginScreen()))); //go back to homepage
                      //
                      //   }
                      //   if (url == "${DxNet.baseUrl}users/registration" ||
                      //       url == "${DxNet.baseUrl}registration") {
                      //     // _webViewController.goBack();
                      //     userLogout().then((value) =>
                      //         Navigator.pushReplacement(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     new Signup()))); //go back to homepage
                      //
                      //   }
                      //   if (url.contains("${DxNet.baseUrl}social-login") &&
                      //       url.contains("apple/callback")) {
                      //     isSocial = true;
                      //   }
                      // },
                      // onLoadStop: (InAppWebViewController controller,
                      //     String url) async {
                      //   loading(false);
                      //
                      //   if (isSocial &&
                      //       url != "${DxNet.baseUrl}users/login" &&
                      //       url != "${DxNet.baseUrl}login") {
                      //     setSocialLogin(true);
                      //     isSocial = false;
                      //   }
                      // },
                      // onLoadError: (InAppWebViewController controller,
                      //     String url, int i, String s) async {
                      //   print('CUSTOM_HANDLER: $i, $s , $url');
                      //   print(i != -999);
                      //   if(i == -1009 || i == -2){
                      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //         new CustomMenu()));
                      //     Fluttertoast.showToast(msg:s,backgroundColor: Colors.red,gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                      //   }else if(i != -999){
                      //     Fluttertoast.showToast(msg:s,backgroundColor: Colors.red,gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                      //     showError();
                      //   }
                      //   /** instead of printing the console message i want to render a static page or display static message **/
                      // },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                          },
                    ),
                    isLoading == true ? Constant.bzLoaderDefault : Container(),
                    showErrorPage == true
                        ? Center(
                            child: Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                height: double.infinity,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Image.asset('assets/img/not_found.png'),
                                    TextButton.icon(
                                        onPressed: () => goBackUrl(),
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.black38,
                                        ),
                                        label: Text(
                                          "Go Back",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 20),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                        child: TextButton.icon(
                                            onPressed: () =>
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            new  BzWebView(data: {
                                                              'url': "${DxNet.baseUrl}?",
                                                            }))),
                                            icon: Icon(
                                              Icons.home_outlined,
                                              color: Colors.black38,
                                              size: 12,
                                            ),
                                            label: Text(
                                              "Home",
                                              style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 12),
                                            )))
                                  ],
                                )))
                        : Container()
                  ],
                );
              }
              return Center(
                child: Constant.bzLoaderDefault,
              );
            },
          ),
          onWillPop: () async {
            var backStatus = goBackUrl();
            if (backStatus == true) {
              exit(0);
            }
            return false;
          }),

      appBar: AppBar(
        backgroundColor: Constant.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: InkWell(
          onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => new BzWebView(data: {
                    'url': "${DxNet.baseUrl}?",
                  }))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/blogo_text.png"),
                height: 40.0,
              ),
              SizedBox(width: 5.0),
              // Text(
              //   city,
              //   style: appBarLocationTextStyle,
              // ),
            ],
          ),
        ),
        actions: [
         FutureBuilder(
           future: _webViewController?.getUrl(),
           builder: (builder,snap){
             if(snap.hasData && snap.data.toString().contains('estate')){
               return IconButton(
                 icon: Icon(
                   Icons.home,
                   color: Constant.blackColor,
                 ),
                 onPressed: (){
                   Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(
                           builder: (context) => new BzWebView(data: {
                             'url': "${DxNet.baseUrl}?"
                           })));
                 },
               );
             }else{
               return Container();
             }

           },
         ),

          IconButton(
            icon: Icon(
              Icons.local_shipping,
              color: Constant.blackColor,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new BzWebView(data: {
                            'url': "${DxNet.baseUrl}track_your_order?"
                          })));
            },
          ),

        ],
      ),
    );
  }

  loading(bool status) {
    if (status) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  goBackUrl() async {
      _webViewController.stopLoading();
    // if (_webViewController != null) {
    //   bool canGo = await _webViewController.canGoBack();
    //   if (canGo) {
    //     _webViewController.goBack();
    //     return false;
    //   }
    // }
    // if (_logged != null && _logged != false) {
    //   DateTime now = DateTime.now();
    //   if (currentBackPressTime == null ||
    //       now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    //     currentBackPressTime = now;
    //     Fluttertoast.showToast(
    //       msg: 'Press Back Once Again to Exit.',
    //       backgroundColor: Colors.black,
    //       textColor: Constant.whiteColor,
    //     );
    //     return false;
    //   } else {
    //     exit(0);
    //   }
    // } else {
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => new ChoseLogin()));
    // }
  }

  void _login(InAppWebViewController ctr, BuildContext context, data) async {
    // await ctr.evaluateJavascript();
  }
}
