import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String text;
  CustomDivider({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 18),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 18,
          ),
          Flexible(
            child: Container(
              height: 5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(24)),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          Text(text),
          SizedBox(
            width: 18,
          ),
          Flexible(
            child: Container(
              height: 5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black87,
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
