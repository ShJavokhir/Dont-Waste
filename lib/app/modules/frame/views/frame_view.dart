import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/about/views/about_view.dart';
import 'package:dont_waste/app/modules/become_sponsor/views/become_sponsor_view.dart';
import 'package:dont_waste/app/modules/choice_view/views/choice_view_view.dart';
import 'package:dont_waste/app/modules/food_market/views/food_market_view.dart';
import 'package:dont_waste/app/modules/frame/bindings/frame_binding.dart';
import 'package:dont_waste/app/modules/settings/views/settings_view.dart';
import 'package:dont_waste/app/modules/user_profile/views/user_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../controllers/frame_controller.dart';

class FrameView extends GetView<FrameController> {
  List<Widget> _pages = [
    // ChoiceViewView(),
    FoodMarketView(),
    BecomeSponsorView(),
    UserProfileView(),
    SettingsView()
  ];
  List<Widget> _getAppBars = [
    //Text("app_name".tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
    Text("find_food_page".tr(),
        style: Theme.of(Get.context!).textTheme.bodyText1),
    Text("become_sponsor".tr(),
        style: Theme.of(Get.context!).textTheme.bodyText1),
    Text("account".tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
    Text('settings'.tr(), style: Theme.of(Get.context!).textTheme.bodyText1)
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: GetBuilder<FrameController>(
        builder: (controller) {
          return Scaffold(
            drawer: buildDrawer(context),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.4,
              //automaticallyImplyLeading: false,
              title: [
                //Text("app_name".tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
                Text("find_food_page".tr(),
                    style: Theme.of(Get.context!).textTheme.bodyText1),
                Text("become_sponsor".tr(),
                    style: Theme.of(Get.context!).textTheme.bodyText1),
                Text("account".tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
                Text('settings'.tr(), style: Theme.of(Get.context!).textTheme.bodyText1)
              ][controller.tabIndex],
              centerTitle: true,
              actions: [
                false
                    ? Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: DEFAULT_PADDING * 1.0),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/bell.gif',
                                height: 30,
                                width: 30,
                              ),
                              Positioned(
                                  right: 5,
                                  top: 5,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                  ))
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.only(right: DEFAULT_PADDING * 1.0 / 2),
                        child: IconButton(
                          onPressed: () {
                            Get.toNamed("/notifications");
                          },
                          icon: Icon(Icons.notifications_rounded, color: Colors.black87,),
                          iconSize: 20.sp,
                        ))
              ],
            ),
            body: SafeArea(child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
                switchInCurve: Curves.linear,
                switchOutCurve: Curves.linear,
                child: _pages[controller.tabIndex])),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(BORDER_RADIUS_1 * 1.0),
                    topLeft: Radius.circular(BORDER_RADIUS_1 * 1.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0.05,
                      blurRadius: 0.01),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(BORDER_RADIUS_1 * 1.0),
                  topRight: Radius.circular(BORDER_RADIUS_1 * 1.0),
                ),
                child: BottomNavigationBar(
                  elevation: 20,
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  currentIndex: controller.tabIndex,
                  onTap: (index) async {
                    controller.changeTabIndex(index);
                    // final currentIndex = 1;
                    // if(index == 0 && currentIndex != 0){
                    //   Get.offAllNamed('/choice-view');
                    // }else if(index == 1 && currentIndex != 1){
                    //   FoodMarketBinding().dependencies();
                    //   await Get.find<FoodMarketController>().setFoods();
                    //   //await Future.delayed(Duration(seconds: 2));
                    //   Get.offAllNamed("/food-market");
                    // }else if(index == 2 && currentIndex != 2){
                    //   Get.toNamed("/become-sponsor");
                    // }else if(index == 3 && currentIndex != 3){
                    //   if (FirebaseAuth.instance.currentUser != null) {
                    //     // signed in
                    //     UserProfileBinding().dependencies();
                    //     await Get.find<UserProfileController>().setFoods();
                    //     // Get.toNamed("/food-preview");
                    //     Get.toNamed('/user-profile');
                    //     //print("Signed");
                    //   } else {
                    //     print("Not signed in yet");
                    //     Get.toNamed("/authentication");
                    //   }
                    // }
                  },

                  type: BottomNavigationBarType.fixed,
                  // Fixed
                  backgroundColor: Colors.white,
                  // <-- This works for fixed
                  selectedItemColor: yellow1,
                  unselectedItemColor: Colors.grey,
                  //iconSize: 15.sp,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'home_button'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add_a_photo),
                      label: 'add_post_button'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: 'profile_button'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'settings'.tr(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/icon.png',
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "app_name".tr(),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),

          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text('home_button'.tr(),
          //       style: Theme.of(context).textTheme.titleMedium),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Get.find<FrameController>().changeTabIndex(0);
          //
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('foods_button'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Get.find<FrameController>().changeTabIndex(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text('add_post_button'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Get.find<FrameController>().changeTabIndex(1);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('profile_button'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Get.find<FrameController>().changeTabIndex(2);
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('settings'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              // Get.toNamed("/settings");
              Get.find<FrameController>().changeTabIndex(3);
              // Get.find<FrameController>().changeTabIndex(3, initialIndex: 1);
            },
          ),
          //Spacer(),
          Divider(),

          ListTile(
            leading: Icon(Icons.language_rounded),
            title: Text('change_language'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                barrierDismissible: true,
                context: Get.context!,
                builder: (BuildContext context) {
                  return AlertDialog(
                    alignment: Alignment.center,
                    content: ListTile(
                      leading: Text("language".tr(),
                          style: Theme.of(context).textTheme.titleMedium),
                      title: DropdownButton<String>(
                        underline: Container(),
                        value: context.locale.countryCode,
                        selectedItemBuilder: (_) {
                          return <String>['EN', 'RU', 'UZ']
                              .map((String choice) {
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    'assets/images/$choice.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(choice),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            );
                          }).toList();
                        },
                        items:
                        <String>['EN', 'RU', 'UZ'].map((String choice) {
                          return DropdownMenuItem<String>(
                            value: choice,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/$choice.png',
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(choice)
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (opt) {
                          Get.back();
                          if (opt == "UZ") {
                            final locale = Locale("uz", "UZ");
                            context.setLocale(locale);
                            EasyLocalization.of(context)!.setLocale(locale);
                            //EasyLocalization.of(context)!.currentLocale = locale;
                            Get.updateLocale(locale);
                          } else if (opt == "RU") {
                            final locale = (Locale("ru", "RU"));
                            context.setLocale(locale);
                            Get.updateLocale(locale);
                            EasyLocalization.of(context)!.setLocale(locale);
                          } else if (opt == "EN") {
                            final locale = (Locale("en", "EN"));
                            context.setLocale(locale);
                            Get.updateLocale(locale);
                            EasyLocalization.of(context)!.setLocale(locale);
                          }

                          //Get.offAndToNamed('/choice-view');
                          Get.forceAppUpdate();
                          Get.appUpdate();
                        },
                      ),
                    ),
                  );

                },
              );

            },
          ),
          ListTile(
            leading: Icon(Icons.currency_exchange_rounded),
            title: Text('exchange_coins'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/bonus-coins');
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_rounded),
            title: Text('statistics'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/statistics');
            },
          ),
          ListTile(
            leading: Icon(Icons.info_rounded),
            title: Text('application'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/about');
              },
          ),
          ListTile(
            leading: Icon(Icons.question_mark_rounded),
            title: Text('faq'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/faq');
            },
          ),
          ListTile(
            leading: Icon(Icons.quick_contacts_dialer_rounded),
            title: Text('our_contacts'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/contacts');
            },
          ),


          // PopupMenuButton<String>(
          //
          //     icon: Icon(Icons.language_sharp),
          //     onSelected: (String opt) {
          //       if (opt == "UZ") {
          //         final locale = Locale("uz", "UZ");
          //         context.setLocale(locale);
          //         EasyLocalization.of(context)!.setLocale(locale);
          //         //EasyLocalization.of(context)!.currentLocale = locale;
          //         Get.updateLocale(locale);
          //       } else if (opt == "RU") {
          //         final locale =(Locale("ru", "RU"));
          //         context.setLocale(locale);
          //         Get.updateLocale(locale);
          //         EasyLocalization.of(context)!.setLocale(locale);
          //       } else if (opt == "EN") {
          //         final locale =(Locale("en", "EN"));
          //         context.setLocale(locale);
          //         Get.updateLocale(locale);
          //         EasyLocalization.of(context)!.setLocale(locale);
          //       }
          //
          //       //Get.offAndToNamed('/choice-view');
          //
          //     },
          //     itemBuilder: (BuildContext context) {
          //       return {'UZ', 'RU', 'EN'}.map((String choice) {
          //         return PopupMenuItem<String>(
          //           value: choice,
          //           child: ListTile(
          //             leading: Image.asset('assets/images/$choice.png', height: 30, width: 30,),
          //             title: Text(choice),
          //           ),
          //         );
          //       }).toList();
          //     },
          //   ),
          // Spacer(),
          Divider(),

          Visibility(
            visible: FirebaseAuth.instance.currentUser != null,
            child: ListTile(
              leading:
                  Icon(Icons.exit_to_app, color: Colors.redAccent, size: 18.sp),
              title: Text('sign_out'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.red)),
              onTap: () {
                //Navigator.pop(context);
                Get.find<FrameController>().signOut();
              },
            ),
          ),
        ],
      ),
    ),
  );
}
