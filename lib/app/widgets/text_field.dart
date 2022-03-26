import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isMultipleLine;
  final String defaultText;
  void Function(String) onChanged;

  CustomTextField(
      {required this.hint,
      required this.onChanged,
      this.isMultipleLine = false,
      this.defaultText = ""
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            hint,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          //Type TextField
          width: double.infinity,
          height: isMultipleLine ? 150 : 60,
          alignment: isMultipleLine ? Alignment.topLeft : Alignment.centerLeft,
          decoration: BoxDecoration(
            color: black4,
            borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
          ),
          child: TextField(
            maxLines: isMultipleLine ? 6 : 1,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: defaultText,
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
