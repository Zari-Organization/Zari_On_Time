import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/offers.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';
import 'package:zari/widgets/build_offer.dart';
import 'package:zari/widgets/custom_search.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage>
    with SingleTickerProviderStateMixin {
  int selectedColor = 0;
  List<Offers>? offers;

  getAllOffers() async {
    await Api.getOffers().then((value) {
      setState(() => offers = value);
    });
  }

  TextEditingController search = TextEditingController();
  _search(String text) {
    if (text.isEmpty) {
      print('search1111');
      //  getCategories();
    } else {
      print('search2222');
      setState(() {
        offers = offers!
            .where((e) =>
                e.title!.toLowerCase().contains(text.toLowerCase()) ||
                e.artitle!.toLowerCase().contains(text.toLowerCase()))
            .toList();
        print('categories!.length${offers!.length}');
      });
    }
  }

  @override
  void initState() {
    getAllOffers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "offers")!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: offers != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    CustomSearch(
                      title: localize(context, "search"),
                      controller: search,
                      search: (v) => _search(v!),
                      prewidget: Image.asset(
                        Images.search_icon,
                        color: Colors.grey,
                        scale: 7,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => _buildListOffer(index),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localize(context, "topoffers")!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              localize(context, "see all")!,
                              style: TextStyle(
                                  color: AppColors.YALLOW_BUTTON,
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.YALLOW_BUTTON,
                              size: Dimensions.FONT_SIZE_DEFAULT,
                            ),
                          ],
                        ),
                        // SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // SizedBox(height: 5),
                            // Container(
                            //   height: 200,
                            //   width: double.infinity,
                            //   child: ListView.builder(
                            //     physics: BouncingScrollPhysics(),
                            //     itemCount: 10,
                            //     scrollDirection: Axis.vertical,
                            //     itemBuilder: (context, index) =>
                            //         BuildTopOffer(),
                            //   ),
                            // ),
                            // SizedBox(height: 5),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       localize(context, "recommendedforyou")!,
                            //       style: TextStyle(
                            //           color: Colors.black,
                            //           fontSize: Dimensions
                            //               .FONT_SIZE_EXTRA_LARGE_TWENTY,
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //     Row(
                            //       children: [
                            //         Text(
                            //           localize(context, "see all")!,
                            //           style: TextStyle(
                            //               color: AppColors.YALLOW_BUTTON,
                            //               fontSize:
                            //                   Dimensions.FONT_SIZE_DEFAULT),
                            //         ),
                            //         Icon(
                            //           Icons.arrow_forward_ios,
                            //           color: AppColors.YALLOW_BUTTON,
                            //           size: Dimensions.FONT_SIZE_DEFAULT,
                            //         ),
                            //       ],
                            //     ),
                            //     // SizedBox(width: 5),
                            //   ],
                            // ),
                            // SizedBox(height: 5),
                            // Container(
                            //   height: 200,
                            //   width: double.infinity,
                            //   child: ListView.builder(
                            //     physics: BouncingScrollPhysics(),
                            //     itemCount: 10,
                            //     scrollDirection: Axis.vertical,
                            //     itemBuilder: (context, index) =>
                            //         BuildRecommendedOffer(),
                            //   ),
                            // ),
                            // SizedBox(height: 5),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       localize(context, "offers up to 60%")!,
                            //       style: TextStyle(
                            //           color: Colors.black,
                            //           fontSize: Dimensions
                            //               .FONT_SIZE_EXTRA_LARGE_TWENTY,
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //     Row(
                            //       children: [
                            //         Text(
                            //           localize(context, "see all")!,
                            //           style: TextStyle(
                            //               color: AppColors.YALLOW_BUTTON,
                            //               fontSize:
                            //                   Dimensions.FONT_SIZE_DEFAULT),
                            //         ),
                            //         Icon(
                            //           Icons.arrow_forward_ios,
                            //           color: AppColors.YALLOW_BUTTON,
                            //           size: Dimensions.FONT_SIZE_DEFAULT,
                            //         ),
                            //       ],
                            //     ),
                            //     // SizedBox(width: 5),
                            //   ],
                            // ),

                            offers!.length > 0
                                ? Container(
                                    height: 600,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: offers!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) =>
                                          BuildUpToOffer(offers![index]),
                                    ),
                                  )
                                : Container(
                                    height: 600,
                                    child: Center(
                                      child: Text(
                                        localize(context, "noDataFound")!,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  _buildListOffer(int index) {
    final langProvider = Provider.of<AppLanguage>(context, listen: false);
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: selectedColor == index
          ? AppColors.YALLOW_BUTTON
          : Colors.grey.shade400,
      elevation: 2,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = index;
          });
        },
        child: Container(
          //  width: 40,
          decoration: BoxDecoration(
            //    color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Allsssss',
                maxLines: 5,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
