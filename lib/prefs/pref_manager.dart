import '../model/core/user.dart';
import 'pref_utils.dart';
import 'pref_keys.dart';
import 'dart:convert';

class PrefManager {
  static User? currentUser;

  static Future init() async {
    /// USER
    String userData = await getCurrentUser();
    if (userData.isNotEmpty) {
      Map<String, dynamic> user = jsonDecode(await getCurrentUser());
      currentUser = User.fromJson(user);
      print(currentUser!.toJson());
    }
  }

  /// SETTERS

  static Future setCurrentUser(User? user) async {
    currentUser = user;
    if (user != null) {
      String storedUser = jsonEncode(user.toJson());
      await PrefUtils.setString(PrefKeys.currentUser, storedUser);
    } else {
      await PrefUtils.setString(PrefKeys.currentUser, "");
    }
  }

  /// GETTERS
  static Future<String> getCurrentUser() async {
    return await PrefUtils.getString(PrefKeys.currentUser);
  }
}
