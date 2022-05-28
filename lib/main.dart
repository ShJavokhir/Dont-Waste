import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');


    showNotificationSnackbar(message.notification!.title!, message.notification!.body!, timeout: 100000);
//
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    // NotificationService().selectNotification(json.encode(event.data));
    Get.toNamed('/notifications');
    // print("Received in background while the app is paused and not detached");
  });
  print("main");
  //print(FirebaseAuth.instance.currentUser!.uid);
  //print(FirebaseAuth.instance.currentUser!.phoneNumber);
  //FirebaseAuth.instance.signOut();
  //print(FirebaseAuth.instance.currentUser!.uid);
  await EasyLocalization.ensureInitialized();
  // print(FirebaseAuth.instance.currentUser!.metadata.creationTime!.millisecondsSinceEpoch);
  // print(DateTime.now().millisecondsSinceEpoch);
  // print((FirebaseAuth.instance.currentUser!.metadata.creationTime!.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch).abs().toString());
  runApp(EasyLocalization(
    path: "assets/langs",
    //fallbackLocale: Locale('en', 'EN'),
    fallbackLocale: Locale('en', 'EN'),
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

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}
