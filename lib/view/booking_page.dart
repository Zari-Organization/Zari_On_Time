import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/history.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/home_page.dart';
import 'package:zari/view/main_page.dart';
import 'package:zari/widgets/custom_button.dart';

class BookingPage extends StatefulWidget {
  BookingPage();

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  History? history;
  String remainingTime = "";
  String date1 = '';

  Future getBookDetails() async {
    await Api.getHistory(currentBookID).then((value) {
      setState(() => history = value);
      print(history!.id);
      // print("clientName :${history!.clientName}");
      // print('history!.date :${history!.date}');
    });
  }

  static String _date(String date) {
    DateTime tempDate = DateFormat("yyyy/MM/dd HH:mm").parse(date);
    // DateFormat..add_jms().format(tempDate);
    String date1 = DateFormat("d MMM y HH:mm").add_jms().format(tempDate);
    return date1;
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  calculateTimeRemaining() {
    DateTime firstDate = DateFormat("yyyy/MM/dd HH:mm").parse(history!.date!);
    DateTime secondDate =
        DateFormat("yyyy/MM/dd HH:mm").parse(history!.estDate!);

    int differenceInMinutes = secondDate.difference(firstDate).inMinutes;
    int hours = differenceInMinutes ~/ 60;
    int minutes = differenceInMinutes % 60;

    setState(() {
      remainingTime =
          (hours != 0 ? "$hours ${localize(context, "hours")}" : "") +
              (minutes != 0 ? "$minutes ${localize(context, "minutes")}" : "");
    });
  }

  @override
  void initState() {
    getBookDetails().then((value) {
      calculateTimeRemaining();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pagesProvider = Provider.of<PagesProvider>(context);
    final langProvider = Provider.of<AppLanguage>(context);
    return Scaffold(
      // backgroundColor: blueColor,
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
          localize(context, "ticket")!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: history != null
          ? Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Card(
                        color: AppColors.GRAY_APPBAR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            /*Image.network(
                              history!.logo!,
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),*/

                            // Ticket
                            //   SizedBox(height: 20),
                            //  Center(
                            //                                       child: Text(
                            //                                         localize(context, "yourTicketNo")!,
                            //                                         style: TextStyle(
                            //                                             fontSize: 25,
                            //                                             color: Colors.white),
                            //                                       ),
                            //                                     ),
                            Center(
                              child: Text(
                                history!.clientName!.isEmpty
                                    ? 'Marwa'
                                    : "${history!.clientName}",
                                //  "${history!.clientName}",
                                //     history!.number.toString(),
                                style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_MAX_LARGE,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // details
                            Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            localize(context, "brandName")!,
                                            style: TextStyle(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            langProvider.appLanguage == "en"
                                                ? history!.name!
                                                : history!.arname!,
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            localize(context, "branchName")!,
                                            style: TextStyle(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            history!.bName!.isNotEmpty ||
                                                    history!.bName!.isNotEmpty
                                                ? langProvider.appLanguage ==
                                                        "en"
                                                    ? history!.bName!
                                                    : history!.bArname!
                                                : 'Samer',
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),

                            ///first Row
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            localize(context, "serviceName")!,
                                            style: TextStyle(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            langProvider.appLanguage == "en"
                                                ? history!.serName!
                                                : history!.serArname!,
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2),
                                      child: history!.status == 0
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  localize(context,
                                                      "waitingcustomer")!,
                                                  style: TextStyle(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_DEFAULT,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  history!.waitingCust
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    )),
                              ],
                            ),

                            ///Second Row
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            localize(context, "bookDate")!,
                                            style: TextStyle(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _date(history!.date ?? '')
                                                .substring(0, 11),
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              localize(context, "bookTime")!,
                                              style: TextStyle(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              _date(history!.date ?? '')
                                                  .substring(18, 29),
                                              style: TextStyle(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ))),
                              ],
                            ),

                            /// Third Row
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 7),
                                      child: history!.status == 0
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 15),
                                                Text(
                                                  localize(context,
                                                      "remainingTime")!,
                                                  style: TextStyle(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_DEFAULT,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  remainingTime,
                                                  style: TextStyle(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2),
                                      child: history!.status == 0
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   localize(context,
                                                //       "waitingcustomer")!,
                                                //   style: TextStyle(
                                                //     fontSize: Dimensions
                                                //         .FONT_SIZE_DEFAULT,
                                                //     color: Colors.grey,
                                                //     fontWeight: FontWeight.w400,
                                                //   ),
                                                // ),
                                                // SizedBox(height: 5),
                                                // Text(
                                                //   history!.waitingCust
                                                //       .toString(),
                                                //   style: TextStyle(
                                                //       fontSize: Dimensions
                                                //           .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                //       color: Colors.black),
                                                // ),
                                              ],
                                            )
                                          : Container(),
                                    )),
                              ],
                            ),

                            /// Forth Row
                            SizedBox(height: 25),
                            DottedLine(
                              direction: Axis.horizontal,
                              lineLength: double.infinity,
                              lineThickness: 1.0,
                              dashLength: 4.0,
                              dashColor: Colors.grey,
                              //    dashGradient: [Colors.red, Colors.blue],
                              dashRadius: 0.0,
                              dashGapLength: 4.0,
                              dashGapColor: Colors.transparent,
                              // dashGapGradient: [Colors.red, Colors.blue],
                              dashGapRadius: 0.0,
                            ),
                            SizedBox(height: 15),
                            Center(
                              child: Text(
                                localize(context, "yourTicketNo")!,
                                style: TextStyle(
                                  fontSize:
                                      Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Center(
                              child: Text(
                                '${history!.number}',
                                style: TextStyle(
                                  fontSize:
                                      Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  history!.status == 0
                      ? Column(
                          children: [
                            CustomButton(
                              title: localize(context, "showonmap"),
                              onClick: () => openMapsSheet(
                                context,
                                history!.lat,
                                history!.long,
                              ),
                              colors: 0,
                              colorText: 1,
                            ),
                            SizedBox(height: 10),
                            CustomButton(
                              title: localize(context, "backToHome"),
                              onClick: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MainPage()));
                              },
                              colorText: 0,
                            ),
                          ],
                        )
                      : CustomButton(
                          title: localize(context, "back"),
                          onClick: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MainPage()));
                          },
                          colorText: 0,
                        ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  openMapsSheet(context, lat, lng) async {
    print('lat: ${lat}');
    print('lng: ${lng}');
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
