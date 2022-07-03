import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';

import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/model/core/category.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/brands_page.dart';
import 'package:zari/view/menu_page.dart';
import 'package:zari/widgets/custom_field.dart';
import 'package:zari/widgets/custom_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();

  List<Category>? categories;
  List<Category> searchResult = [];

  getCategories() async {
    await Api.getCategories(name: search.text).then((value) {
      if (mounted) setState(() => categories = value);
    });
  }

  _search(String text) {
    if (text.isEmpty) {
      getCategories();
    } else {
      setState(() {
        searchResult = categories!
            .where((e) => e.name!.toLowerCase().contains(text.toLowerCase()))
            .toList();
        print('categories!.length${searchResult.length}');
        // searchResult!.forEach((element) {
        //   if (element.name != search.text) {
        //     return print('object222');
        //   }
        // });
      });
    }
  }

  @override
  void initState() {
    getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "search")!,
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
            Row(
              children: [
                Expanded(
                  child: CustomSearch(
                    title: localize(context, "search"),
                    controller: search,
                    search: (v) => _search(v!),
                    prewidget: Image.asset(
                      Images.search_icon,
                      color: Colors.grey,
                      scale: 7,
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
                //       _search(search.text);
                //       //  getCategories();
                //     }
                //     if (search.text.isEmpty) {
                //       //    _search(search.text);
                //       getCategories();
                //     }
                //   },
                //   child: Icon(Icons.search, color: Colors.white),
                // ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: search.text.isNotEmpty
                  ? categories != null
                      ? searchResult.length > 0
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: searchResult.length,
                              itemBuilder: (context, index) =>
                                  _buildCategory(searchResult[index]),
                            )
                          : Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 25),
                                  SvgPicture.asset(
                                    Images.result_search,
                                    height: 300,
                                    width: 300,
                                  ),
                                  Text(
                                    localize(context, "noDataFound")!,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                      : Center(child: CircularProgressIndicator())
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        localize(context, "searchForyourCategory")!,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCategory(Category category) {
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => BrandsPage(category.name)),
          );
          //  pagesProvider.setPage("brands");
          selectedCategory = category;
        },
        child: Container(
          //    margin: EdgeInsets.only(bottom: 15),
          height: 140,
          decoration: BoxDecoration(
            //    color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/place-holder.png',
                    //   placeholder: 'assets/images/loading.gif',
                    imageErrorBuilder: (c, o, s) => Image.asset(
                      'assets/images/place-holder.png',
                      fit: BoxFit.cover,
                    ),
                    image: '${category.image!}',
                    fit: BoxFit.cover,
                    height: 140,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name ?? "",
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
                              category.desc ?? "",
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
