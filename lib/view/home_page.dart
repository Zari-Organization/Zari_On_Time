import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';

import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/category.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/brands_page.dart';
import 'package:zari/view/menu_page.dart';
import 'package:zari/view/welcome_page.dart';
import 'package:zari/widgets/custom_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();

  List<Category>? categories;

  getCategories() async {
    await Api.getCategories(name: search.text).then((value) {
      if (mounted) setState(() => categories = value);
    });
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          localize(context, "home")!,
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
            Text(
              localize(context, "categories")!,
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: categories != null
                  ? categories!.isNotEmpty
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: categories!.length,
                          itemBuilder: (context, index) =>
                              _buildCategory(categories![index]),
                        )
                      : Center(
                          child: Text(
                          localize(context, "noDataFound")!,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ))
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  _buildCategory(Category category) {
    final langProvider = Provider.of<AppLanguage>(context, listen: false);
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          pagesProvider.setPage("brands");
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => BrandsPage(langProvider.appLanguage == "en"
                    ? category.name
                    : category.arname)),
          );

          selectedCategory = category;
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
