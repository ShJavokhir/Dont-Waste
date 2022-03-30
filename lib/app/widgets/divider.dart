import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDivider extends StatelessWidget {
  final String text;
  CustomDivider({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 18,
          ),
          Flexible(
            child: Container(
              height: 2,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(24)),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          Text(text, style: TextStyle(
            fontSize: 10.sp,

          ),),
          SizedBox(
            width: 18,
          ),
          Flexible(
            child: Container(
              height: 2,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(24)),
            ),
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
    );
  }
}
