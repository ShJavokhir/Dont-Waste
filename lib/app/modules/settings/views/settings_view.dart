import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // // appBar: AppBar(
      // //     backgroundColor: Colors.white,
      // //     elevation: 0.4,
      // //     //automaticallyImplyLeading: false,
      // //     title: Text('settings'.tr(),
      // //         style: Theme.of(Get.context!).textTheme.bodyText1),
      // //     centerTitle: true,
      //
      // ),
      backgroundColor: black4,

      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SizedBox(height: 20,),
                    Visibility(
                      visible: FirebaseAuth.instance.currentUser==null,
                      child: Container(
                        //padding: EdgeInsets.all(DEFAULT_PADDING * 1.0),
                        margin: EdgeInsets.only(right: DEFAULT_PADDING * 1.0, left: DEFAULT_PADDING * 1.0, bottom: DEFAULT_PADDING * 1.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                offset: new Offset(0.0, 0.1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 /3),
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,

                                splashColor: yellow1,
                                onTap: (){
                                  Get.toNamed("/authentication");
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0, vertical: DEFAULT_PADDING * 1.0 * 1.3),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.login_rounded, size: 15.sp, color: yellow1,),
                                          SizedBox(width: 10,),
                                          Text("sign_in".tr(), style: Theme.of(context).textTheme.subtitle1!.copyWith(color: yellow1)),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios_rounded, size: 15.sp,color: yellow1)
                                    ],

                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0 + 10),
                      child: Text("main".tr(), style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      //padding: EdgeInsets.all(DEFAULT_PADDING * 1.0),
                      margin: EdgeInsets.only(right: DEFAULT_PADDING * 1.0, left: DEFAULT_PADDING * 1.0, bottom: DEFAULT_PADDING * 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              offset: new Offset(0.0, 0.1),
                            ),
                          ],
                        borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 /3),
                        color: Colors.white
                      ),
                      child: Column(
                        children: [

                          SettingsOptionTile(context, "change_language".tr(), Icons.language_rounded, (){
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


                          }),
                          Divider(height: 0,),
                          SettingsOptionTile(context,"edit_profile".tr(), Icons.mode_edit_rounded,(){
                            if(FirebaseAuth.instance.currentUser==null){
                              showInfoSnackbar("login_required".tr());
                              return;
                            }
                            Get.toNamed('/edit-profile');
                          }),
                          Divider(height: 0,),
                          SettingsOptionTile(context,"exchange_coins".tr(), Icons.currency_exchange_rounded,(){
                            Get.toNamed('/bonus-coins');
                          }),
                          Divider(height: 0,),
                          SettingsOptionTile(context,"statistics".tr(), Icons.bar_chart_rounded, (){
                            Get.toNamed('/statistics');
                          }),
                          Divider(height: 0,),
                          SettingsOptionTile(context,"application".tr(), Icons.info_rounded, (){
                            Get.toNamed('/about');
                          }),


                          Divider(height: 0,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0, vertical: DEFAULT_PADDING * 1.0 * 1.3),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.notifications_rounded, size: 15.sp, color: Colors.black87 ),
                                    SizedBox(width: 10,),
                                    Text("notifications".tr(), style: Theme.of(context).textTheme.subtitle1,),
                                  ],
                                ),
                                Spacer(),
                                Obx(
                                      () => CupertinoSwitch(
                                        activeColor: yellow1,
                                          value: controller.isNotificationOn.value, onChanged: (value){
                                    print(value);
                                    controller.isNotificationOn.value = value;
                                  }),
                                )
                              ],

                            ),
                          ),
                          Divider(height: 0,),
                          Visibility(
                            visible: FirebaseAuth.instance.currentUser != null,
                            child: GestureDetector(
                              onTap: (){
                                Clipboard.setData(ClipboardData(text: FirebaseAuth.instance.currentUser != null
                                    ? FirebaseAuth.instance.currentUser!.uid
                                    : "null"));
                                showInfoSnackbar("user_id_copied".tr());
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0, vertical: DEFAULT_PADDING * 1.0 * 1.3),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(
                                        'user_id'.tr(),
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          alignment: Alignment.center,
                                          // height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.circular(
                                                BORDER_RADIUS_1 * 1.0),
                                          ),
                                          child: FittedBox(
                                            child: Text(
                                              FirebaseAuth.instance.currentUser != null
                                                  ? FirebaseAuth.instance.currentUser!.uid
                                                  : "null",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black54)
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0 + 10),
                      child: Text("additional".tr(), style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      //padding: EdgeInsets.all(DEFAULT_PADDING * 1.0),
                      margin: EdgeInsets.only(right: DEFAULT_PADDING * 1.0, left: DEFAULT_PADDING * 1.0, bottom: DEFAULT_PADDING * 1.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              offset: new Offset(0.0, 0.1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 /3),
                          color: Colors.white
                      ),
                      child: Column(
                        children: [

                          SettingsOptionTile(context, "faq".tr(), Icons.question_mark_rounded ,(){
                            Get.toNamed('/faq');
                          }),
                          Divider(height: 0,),
                          SettingsOptionTile(context, "our_contacts".tr(), Icons.quick_contacts_dialer_rounded, (){
                            Get.toNamed('/contacts');
                          }),
                          Divider(height: 0,),
                          SettingsOptionTile(context, "api_documentation".tr(), Icons.code_rounded, ()async{
                            if (await canLaunch("https://documenter.getpostman.com/view/14751979/Uz5CNe8p")) {
                            launch("https://documenter.getpostman.com/view/14751979/Uz5CNe8p");

                            } else {
                            showErrorSnackbar("Could not open website");
                            }
                          }),
                          Divider(height: 0,),
                          SettingsOptionTile(context, "terms_of_use".tr(), Icons.warning_rounded ,()async{
                            if (await canLaunch("https://www.privacypolicytemplate.net/live.php?token=k8MnciouivDMmlFzEuw7oCivelqr3SS8")) {
                            launch("https://www.privacypolicytemplate.net/live.php?token=k8MnciouivDMmlFzEuw7oCivelqr3SS8");

                            } else {
                            showErrorSnackbar("Could not open website");
                            }
                          }),
                          Divider(height: 0,),
                          SettingsOptionTile(context, "share_application".tr(), Icons.share_rounded, (){
                            try {
                              launch("https://play.google.com/store/apps/details?id=uz.tie.dont_waste");
                            } on PlatformException catch(e) {
                              launch("https://play.google.com/store/apps/details?id=uz.tie.dont_waste");
                            } finally {
                              launch("https://play.google.com/store/apps/details?id=uz.tie.dont_waste");
                            }
                          }),


                        ],
                      ),
                    ),
                    Visibility(
                      visible: FirebaseAuth.instance.currentUser!=null,
                      child: Container(
                        //padding: EdgeInsets.all(DEFAULT_PADDING * 1.0),
                        margin: EdgeInsets.only(right: DEFAULT_PADDING * 1.0, left: DEFAULT_PADDING * 1.0, bottom: DEFAULT_PADDING * 1.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                offset: new Offset(0.0, 0.1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 /3),
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,

                                splashColor: yellow1,
                                onTap: (){
                                  controller.signOut();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0, vertical: DEFAULT_PADDING * 1.0 * 1.3),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.exit_to_app, size: 15.sp, color: Colors.redAccent,),
                                          SizedBox(width: 10,),
                                          Text("sign_out".tr(), style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.redAccent)),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios_rounded, size: 15.sp,color: Colors.redAccent)
                                    ],

                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    )


                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Material SettingsOptionTile(BuildContext context, String title, IconData titleIcon, void Function() onTap) {
    return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,

                            splashColor: yellow1,
                            onTap: onTap,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0, vertical: DEFAULT_PADDING * 1.0 * 1.3),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(titleIcon, size: 15.sp, color: Colors.black54),
                                      SizedBox(width: 10,),
                                      Text(title, style: Theme.of(context).textTheme.subtitle1,),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios_rounded, size: 15.sp, color: Colors.black87,)
                                ],

                              ),
                            ),
                          ),
                        );
  }
}
