import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //GlobalBindings().dependencies();
  await Firebase.initializeApp();
  print("main");
  //print(FirebaseAuth.instance.currentUser!.uid);
  //print(FirebaseAuth.instance.currentUser!.phoneNumber);
  //FirebaseAuth.instance.signOut();
  //print(FirebaseAuth.instance.currentUser!.uid);
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    path: "assets/langs",
    //fallbackLocale: Locale('en', 'EN'),
    startLocale: Locale('en', 'EN'),
    supportedLocales: [Locale('ru', 'RU'), Locale('uz', 'UZ'), Locale('en', 'EN')],
    saveLocale: true,
    child: Sizer(
      builder: (context, orientation, deviceType) {
        //print("locales: " + context.locale.languageCode + " " + context.deviceLocale.languageCode + " " );
        //print(EasyLocalization.of(context).deviceLocale.languageCode)
        return GetMaterialApp(
          //locale: context.locale,
           supportedLocales: context.supportedLocales,
           localizationsDelegates: context.localizationDelegates,
          darkTheme: ThemeData(
            fontFamily: GoogleFonts.comfortaa().fontFamily,
            iconTheme: IconThemeData(color: Colors.black87, size: 20.sp),
            textTheme: TextTheme(
                bodyText1: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.comfortaa().fontFamily),
                bodyText2: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: GoogleFonts.comfortaa().fontFamily)),
            primaryColor: Colors.grey,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black87, size: 15.sp),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                systemNavigationBarColor: Colors.red,
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarDividerColor: Colors.red,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              //centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.comfortaa().fontFamily),
            ),
          ),
          theme: ThemeData(
            fontFamily: GoogleFonts.comfortaa().fontFamily,
            iconTheme: IconThemeData(color: Colors.black87, size: 20.sp),
            textTheme: TextTheme(
                bodyText1: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.comfortaa().fontFamily),
                bodyText2: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: GoogleFonts.comfortaa().fontFamily)),
            primaryColor: Colors.grey,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black87, size: 15.sp),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                systemNavigationBarColor: Colors.red,
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarDividerColor: Colors.red,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              //centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.comfortaa().fontFamily),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: "Don't Waste",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  ));
}
