import 'package:flutter/material.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/brand.dart';
import 'package:zari/model/core/category.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/branches_page.dart';
import 'package:zari/widgets/custom_field.dart';

import '../constants.dart';
import 'menu_page.dart';

class BrandsPage extends StatefulWidget {
  String? name;
  BrandsPage(this.name);

  @override
  State<BrandsPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  TextEditingController search = TextEditingController();

  List<Brand>? brands;

  getBrands() async {
    await Api.getBrands(selectedCategory!.id, name: search.text).then((value) {
      setState(() => brands = value);
    });
  }

  @override
  void initState() {
    getBrands();
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
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            //   Text('${widget.name}',
            //  //   localize(context, "brands")!,
            //     style: TextStyle(
            //       fontSize: Dimensions.FONT_SIZE_LARGE,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            // SizedBox(height: 10),
            // Row(
            //   children: [
            //     Expanded(
            //       child: CustomField(
            //         title: localize(context, "searchForBrand"),
            //         controller: search,
            //       ),
            //     ),
            //     SizedBox(width: 10),
            //     MaterialButton(
            //       height: 50,
            //       minWidth: 50,
            //       color: yellowColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       onPressed: () {
            //         if (search.text.isNotEmpty) {
            //           getBrands();
            //         }
            //       },
            //       child: Icon(Icons.search, color: Colors.white),
            //     ),
            //   ],
            // ),
            SizedBox(height: 10),
            Expanded(
              child: brands != null
                  ? brands!.isNotEmpty
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: brands!.length,
                          itemBuilder: (_, index) =>
                              _buildBrand(brands![index]),
                        )
                      : Center(
                          child: Text(localize(context, "noDataFound")!),
                        )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  _buildBrand(Brand brand) {
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
            MaterialPageRoute(
                builder: (_) => BranchesPage(langProvider.appLanguage == "en"
                    ? brand.name
                    : brand.arname)),
          );
          //  pagesProvider.setPage("branches");
          selectedBrand = brand;
          //  print(brand.);
        },
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            //    color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/place-holder.png',
                    imageErrorBuilder: (c, o, s) => Image.asset(
                      'assets/images/place-holder.png',
                      fit: BoxFit.cover,
                    ),
                    image: '${brand.image!}',
                    fit: BoxFit.cover,
                    height: 140,
                  ),

                  // Image.network(
                  //   brand.image!,
                  //   height: 160,
                  //   width: MediaQuery.of(context).size.width,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        langProvider.appLanguage == "en"
                            ? brand.name ?? ""
                            : brand.arname ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              langProvider.appLanguage == "en"
                                  ? brand.desc ?? ""
                                  : brand.ardesc ?? "",
                              maxLines: 5,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
