import 'package:flutter/material.dart';
import 'package:zari/localization/app_localization.dart';
import 'package:zari/model/core/branch.dart';
import 'package:zari/model/core/brand.dart';
import 'package:zari/model/core/category.dart';
import 'package:zari/model/core/history.dart';
import 'package:zari/model/core/offers.dart';
import 'package:zari/model/core/service.dart';
import 'package:zari/util/style.dart';

String? localize(context, key) {
  return AppLocalizations.of(context)!.translate(key);
}

pushToPage(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

Category? selectedCategory;
Brand? selectedBrand;
Branch? selectedBranch;
Service? selectedService;
History? selectedHistory;
Offers? selectedOffers;
int? currentBookID;

reset() {
  selectedCategory = null;
  selectedBrand = null;
  selectedBranch = null;
  selectedService = null;
  selectedHistory = null;
  currentBookID = null;
}
