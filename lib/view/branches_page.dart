import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/branch.dart';
import 'package:zari/model/core/brand.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/services_page.dart';
import 'package:zari/widgets/custom_field.dart';
import 'package:zari/widgets/custom_search.dart';

import '../constants.dart';
import 'menu_page.dart';

class BranchesPage extends StatefulWidget {
  String? name;
  BranchesPage(this.name);

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  TextEditingController search = TextEditingController();

  List<Branch>? branches;

  getBranches() async {
    await Api.getBranches(selectedBrand!.id, name: search.text).then((value) {
      print('selectedBrand :${selectedBrand!.id}');
      setState(() => branches = value);
    });
  }

  _search(String text) {
    if (text.isEmpty) {
      getBranches();
    } else {
      setState(() {
        branches = branches!
            .where((e) => e.name!.toLowerCase().contains(text.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    getBranches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "${widget.name}",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    //   color: AppColors.GRAY_APPBAR,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomSearch(
                        title: localize(context, "searchForBranch"),
                        controller: search,
                        search: (v) => _search(v!),
                        prewidget: Image.asset(
                          Images.search_icon,
                          color: Colors.grey,
                          scale: 7,
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 10),
                // MaterialButton(
                //   height: 50,
                //   minWidth: 50,
                //   color: yellowColor,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   onPressed: () {
                //     if (search.text.isNotEmpty) {
                //       getBranches();
                //     }
                //   },
                //   child: Icon(Icons.search, color: Colors.white),
                // ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "${widget.name}" + '  ' + localize(context, "branches")! + ' :',
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: branches != null
                  ? branches!.isNotEmpty
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: branches!.length,
                          itemBuilder: (_, index) =>
                              _buildBranch(branches![index]),
                        )
                      : Center(child: Text(localize(context, "noDataFound")!))
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  _buildBranch(Branch branch) {
    print('branch id is : ${branch.id}');
    print('branch name is : ${branch.name}');
    //    print('branch image is : ${branch.image}');
    print('branch image is : ${branch.desc}');
    final langProvider = Provider.of<AppLanguage>(context, listen: false);
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ServicesPage()),
          );
          pagesProvider.setPage("services");
          selectedBranch = branch;
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //    SizedBox(width: 5),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    langProvider.appLanguage == "en"
                        ? branch.name!
                        : branch.arname!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
                //   SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
