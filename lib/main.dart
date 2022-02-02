import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(Sizer(
    builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        darkTheme: ThemeData(
          iconTheme: IconThemeData(color: Colors.black87, size: 15.sp),
        ),
        theme: ThemeData(
          fontFamily: GoogleFonts.comfortaa().fontFamily,
          iconTheme: IconThemeData(color: Colors.black87, size: 20.sp),
          textTheme: TextTheme(
              bodyText2: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: GoogleFonts.comfortaa().fontFamily)),
          primaryColor: Colors.grey,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.red,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.comfortaa().fontFamily),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: "WasteToCash",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    },
  ));
}
