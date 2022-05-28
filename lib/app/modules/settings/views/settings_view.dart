import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

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
      backgroundColor: Colors.white,

      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: ListTile(
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
                    ),
                    Divider(),
                    FirebaseAuth.instance.currentUser != null?Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            defaultText: FirebaseAuth.instance.currentUser != null
                                ? FirebaseAuth.instance.currentUser!.displayName ??
                                ""
                                : "null",
                            hint: "full_name".tr(),
                            isMultipleLine: false,
                            onChanged: (text) {
                              controller.fullName.value = text;
                              //controller.title.value = text;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          // margin:
                          // EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: black4,
                            borderRadius:
                            BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'user_id'.tr(),
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  height: double.infinity,
                                  width: 150,
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
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                              () => ElevatedButton(
                            onPressed: controller.fullName.value != ""
                                ? () async {
                              controller.saveFullName();
                            }
                                : null,
                            child: Container(
                                padding: EdgeInsets.all(15),
                                //width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "save".tr(),
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 15.sp),
                                )),
                            style: ElevatedButton.styleFrom(
                              //padding: EdgeInsets.all(20),

                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                              ),
                              shadowColor: Colors.transparent,
                              //side: BorderSide(width: 1, color: Colors.green),
                              primary: green2,
                              // <-- Button color
                              onPrimary: Colors.white, // <-- Splash color
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              controller.signOut();
                            },
                            child: Text(
                              "sign_out".tr(),
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ):ListTile(
                        leading: Text("You can see more settings after you sign in",
                            style: Theme.of(context).textTheme.titleMedium)
                    ),

                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
