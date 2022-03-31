import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/about/views/about_view.dart';
import 'package:dont_waste/app/modules/become_sponsor/views/become_sponsor_view.dart';
import 'package:dont_waste/app/modules/choice_view/views/choice_view_view.dart';
import 'package:dont_waste/app/modules/food_market/views/food_market_view.dart';
import 'package:dont_waste/app/modules/frame/bindings/frame_binding.dart';
import 'package:dont_waste/app/modules/user_profile/views/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../controllers/frame_controller.dart';

class FrameView extends GetView<FrameController> {
  List<Widget> _pages = [
    ChoiceViewView(),
    FoodMarketView(),
    BecomeSponsorView(),
    UserProfileView(),
    AboutView()
  ];
  List<Widget> _getAppBars = [
    Text("app_name".tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
    Container(
      child: Container(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'assets/images/burger.png',
              child: Image.asset(
                'assets/images/burger.png',
                alignment: Alignment.center,
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(width: 10),
            // Hero(
            //   tag: 'assets/images/burger.png',
            //   child: Flexible(
            //     child: Image.asset(
            //       'assets/images/burger.png',
            //       alignment: Alignment.center,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            Hero(
                tag: 'assets/images/burger.pngchoice',
                child: Text("find_food_page".tr(),
                    style: Theme.of(Get.context!).textTheme.bodyText1)),
          ],
        ),
      ),
    ),
    Container(
      child: Container(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'assets/images/lunch.png',
              child: Image.asset(
                'assets/images/lunch.png',
                alignment: Alignment.center,
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 10),
            // Hero(
            //   tag: 'assets/images/burger.png',
            //   child: Flexible(
            //     child: Image.asset(
            //       'assets/images/burger.png',
            //       alignment: Alignment.center,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            Hero(
                tag: 'assets/images/lunch.pngchoice',
                child: Text("become_sponsor".tr(),
                    style: Theme.of(Get.context!).textTheme.bodyText1)),
          ],
        ),
      ),
    ),
    Text("account".tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
    Text('about_page_title'.tr(),
        style: Theme.of(Get.context!).textTheme.bodyText1)
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrameController>(
      builder: (controller) {
        return Scaffold(
          drawer: buildDrawer(context),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.4,
            //automaticallyImplyLeading: false,
            title: _getAppBars[controller.tabIndex],
            centerTitle: true,
          ),
          body: SafeArea(child: _pages[controller.tabIndex]),
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
                    icon: Icon(Icons.shopping_cart),
                    label: 'foods_button'.tr(),
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
                    icon: Icon(Icons.question_mark_rounded),
                    label: 'about_button'.tr(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
Drawer buildDrawer(BuildContext context) {
  return Drawer(
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
                width: 80,
                height: 80,
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

        ListTile(
          leading: Icon(Icons.home),
          title: Text('home_button'.tr(),
              style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            Navigator.pop(context);
            Get.find<FrameController>().changeTabIndex(0);

          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('foods_button'.tr(),
              style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            Navigator.pop(context);
            Get.find<FrameController>().changeTabIndex(1);

          },
        ),
        ListTile(
          leading: Icon(Icons.add_a_photo),
          title: Text('add_post_button'.tr(),
              style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            Navigator.pop(context);
            Get.find<FrameController>().changeTabIndex(2);

          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),

          title: Text('profile_button'.tr(),
              style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            Navigator.pop(context);
            Get.find<FrameController>().changeTabIndex(3);

          },
        ),
        ListTile(
          leading: Icon(Icons.question_mark_rounded),
          title: Text('info'.tr(),
              style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            Navigator.pop(context);
            Get.find<FrameController>().changeTabIndex(4);

          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('settings'.tr(),
              style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            Navigator.pop(context);
            Get.find<FrameController>().changeTabIndex(3, initialIndex: 1);
          },
        ),
        //Spacer(),
        Divider(),

        Container(

          width: double.infinity,
          child: ListTile(
            leading: Text("language".tr(),style: Theme.of(context).textTheme.titleMedium),
            title: DropdownButton<String>(
              underline: Container(),
              value: context.locale.countryCode,
              selectedItemBuilder: (_) {
                return  <String>['EN', 'RU', 'UZ'].map((String choice) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //SizedBox(width: 20,),
                        Image.asset('assets/images/$choice.png', height: 30, width: 30,),
                        SizedBox(width: 15,),
                        Text(choice),
                        SizedBox(width: 15,),
                      ],
                    ),
                  );
                }).toList();
              },
              items: <String>['EN', 'RU', 'UZ'].map((String choice) {
                return DropdownMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      Image.asset('assets/images/$choice.png', height: 30, width: 30,),
                      SizedBox(width: 15,),
                      Text(choice)
                    ],
                  ),
                );
              }).toList(),
              onChanged: (opt) {

                      if (opt == "UZ") {
                        final locale = Locale("uz", "UZ");
                        context.setLocale(locale);
                        EasyLocalization.of(context)!.setLocale(locale);
                        //EasyLocalization.of(context)!.currentLocale = locale;
                        Get.updateLocale(locale);
                      } else if (opt == "RU") {
                        final locale =(Locale("ru", "RU"));
                        context.setLocale(locale);
                        Get.updateLocale(locale);
                        EasyLocalization.of(context)!.setLocale(locale);
                      } else if (opt == "EN") {
                        final locale =(Locale("en", "EN"));
                        context.setLocale(locale);
                        Get.updateLocale(locale);
                        EasyLocalization.of(context)!.setLocale(locale);
                      }

                      //Get.offAndToNamed('/choice-view');
                Get.forceAppUpdate();
                Get.appUpdate();
                      //FrameBinding().dependencies();
                //       await Get.find<FoodMarketController>().setFoods();

              },
            ),
          ),
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
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app,
              color: Colors.redAccent, size: 18.sp),
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
      ],
    ),
  );
}
