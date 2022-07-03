import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/service.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/booking_page.dart';
import 'package:zari/view/login_page.dart';
import 'package:zari/widgets/custom_button.dart';

class ServiceDetailsPage extends StatefulWidget {
  ServiceDetailsPage();

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<AppLanguage>(context);
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
          localize(context, "confirmation")!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: LoadingOverlay(
        isLoading: loading,
        opacity: 0.3,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.YALLOW_BUTTON,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      height: 225,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/place-holder.png',
                          imageErrorBuilder: (c, o, s) => Image.asset(
                            'assets/images/place-holder.png',
                            fit: BoxFit.cover,
                          ),
                          image: '${selectedService!.image!}',
                          fit: BoxFit.cover,
                          height: 140,
                          width: 140,
                        ),
                      )),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      selectedService!.desc! == null
                          ? 'Samer'
                          : langProvider.appLanguage == "en"
                              ? selectedService!.name!
                              : selectedService!.arname!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      langProvider.appLanguage == "en"
                          ? selectedService!.desc!
                          : selectedService!.ardesc!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: CustomButton(
                title: localize(context, "book"),
                onClick: bookService,
                colors: 0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: CustomButton(
                title: localize(context, "showonmap"),
                onClick: () => openMapsSheet(
                  context,
                  selectedBranch!.lat,
                  selectedBranch!.long,
                ),
                colorText: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bookService() async {
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    if (PrefManager.currentUser == null) {
      /*AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        title: localize(context, "error")!,
        desc: localize(context, "needLogin")!,
        // body: Text(localize(context, "needLogin")!),
        btnOk: MaterialButton(
          color: yellowColor,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
              (r) => false,
            );
          },
          child: Text(
            localize(context, "ok")!,
            style: TextStyle(color: Colors.white),
          ),
        ),
        btnCancel: MaterialButton(
          color: Colors.redAccent,
          onPressed: () => Navigator.pop(context),
          child: Text(
            localize(context, "cancel")!,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ).show();*/
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
        (r) => false,
      );
      return;
    }

    DateTime now = DateTime.now();

    String dateTime = DateFormat("yyyy-MM-dd HH:mm").format(now);

    String params = "custid=${PrefManager.currentUser!.custId}"
        "&brandid=${selectedBrand!.id}"
        "&branchid=${selectedBranch!.id}"
        "&branchid=${selectedBranch!.id}"
        "&date=$dateTime";

    print("&brandid=${selectedBrand!.id}");
    print("&branchid=${selectedBranch!.id}");
    print("&branchid=${selectedBranch!.id}");
    print("&date=$dateTime");
    setState(() => loading = true);
    await Api.bookService(params).then((value) {
      print(value);
      setState(() => loading = false);
      if (value['status'] == true) {
        Fluttertoast.showToast(msg: localize(context, "booked")!);
        setState(() {
          currentBookID = value['book_id'];
        });
        //   pagesProvider.setPage("book");
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => BookingPage()),
        );
      }
    });
  }

  openMapsSheet(context, lat, lng) async {
    try {
      final coords = Coords(lat, lng);
      final title = "";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
