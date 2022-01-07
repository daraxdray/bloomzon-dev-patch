
import 'package:bloomzon/Library/carousel_pro/src/carousel_pro.dart';
import 'package:bloomzon/UI/BzWebview.dart';
import 'package:bloomzon/UI/HomeUIComponent/AppbarGradient.dart';
import 'package:bloomzon/UI/HomeUIComponent/Home.dart';
import 'package:bloomzon/UI/HomeUIComponent/MenuDetail.dart';
import 'package:bloomzon/repository/ApiRep.dart';
import 'package:bloomzon/utils/DxNetwork.dart';
import 'package:flutter/material.dart';
import 'package:bloomzon/Library/countdown/countdown.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomeUIComponent/CategoryDetail.dart';

class CustomMenu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

/// Component all widget in home
class _MenuState extends State<CustomMenu> with TickerProviderStateMixin {
  ApiRep _apiRep = ApiRep();
  /// Declare class GridItem from HomeGridItemReoomended.dart in folder ListItem
  // GridItem gridItem;

  // bool isStarted = false;
  // var hourssub, minutesub, secondsub;
  // /// CountDown for timer
  // CountDown hours, minutes, seconds;
  // int hourstime, minute, second = 0;

  /// Set for StartStopPress CountDown
  // onStartStopPress() {
  //   if (this.secondsub == null) {
  //     secondsub = seconds.stream.listen(null);
  //     secondsub.onData((Duration d) {
  //       print(d);
  //       setState(() {
  //         second = d.inSeconds;
  //       });
  //     });
  //   }
  //   if (this.minutesub == null) {
  //     minutesub = minutes.stream.listen(null);
  //     minutesub.onData((Duration d) {
  //       print(d);
  //       setState(() {
  //         minute = d.inMinutes;
  //       });
  //     });
  //   }
  //   if (this.hourssub == null) {
  //     hourssub = hours.stream.listen(null);
  //     hourssub.onData((Duration d) {
  //       print(d);
  //       setState(() {
  //         hourstime = d.inHours;
  //       });
  //     });
  //   }
  // }

  /// To set duration initState auto start if FlashSale Layout open
  @override
  void initState() {
    // hours = new CountDown(new Duration(hours: 24));
    // minutes = new CountDown(new Duration(hours: 1));
    // seconds = new CountDown(new Duration(minutes: 1));

    // onStartStopPress();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // double size = mediaQueryData.size.height;

    /// Navigation to MenuDetail.dart if user Click icon in category CustomMenu like a example camera
    var onClickMenuIcon = () {
      // Navigator.of(context).push(PageRouteBuilder(
      //     pageBuilder: (_, __, ___) => new menuDetail(),
      //     transitionDuration: Duration(milliseconds: 750),
      //     /// Set animation with opacity
      //     transitionsBuilder:
      //         (_, Animation<double> animation, __, Widget child) {
      //       return Opacity(
      //         opacity: animation.value,
      //         child: child,
      //       );
      //     }));
      _apiRep.shake("https://www.google.com").then((e)=>{
        if(e == true){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>new BzWebView(
        data: {
          'url':
          "${DxNet.baseUrl}/search?"
        },
      )))
        }else{
          Fluttertoast.showToast(msg:"No internet connection",gravity:ToastGravity.CENTER,backgroundColor: Colors.red, toastLength: Toast.LENGTH_LONG,)
        }
      });
    };

    /// Navigation to promoDetail.dart if user Click icon in Week Promotion
    var onClickWeekPromotion = () {
      // Navigator.of(context).push(PageRouteBuilder(
      //     pageBuilder: (_, __, ___) => new promoDetail(),
      //     transitionDuration: Duration(milliseconds: 750),
      //     transitionsBuilder:
      //         (_, Animation<double> animation, __, Widget child) {
      //       return Opacity(
      //         opacity: animation.value,
      //         child: child,
      //       );
      //     }));
    };

    /// Navigation to categoryDetail.dart if user Click icon in Category
    void onClickCategory(type,url) {
      _apiRep.shake("https://www.google.com").then((e)=>{
      if(e == true){
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new BzWebView(
              data: {
                'url':
                "${DxNet.baseUrl}/$url"
              },
            ),
            transitionDuration: Duration(milliseconds: 750),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }))

      }else{
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new categoryDetail(url:url,title: type,),
            transitionDuration: Duration(milliseconds: 750),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }))
      }
      });
    }

    /// Declare device Size
    var deviceSize = MediaQuery.of(context).size;

    /// ImageSlider in header
    var imageSlider = Container(
      height: 182.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        dotColor: Color(0xFF6991C7).withOpacity(0.8),
        dotSize: 5.5,
        dotSpacing: 16.0,
        dotBgColor: Colors.transparent,
        showIndicator: true,
        overlayShadow: true,
        overlayShadowColors: Colors.white.withOpacity(0.9),
        overlayShadowSize: 0.9,
        images: [
          AssetImage("assets/img/bl_ads.png"),
          AssetImage("assets/img/bl_ad2.png"),
          AssetImage("assets/img/bl_ad3.png"),
          AssetImage("assets/img/ps5.jpg"),
          AssetImage("assets/img/samsung.jpg"),
        ],
      ),
    );

    /// CategoryIcon Component
    var categoryIcon = Container(
      color: Colors.black,
      padding: EdgeInsets.only(top: 20.0),
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 0.0),
            child: Text(
              "Menu",
              style: TextStyle(
                  fontSize: 13.5,
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),

          /// Get class CategoryIconValue
          CategoryIconValue(
            tap1: onClickMenuIcon,
            icon1: "assets/icon/camera.png",
            title1: "Camera",
            tap2: onClickMenuIcon,
            icon2: "assets/icon/food.png",
            title2: "Food",
            tap3: onClickMenuIcon,
            icon3: "assets/icon/handphone.png",
            title3: "Handphone",
            tap4: onClickMenuIcon,
            icon4: "assets/icon/game.png",
            title4: "Gaming",
          ),
          Padding(padding: EdgeInsets.only(top: 23.0)),
          CategoryIconValue(
            icon1: "assets/icon/fashion.png",
            tap1: onClickMenuIcon,
            title1: "Fashion",
            icon2: "assets/icon/health.png",
            tap2: onClickMenuIcon,
            title2: "Health Care",
            icon3: "assets/icon/pc.png",
            tap3: onClickMenuIcon,
            title3: "Computer",
            icon4: "assets/icon/mesin.png",
            tap4: onClickMenuIcon,
            title4: "Equipment",
          ),
          Padding(padding: EdgeInsets.only(top: 23.0)),
          CategoryIconValue(
            icon1: "assets/icon/otomotif.png",
            tap1: onClickMenuIcon,
            title1: "Otomotif",
            icon2: "assets/icon/sport.png",
            tap2: onClickMenuIcon,
            title2: "Sport",
            icon3: "assets/icon/ticket.png",
            tap3: onClickMenuIcon,
            title3: "Ticket Cinema",
            icon4: "assets/icon/book.png",
            tap4: onClickMenuIcon,
            title4: "Books",
          ),
          Padding(padding: EdgeInsets.only(bottom: 30.0))
        ],
      ),
    );

    /// Category Component in bottom of flash sale
    var categoryImageBottom = Container(
      height: 310.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              "Vendors",
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Sans"),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      CategoryItemValue(
                        image: "assets/img/bl_ads.png",
                        title: "Sellers",
                        tap: ()=> onClickCategory('Sellers','vendors/sellers?'),
                        color: Color.fromARGB(225, 255, 14, 14)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      CategoryItemValue(
                        image: "assets/imgItem/category1.png",
                        title: "Professional Service",
                        tap: ()=> onClickCategory('Professional Service','professional?'),
                          color: Color.fromARGB(225, 14, 82, 255)
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    CategoryItemValue(
                      image: "assets/imgItem/category3.png",
                      title: "Manufacturers",
                      tap: ()=> onClickCategory('Manufacturer','vendors/manufacturer?'),
                      color: Color.fromARGB(225, 0, 0, 0)
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    CategoryItemValue(
                      image: "assets/imgItem/category4.png",
                      title: "Food & Restaurants",
                      tap:()=>  onClickCategory('Food & Restaurants','vendors/fast_food_grocery?'),
                      color: Color.fromARGB(225, 47, 0, 64)
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    CategoryItemValue(
                      image: "assets/imgItem/category5.png",
                      title: " Fashion Design & Tailoring",
                      tap: ()=> onClickCategory('Fashion Design & Tailoring','vendors/fashion?'),
                      color: Color.fromARGB(225, 255, 14, 14)
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    CategoryItemValue(
                      image: "assets/imgItem/category6.png",
                      title: "Travels & SharesHome",
                      tap:()=>  onClickCategory('Travels & SharesHome','coming-soon?'),
                        color: Color.fromARGB(225, 147, 103, 2)
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    CategoryItemValue(
                      image: "assets/imgItem/category7.png",
                      title: "Real Estate",
                      tap: ()=> onClickCategory('Real Estate','estate?'),
                      color: Color.fromARGB(225, 14, 82, 255)
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    CategoryItemValue(
                      image: "assets/imgItem/category8.png",
                      title: "Bloomzon Products",
                      tap:()=>  onClickCategory('Bloomzon Products','search?q=bloomzon'),
                      color: Color.fromARGB(225, 0, 0, 0)
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );

    return Scaffold(
      /// Use Stack to costume a appbar
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.padding.top + 58.5)),
                /// Call var imageSlider
                imageSlider,

                /// Call var categoryIcon
                categoryIcon,
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                categoryImageBottom,
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),


              ],
            ),
          ),

          /// Get a class AppbarGradient
          /// This is a Appbar in home activity
          AppbarGradient(),
        ],
      ),
    );
  }
}
