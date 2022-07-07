import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zari/constants.dart';
import 'package:zari/view/about_us_page.dart';
import 'package:zari/view/have_fun_page.dart';
import 'package:zari/view/history_page.dart';
import 'package:zari/view/join_page.dart';
import 'package:zari/view/main_page.dart';
import 'package:zari/view/offer_page.dart';
import 'package:zari/view/where_do_I_go.dart';

class Utils {
  static route(int indexRoute, BuildContext context) {
    if (indexRoute < 4) {
      print('indexRoute:  $indexRoute');
      switch (indexRoute) {
        case 0:
          return Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        case 1:
          return Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => OfferPage()),
          );
        case 2:
          return Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HaveFunPage()),
          );
        case 3:
          return Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WhereDoIGoPage()),
          );

        default:
          return Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MainPage()),
          );
      }
    }
  }

  static route_Login(String route, BuildContext context) {
    print('indexRoute:  $route');
    switch (route) {
      case 'Pop':
        return Navigator.of(context).pop();
      case 'Profile':
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      case 'More':
        return Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      case 'First':
        return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => MainPage()),
          (route) => false,
        );
      // case 3:
      //   return Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => WhereDoIGoPage()),
      //   );

      default:
        return Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MainPage()),
        );
    }
  }

  static backgroundColor(int index) {
    switch (index) {
      case 0:
        return Colors.white;

      case 1:
        return Color(0xFFE5E5E5);
      case 2:
        return Color(0xFFE5E5E5);

      case 3:
        return Color(0xFFE5E5E5);

      default:
        return Colors.white;
    }
  }

  static list_welcom(BuildContext context, int index) {
    switch (index) {
      case 0:
        return localize(context, "booking")!;

      case 1:
        return localize(context, "offers")!;
      case 2:
        return localize(context, "havefun")!;

      case 3:
        return localize(context, "wheretogo")!;

      default:
        return localize(context, "wheretogo")!;
    }
  }

  static select_index(int index) {
    switch (index) {
      case 0:
        return 0;

      case 1:
        return 1;
      case 2:
        return 2;

      case 3:
        return 3;

      default:
        return 0;
    }
  }
}
