import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomComfirmationDialog extends StatelessWidget {
  final String text;
  final void Function()? onConfirm;
  final void Function()? onCancel;

  CustomComfirmationDialog({required this.text, this.onConfirm, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          "Alert",
          style: TextStyle(fontSize: 18.sp),
          textAlign: TextAlign.center,
        ),
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.all(15),
        actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(BORDER_RADIUS_1 * 1.0))),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return Container(
              //padding: EdgeInsets.all(50),
              //height: 50.h,
              width: 85.w,
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                //height: 100,
                decoration: BoxDecoration(
                  color: black4,
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            );
          },
        ),
        actions: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  child: Container(
                      padding: EdgeInsets.all(15),
                      //width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "Yes",
                        style:
                            TextStyle(color: Colors.black87, fontSize: 15.sp),
                      )),
                  style: ElevatedButton.styleFrom(
                    //padding: EdgeInsets.all(20),

                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                    ),
                    shadowColor: Colors.transparent,
                    //side: BorderSide(width: 1, color: Colors.green),
                    primary: green2, // <-- Button color
                    onPrimary: Colors.white, // <-- Splash color
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: onCancel,
                  child: Container(
                      padding: EdgeInsets.all(15),
                      //width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "No",
                        style:
                            TextStyle(color: Colors.black87, fontSize: 15.sp),
                      )),
                  style: ElevatedButton.styleFrom(
                    //padding: EdgeInsets.all(20),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                    ),
                    shadowColor: Colors.transparent,
                    //side: BorderSide(width: 1, color: Colors.green),
                    primary: red2, // <-- Button color
                    onPrimary: Colors.white, // <-- Splash color
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}
