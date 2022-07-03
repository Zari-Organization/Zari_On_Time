import 'package:flutter/foundation.dart';

class PagesProvider with ChangeNotifier {
  String _currentPage = "home";
  String get currentPage => _currentPage;

  setPage(page) {
    _currentPage = page;
    notifyListeners();
  }
}
