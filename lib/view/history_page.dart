import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/history.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/booking_page.dart';
import 'package:zari/view/login_page.dart';
import 'package:zari/view/service_details_page.dart';
import 'package:zari/widgets/custom_field.dart';
import 'package:zari/widgets/need_login_widget.dart';

import '../constants.dart';
import 'menu_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  TextEditingController search = TextEditingController();

  List<History>? histories;

  getHistory() async {
    if (PrefManager.currentUser != null) {
      await Api.getHistories(PrefManager.currentUser!.custId).then((value) {
        setState(() => histories = value);
      });
    } else {
      histories = [];
    }
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "history")!,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: PrefManager.currentUser != null
          ? histories != null
              ? histories!.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: histories!.length,
                              itemBuilder: (_, index) =>
                                  _buildHistory(histories![index]),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                      children: [
                        SizedBox(height: 25),
                        SvgPicture.asset(
                          Images.calender,
                          height: 300,
                          width: 300,
                        ),
                        Text(
                          localize(context, "you don't have any reservation")!,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY),
                        ),
                      ],
                    ))
              : Center(child: CircularProgressIndicator())
          : NeedLoginWidget(),
    );
  }

  _buildHistory(History history) {
    final langProvider = Provider.of<AppLanguage>(context, listen: false);
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          currentBookID = history.id;
          selectedHistory = history;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookingPage()),
          );
          //pagesProvider.setPage("book");
        },
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            //  color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
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
                    image: '${history.logo!}',
                    fit: BoxFit.cover,
                    height: 140,
                  ),
                  // child: Image.network(
                  //   history.logo!,
                  //   height: 100,
                  //   width: 100,
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        langProvider.appLanguage == "en"
                            ? history.name!
                            : history.arname!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              langProvider.appLanguage == "en"
                                  ? history.bArname ?? ""
                                  : history.arname ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Details',
                        style: TextStyle(
                          color: yellowColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(height: 10),
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
