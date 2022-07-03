import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/history_page.dart';
import 'package:zari/view/login_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final pagesProvider = Provider.of<PagesProvider>(context);
    final langProvider = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.clear),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (langProvider.appLanguage == "en") {
                langProvider.changeLanguage(Locale("ar"));
              } else {
                langProvider.changeLanguage(Locale("en"));
              }
            },
            child: Text(
              langProvider.appLanguage == "en" ? "العربية" : "English",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  reset();
                  pagesProvider.setPage("home");
                },
                child: Text(
                  localize(context, "home")!,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  reset();
                  pagesProvider.setPage("history");
                },
                child: Text(
                  localize(context, "history")!,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  pagesProvider.setPage("about");
                },
                child: Text(
                  localize(context, "about")!,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  pagesProvider.setPage("join");
                },
                child: Text(
                  localize(context, "joinUs")!,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  pagesProvider.setPage("contact");
                },
                child: Text(
                  localize(context, "contact")!,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  if (PrefManager.currentUser != null) {
                    PrefManager.setCurrentUser(null).then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                        (route) => false,
                      );
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  }
                },
                child: Text(
                  PrefManager.currentUser != null
                      ? localize(context, "logout")!
                      : localize(context, "login")!,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
