import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';
import 'package:zari/widgets/build_have_fun.dart';
import 'package:zari/widgets/build_offer.dart';
import 'package:zari/widgets/custom_search.dart';

class HaveFunPage extends StatefulWidget {
  const HaveFunPage({Key? key}) : super(key: key);

  @override
  State<HaveFunPage> createState() => _HaveFunPageState();
}

class _HaveFunPageState extends State<HaveFunPage>
    with SingleTickerProviderStateMixin {
  TextEditingController search = TextEditingController();
  _search(String text) {
    if (text.isEmpty) {
      print('search1111');
      //  getCategories();
    } else {
      print('search2222');
      // setState(() {
      //   searchResult = categories!
      //       .where((e) => e.name!.toLowerCase().contains(text.toLowerCase()))
      //       .toList();
      //   print('categories!.length${searchResult.length}');

      // });
    }
  }

  @override
  void initState() {
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
          localize(context, "havefun")!,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 5,
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
                  SizedBox(width: 2.5),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          print('filter');
                        },
                        child: Card(
                          color: Colors.grey.shade300,
                          margin: EdgeInsets.all(1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Image.asset(
                            Images.filter_icon,
                            scale: 25,
                          ),
                        ),
                      )),
                  SizedBox(width: 2.5),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          print('swap');
                        },
                        child: Card(
                          color: Colors.grey.shade300,
                          margin: EdgeInsets.all(1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Image.asset(
                            Images.Swap_icon,
                            scale: 25,
                          ),
                        ),
                      )),
                  // Expanded(
                  //     flex: 1,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 3),
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           // Navigator.push(
                  //           //   context,
                  //           //   MaterialPageRoute(
                  //           //       builder: (_) => SummeryScreen()),
                  //           // );
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //             fixedSize: Size(
                  //               20,
                  //               45,
                  //             ),
                  //             primary: Colors.grey.shade300,
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(5))),
                  //         child: Image.asset(
                  //           Images.Swap_icon,
                  //           scale: 0.5,
                  //         ),
                  //       ),
                  //       // child: Container(
                  //       //   color: Colors.amber,
                  //       //   child: Image.asset(Images.Swap_icon),
                  //       // ),
                  //     )),
                ],
              ),
              SizedBox(height: 5),
              Container(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _buildListOffer(),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    '100',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    localize(context, "resultavailable")!,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Expanded(
                //height: 200,
                //   width: double.infinity,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => BuildHaveFun(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildListOffer() {
    final langProvider = Provider.of<AppLanguage>(context, listen: false);
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.YALLOW_BUTTON,
      elevation: 2,
      child: GestureDetector(
        onTap: () {},
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
