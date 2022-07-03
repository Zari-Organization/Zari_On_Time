import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/about_us_page.dart';
import 'package:zari/view/booking_page.dart';
import 'package:zari/view/branches_page.dart';
import 'package:zari/view/brands_page.dart';
import 'package:zari/view/contact_page.dart';
import 'package:zari/view/history_page.dart';
import 'package:zari/view/home_page.dart';
import 'package:zari/view/join_page.dart';
import 'package:zari/view/menu_page.dart';
import 'package:zari/view/more_page.dart';
import 'package:zari/view/profile_page.dart';
import 'package:zari/view/service_details_page.dart';
import 'package:zari/view/services_page.dart';

import 'search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  void onTabTapped(int index) {
    setState(() {
      print(index);
      selectedPage = index;
    });
  }

  final _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
    MorePage(),
  ];
  // Map<String, dynamic> pages = {
  //   "home": HomePage(),
  //   "history": HistoryPage(),
  //   "about": AboutUsPage(),
  //   "join": JoinPage(),
  //   "contact": ContactPage(),
  //   "brands": BrandsPage(),
  //   "branches": BranchesPage(),
  //   "services": ServicesPage(),
  //   "book": BookingPage(),
  //   "historyDetails": ServiceDetailsPage(),
  //   "profile": ProfilePage(),
  // };

  @override
  Widget build(BuildContext context) {
    final pagesProvider = Provider.of<PagesProvider>(context);
    return WillPopScope(
      onWillPop: () {
        if (pagesProvider.currentPage != "home") {
          pagesProvider.setPage("home");
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.QUESTION,
            animType: AnimType.SCALE,
            title: localize(context, "closeApp")!,
            btnOk: MaterialButton(
              color: Colors.green,
              onPressed: () {
                exit(0);
              },
              child: Text(
                localize(context, "yes")!,
                style: TextStyle(color: Colors.white),
              ),
            ),
            btnCancel: MaterialButton(
              color: Colors.redAccent,
              onPressed: () => Navigator.pop(context),
              child: Text(
                localize(context, "no")!,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ).show();
        }
        return null!;
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: AppColors.GRAY_APPBAR,
        //   elevation: 0,
        //   actions: [
        //     IconButton(
        //       onPressed: () => pagesProvider.setPage("profile"),
        //       icon: Icon(
        //         Icons.person,
        //         color: Colors.amber,
        //       ),
        //     ),
        //   ],
        // ),
        //  drawer: MenuPage(),
        body: _pages[selectedPage],
        //   body: pages[pagesProvider.currentPage],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          child: BottomAppBar(
            color: AppColors.GRAY_APPBAR,
            elevation: 10,
            shape: CircularNotchedRectangle(),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,

              selectedItemColor: AppColors.YALLOW_BUTTON,
              unselectedItemColor: Colors.grey,
              backgroundColor: AppColors.GRAY_APPBAR,
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/Home.png'),
                  ),
                  label: localize(context, "home")!,
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/Search.png'),
                  ),
                  label: localize(context, "search")!,
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/Profile.png'),
                  ),
                  label: localize(context, "profile")!,
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/More Circle.png'),
                  ),
                  label: localize(context, "more")!,
                ),
              ],
              currentIndex: selectedPage,
              // currentIndex: pagesProvider.currentPage,
              //    selectedItemColor: Colors.amber[800],
              onTap: onTabTapped,
            ),
          ),
        ),
      ),
    );
  }
}
