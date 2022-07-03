import 'package:dio/dio.dart';
import 'package:zari/model/core/branch.dart';
import 'package:zari/model/core/brand.dart';
import 'package:zari/model/core/category.dart';
import 'package:zari/model/core/city.dart';
import 'package:zari/model/core/country.dart';
import 'package:zari/model/core/history.dart';
import 'package:zari/model/core/region.dart';
import 'package:zari/model/core/service.dart';

class Api {
  static const String baseUrl = "http://162.0.222.73:7001/zariontime/services?";

  static Future<List<Country>?> getCountries() async {
    String endPoint = baseUrl + "action=countries";

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      List data = response.data;
      List<Country> countries = data.map((e) => Country.fromJson(e)).toList();
      return countries;
    } else {
      return null;
    }
  }

  static Future<List<City>?> getCities(countryID) async {
    String endPoint = baseUrl + "action=cities&countryid=$countryID";

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      List data = response.data;
      List<City> cities = data.map((e) => City.fromJson(e)).toList();
      return cities;
    } else {
      return null;
    }
  }

  static Future<List<Region>?> getRegions(cityID) async {
    String endPoint = baseUrl + "action=regions&cityid=$cityID";

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      List data = response.data;
      List<Region> regions = data.map((e) => Region.fromJson(e)).toList();
      return regions;
    } else {
      return null;
    }
  }

  static Future register(String params) async {
    String url = baseUrl + "action=register&$params";

    Response response = await Dio().post(url);
    return response;
  }

  static Future login(String params) async {
    String url = baseUrl + "action=login&$params";

    Response response = await Dio().post(url);
    return response.data;
  }

  static Future<List<Category>?> getCategories({name}) async {
    String endPoint = baseUrl + "action=categories&name=$name";
    print(endPoint);

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      List data = response.data;
      List<Category> categories =
          data.map((e) => Category.fromJson(e)).toList();
      return categories;
    } else {
      return null;
    }
  }

  static Future<List<Brand>?> getBrands(catID, {name}) async {
    String endPoint = baseUrl + "action=brands&catid=$catID&name=$name";

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      List data = response.data;
      List<Brand> brands = data.map((e) => Brand.fromJson(e)).toList();
      return brands;
    } else {
      return null;
    }
  }

  static Future<List<Branch>?> getBranches(brandID, {name}) async {
    String endPoint = baseUrl + "action=branches&brandid=$brandID&name=$name";

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      List data = response.data;
      List<Branch> branches = data.map((e) => Branch.fromJson(e)).toList();
      return branches;
    } else {
      return null;
    }
  }

  static Future<List<Service>?> getServices(branchID) async {
    String endPoint = baseUrl + "action=services&branchid=$branchID";

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      List data = response.data;
      List<Service> services = data.map((e) => Service.fromJson(e)).toList();
      return services;
    } else {
      return null;
    }
  }

  static Future bookService(String params) async {
    String endPoint = baseUrl + "action=book&$params";
    print(endPoint);
    Response response = await Dio().post(endPoint);
    return response.data;
  }

  static Future<List<History>?> getHistories(custID) async {
    String endPoint = baseUrl + "action=history&custid=$custID";

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      List data = response.data;
      List<History> services = data.map((e) => History.fromJson(e)).toList();
      return services;
    } else {
      return null;
    }
  }

  static Future<History?> getHistory(bookID) async {
    String endPoint = baseUrl + "action=history_details&bookid=$bookID";
    print(endPoint);

    Response response = await Dio().get(endPoint);
    if (response.statusCode == 200) {
      var data = response.data;
      History service = History.fromJson(data);
      return service;
    } else {
      return null;
    }
  }

  static Future getAbout() async {
    String endPoint = baseUrl + "action=about";

    Response response = await Dio().get(endPoint);
    return response.data;
  }

  static Future getContact() async {
    String endPoint = baseUrl + "action=contact";
    print('endPoint: $endPoint');
    Response response = await Dio().get(endPoint);
    print('endPoint: ${response.data}');
    return response.data;
  }

  static Future join(String params) async {
    String url = baseUrl + "action=join&$params";

    Response response = await Dio().post(url);
    return response.data;
  }

  static Future contactUs(String params) async {
    String url = baseUrl + "action=contact&$params";

    Response response = await Dio().post(url);
    return response.data;
  }

  static Future updateProfile(String params) async {
    String url = baseUrl + "action=update_profile&$params";

    Response response = await Dio().post(url);
    return response;
  }

  static Future forgetPassword(String params) async {
    String url = baseUrl + "action=rest_pass&$params";

    Response response = await Dio().post(url);
    return response.data;
  }

  static Future checkOtp(String params) async {
    String url = baseUrl + "action=check_otp&$params";

    Response response = await Dio().post(url);
    return response.data;
  }
}
