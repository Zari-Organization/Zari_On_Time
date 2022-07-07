import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/to_night.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/filter_page.dart';
import 'package:zari/widgets/build_have_fun.dart';
import 'package:zari/widgets/build_offer.dart';
import 'package:zari/widgets/build_where_do_go.dart';
import 'package:zari/widgets/custom_search.dart';

enum menuitem { item1, item2, item3, item4 }

class WhereDoIGoPage extends StatefulWidget {
  const WhereDoIGoPage({Key? key}) : super(key: key);

  @override
  State<WhereDoIGoPage> createState() => _WhereDoIGoPageState();
}

class _WhereDoIGoPageState extends State<WhereDoIGoPage>
    with SingleTickerProviderStateMixin {
  int selectedColor = 0;
  List<ToNight>? tonighs;
  getAllToNight() async {
    await Api.getToNight().then((value) {
      setState(() => tonighs = value);
    });
  }

  menuitem? _mitem = menuitem.item1;
  String _groupValue = '';

  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  TextEditingController search = TextEditingController();
  _search(String text) {
    if (text.isEmpty) {
      print('search1111');
      getAllToNight();
    } else {
      setState(() {
        tonighs = tonighs!
            .where((e) =>
                e.title!.toLowerCase().contains(text.toLowerCase()) ||
                e.artitle!.toLowerCase().contains(text.toLowerCase()))
            .toList();

        print('categories!.length${tonighs!.length}');
      });
    }
  }

  @override
  void initState() {
    getAllToNight();
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
          localize(context, "wheredo")!,
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
      body: tonighs != null
          ? Padding(
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => FilterPage()),
                                );
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
                              onTap: () => showAlertDialog(context),
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
                      ],
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
                    Expanded(
                      //height: 200,
                      //   width: double.infinity,
                      child: tonighs!.length > 0
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: tonighs!.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) =>
                                  WhereDoIGo(tonighs![index]),
                            )
                          : Center(
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

  showAlertDialog(BuildContext context) {
    // set up the buttons

    // show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.grey[100],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    minVerticalPadding: 0,
                    subtitle: Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Text(' Sort by',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    title: Text('Most Bokked',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                    trailing: Radio<menuitem>(
                      activeColor: AppColors.YALLOW_BUTTON,
                      value: menuitem.item1,
                      groupValue: _mitem,
                      onChanged: (menuitem? value) {
                        setState(() {
                          _mitem = value;
                        });
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: const Text('Top rated',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                    trailing: Radio<menuitem>(
                      value: menuitem.item2,
                      activeColor: AppColors.YALLOW_BUTTON,
                      groupValue: _mitem,
                      onChanged: (menuitem? value) {
                        setState(() {
                          _mitem = value;
                        });
                      },
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: const Text('Nearby',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                    trailing: Radio<menuitem>(
                      activeColor: AppColors.YALLOW_BUTTON,
                      value: menuitem.item3,
                      groupValue: _mitem,
                      onChanged: (menuitem? value) {
                        setState(() {
                          _mitem = value;
                        });
                      },
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: const Text('item4'),
                    trailing: Radio<menuitem>(
                      activeColor: AppColors.YALLOW_BUTTON,
                      value: menuitem.item4,
                      groupValue: _mitem,
                      onChanged: (menuitem? value) {
                        setState(() {
                          _mitem = value;
                        });
                      },
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: 160,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: AppColors.YALLOW_BUTTON,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: const Center(
                            child: Text('APPLY',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          )),
                    ),
                  ),
                ],
              ),
            ));
  }
}
