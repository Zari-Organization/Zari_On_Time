import 'package:flutter/material.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/branch.dart';
import 'package:zari/model/core/service.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/booking_page.dart';
import 'package:zari/view/history_page.dart';
import 'package:zari/view/service_details_page.dart';
import 'package:zari/widgets/custom_field.dart';

import '../constants.dart';
import 'menu_page.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage();

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  TextEditingController search = TextEditingController();

  List<Service>? services;

  getServices() async {
    await Api.getServices(selectedBranch!.id).then((value) {
      print('selectedBrand :${selectedBranch!.id}');
      setState(() => services = value);
      print('service:   ${services!.length}');
    });
  }

  _search(String text) {
    if (text.isEmpty) {
      getServices();
    } else {
      setState(() {
        services = services!
            .where((e) => e.name!.toLowerCase().contains(text.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    getServices();
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
          localize(context, "services")!,
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
            SizedBox(height: 25),
            Expanded(
              child: services != null
                  ? services!.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  childAspectRatio: 2.5 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: services!.length,
                          itemBuilder: (BuildContext ctx, index) =>
                              _buildService(services![index]))

                      // ? ListView.builder(
                      //     physics: BouncingScrollPhysics(),
                      //     itemCount: services!.length,
                      //     itemBuilder: (_, index) =>
                      //         _buildService(services![index]),
                      //   )
                      : Center(child: Text(localize(context, "noDataFound")!))
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  _buildService(Service service) {
    final langProvider = Provider.of<AppLanguage>(context, listen: false);
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          print('service image:   ${service.image}');
          print('service id:   ${service.id}');
          print('service name:   ${service.name}');
          print('service desc:   ${service.desc}');

          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ServiceDetailsPage()),
          );
          //   pagesProvider.setPage("historyDetails");
          selectedService = service;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.YALLOW_BUTTON,
                    // border: Border.all(color: yellowColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/place-holder.png',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          'assets/images/place-holder.png',
                          fit: BoxFit.cover,
                        ),
                        image: '${service.image!}',
                        fit: BoxFit.cover,
                        // height: 140,
                        //  width: 140,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      langProvider.appLanguage == "en"
                          ? service.name!
                          : service.arname!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
