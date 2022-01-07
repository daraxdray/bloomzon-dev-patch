import 'package:bloomzon/repository/ApiRep.dart';
import 'package:flutter/material.dart';
// import 'package:bloomzon/UI/AcountUIComponent/Notification.dart';
import 'package:bloomzon/UI/HomeUIComponent/Search.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:bloomzon/UI/AcountUIComponent/Message.dart';

class AppbarGradient extends StatefulWidget {
  @override
  _AppbarGradientState createState() => _AppbarGradientState();
}

class _AppbarGradientState extends State<AppbarGradient> {
  String CountNotice = "4";
  ApiRep _apiRep = ApiRep();
    /// Build Appbar in layout home
  @override
  Widget build(BuildContext context) {

    /// Create responsive height and padding
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    /// Create component in appbar
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: 58.0 + statusBarHeight,
      decoration: BoxDecoration(
        /// gradient in appbar
          gradient: LinearGradient(
              colors: [
                const Color(0xFF084DC2),
                const Color(0xFF00326F),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /// if user click shape white in appbar navigate to search layout
          InkWell(
            onTap: () {
              // Navigator.of(context).push(PageRouteBuilder(
              //     pageBuilder: (_, __, ___) => searchAppbar(),
              //     /// transtation duration in animation
              //     transitionDuration: Duration(milliseconds: 750),
              //     /// animation route to search layout
              //     transitionsBuilder:
              //         (_, Animation<double> animation, __, Widget child) {
              //       return Opacity(
              //         opacity: animation.value,
              //         child: child,
              //       );
              //     }));
            },
            /// Create shape background white in appbar (background BloomZon text)
            child: Container(
              margin: EdgeInsets.only(left: media.padding.left + 15),
              height: 37.0,
              width: 222.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  shape: BoxShape.rectangle),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 17.0)),
                  Image.asset(
                    "assets/img/search2.png",
                    height: 22.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    left: 17.0,
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      "BloomZon",
                      style: TextStyle(
                          fontFamily: "Popins",
                          color: Colors.black12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.0,
                          fontSize: 16.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /// Icon chat (if user click navigate to chat layout)
          // InkWell(
          //     onTap: () {
          //       Navigator.of(context).push(
          //           PageRouteBuilder(pageBuilder: (_, __, ___) => new chat()));
          //     },
          //     child: Image.asset(
          //       "assets/img/chat.png",
          //       height: media.devicePixelRatio + 20.0,
          //     )),
          /// Icon notification (if user click navigate to notification layout)
          InkWell(
            onTap: () {
              // Navigator.of(context).push(PageRouteBuilder(
              //     pageBuilder: (_, __, ___) => new notification()));
              _apiRep.shake("https://www.google.com").then((e)=>{
               if(e == true){
                  Navigator.of(context).pushReplacementNamed("home")
               }else{
                 Fluttertoast.showToast(msg:"No internet connection",gravity:ToastGravity.CENTER,backgroundColor: Colors.red, toastLength: Toast.LENGTH_LONG,)
              }
              });
            },
            child: Stack(
              alignment: AlignmentDirectional(-3.0, -3.0),
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,

                ),
                CircleAvatar(
                  radius: 8.6,
                  backgroundColor: Colors.redAccent,
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 13.0, color: Colors.white),
                  ),
                )
              ],
            ),

          ),
        ],
      ),
    );
  }
}
