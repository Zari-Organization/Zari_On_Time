import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:zari/constants.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage>
    with SingleTickerProviderStateMixin {
  double _value = 20;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localize(context, "filter")!,
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
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListTile(
                leading: Text(
                  'Category',
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY,
                      color: Colors.black),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
                leading: Text(
                  'City',
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY,
                      color: Colors.black),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
                leading: Text(
                  'Region',
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY,
                      color: Colors.black),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Distance',
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY,
                      color: Colors.black),
                ),
                Container(
                  child: Row(
                    children: [
                      Text('From'),
                      SizedBox(width: 2.5),
                      Container(
                        width: 75,
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black)),
                        child: TextFormField(
                          cursorColor: AppColors.YALLOW_BUTTON,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text('To'),
                      SizedBox(width: 2.5),
                      Container(
                        width: 75,
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black)),
                        child: TextFormField(
                          cursorColor: AppColors.YALLOW_BUTTON,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Slider(
              min: 0.0,
              max: 50.0,
              divisions: 10,
              label: '$_value',
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
