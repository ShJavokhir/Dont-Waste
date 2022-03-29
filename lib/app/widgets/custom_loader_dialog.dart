import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';


class CustomLoaderDialog extends StatelessWidget {
  const CustomLoaderDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(BORDER_RADIUS_1 * 1.0))),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          // var height = MediaQuery.of(context).size.height;
          // var width = MediaQuery.of(context).size.width;

          return Container(
            //padding: EdgeInsets.all(50),
            //width: 85.w,
            child: Container(
                padding: EdgeInsets.all(15),
                //width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: black4,
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        color: yellow1,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'loading'.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
