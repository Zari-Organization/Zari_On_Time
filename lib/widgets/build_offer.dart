import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        height: 90,
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
                      Image.asset(
                        Images.offer_card,
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
                    SizedBox(height: 5),
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
                    SizedBox(height: 7.5),
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
        height: 90,
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
                      Image.asset(
                        Images.offer_card,
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
                    SizedBox(height: 5),
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
                    SizedBox(height: 7.5),
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
  const BuildUpToOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Container(
        height: 90,
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
                      Image.asset(
                        Images.offer_card,
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
                    SizedBox(height: 5),
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
                    SizedBox(height: 7.5),
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