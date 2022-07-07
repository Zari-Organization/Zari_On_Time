import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/offers.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';

class BuildTopOffer extends StatelessWidget {
  const BuildTopOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Container(
        height: 95,
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
                child: Container(
                  child: Stack(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: Images.offer_card,
                        //   placeholder: 'assets/images/loading.gif',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.offer_card,
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                        image: Images.offer_card,
                        fit: BoxFit.cover,
                        height: 140,
                      ),
                      // Image.asset(
                      //   Images.offer_card,
                      //   scale: 0.5,
                      // ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.YALLOW_BUTTON,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                            width: 50,
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.discount,
                                  scale: 35,
                                ),
                                Text('35%')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bellandon Beauty Center',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Beauty Salon',
                      maxLines: 5,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Offer Details',
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.YALLOW_BUTTON,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Image.asset(
                          Images.heart_icon,
                          scale: 25,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildRecommendedOffer extends StatelessWidget {
  const BuildRecommendedOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Container(
        height: 95,
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
                child: Container(
                  child: Stack(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: Images.offer_card,
                        //   placeholder: 'assets/images/loading.gif',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.offer_card,
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                        image: Images.offer_card,
                        fit: BoxFit.cover,
                        height: 140,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.YALLOW_BUTTON,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                            width: 50,
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.discount,
                                  scale: 35,
                                ),
                                Text(
                                  '35%',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bellandon Beauty Center',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    //   SizedBox(height: 5),
                    Text(
                      'Beauty Salon',
                      maxLines: 5,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //     SizedBox(height: 7.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Offer Details',
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.YALLOW_BUTTON,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Image.asset(
                          Images.heart_icon,
                          scale: 25,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildUpToOffer extends StatelessWidget {
  Offers? offers;
  BuildUpToOffer(this.offers);

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<AppLanguage>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Container(
        height: 95,
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
                child: Container(
                  child: Stack(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: Images.offer_card,
                        //   placeholder: 'assets/images/loading.gif',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.offer_card,
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                        image: Images.offer_card,
                        fit: BoxFit.cover,
                        height: 140,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.YALLOW_BUTTON,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                            width: 50,
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.discount,
                                  scale: 35,
                                ),
                                Text(
                                  '35%',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      langProvider.appLanguage == "en"
                          ? '${offers!.title}'
                          : '${offers!.artitle}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    //  SizedBox(height: 5),
                    Text(
                      langProvider.appLanguage == "en"
                          ? '${offers!.catName}'
                          : '${offers!.catArname}',
                      maxLines: 5,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //   SizedBox(height: 7.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Offer Details',
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.YALLOW_BUTTON,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Image.asset(
                          Images.heart_icon,
                          scale: 25,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
