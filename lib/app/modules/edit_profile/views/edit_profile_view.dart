import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        title: Text('edit_profile'.tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
        centerTitle: true,

      ),
      body: Container(
        padding: EdgeInsets.all(DEFAULT_PADDING * 1.0),
        child: ListView(
          children: [
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

              ],
            ):ListTile(
                leading: Text("You can see more settings after you sign in",
                    style: Theme.of(context).textTheme.titleMedium)
            ),
          ],
        ),
      )
    );
  }
}
