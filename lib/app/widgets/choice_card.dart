import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChoiceCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  final void Function() callback;
  ChoiceCard(
      {required this.text, required this.imageUrl, required this.callback}) {}
  @override
  void initState() {
    //Firebase.initializeApp();
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   //setState(() {});
    // });

    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 60.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0xFFd8dbe0),
                offset: Offset(0, 2),
                blurRadius: 30.0,
                spreadRadius: 10),
          ],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Material(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: imageUrl,
                    child: Image.asset(
                      imageUrl,
                      height: 35.w,
                      width: 35.w,
                      alignment: Alignment.center,
                    ),
                  ),
                  Hero(
                      tag: imageUrl + "choice",
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ))
                ],
              ),
            ),
            onTap: callback,
            splashColor: Colors.yellow,
            highlightColor: Colors.transparent,
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
