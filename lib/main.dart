import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/localization/app_localization.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/view/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguage()),
        ChangeNotifierProvider(create: (_) => PagesProvider()),
      ],
      child: Consumer<AppLanguage>(
        builder: (_, appLanguage, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("en", "US"),
            Locale("ar", ""),
          ],
          locale: appLanguage.appLocale,
          home: SplashPage(),
        ),
      ),
    );
  }
}
