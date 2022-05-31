import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/user_profile/controllers/user_data_controller.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

import '../controllers/bonus_coins_controller.dart';

class BonusCoinsView extends GetView<BonusCoinsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        title: Text('bonus_page_title'.tr(), style: Theme
            .of(Get.context!)
            .textTheme
            .bodyText1),
        centerTitle: true,

      ),
      backgroundColor: black4,
      body: Container(

        child: ListView(
          physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          children: [
          SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      BORDER_RADIUS_1 * 1.0 / 2),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      offset: new Offset(0.5, 0.5),
                    ),
                  ],

                ),
                child: Image.asset(
                  'assets/images/discount.png', width: 50, height: 50,)),
            SizedBox( width: 20),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text((Get.find<UserDataController>().userModel.bonusCoins ?? 0).toString(), style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,),
                SizedBox(height: 5,),
                Text("your_bonus_coins".tr(), style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54
                ),),

              ],
            )
          ],
        ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(DEFAULT_PADDING * 1.0),
              margin: EdgeInsets.all(DEFAULT_PADDING * 1.0),
              width: double.infinity,
              decoration: BoxDecoration(
                // boxShadow: <BoxShadow>[
                //   new BoxShadow(
                //     color: Colors.black26,
                //     blurRadius: 3.0,
                //     offset: new Offset(0.0, 3.0),
                //   ),
                // ],
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 / 3),
                  color: Colors.white),
              child: Column(
                children: [
                  getBonusPrize(
                      context, "bonus_free_advertisement".tr(), "50", () async{
                    if (await canLaunch("https://t.me/DontWasteGroup")) {
                      launch("https://t.me/DontWasteGroup");
                    } else {
                      showErrorSnackbar("unexpected_error".tr());
                    }
                    // if (await canLaunch("mailto:dontwasteapp@gmail.com")) {
                    // launch("mailto:dontwasteapp@gmail.com");
                    // } else {
                    // showErrorSnackbar("unexpected_error".tr());
                    // }
                  }),
                  Divider(
                    height: 0,
                  ),
                  getBonusPrize(context, "bonus_cap".tr(), "300", () async{
                    if (await canLaunch("https://t.me/DontWasteGroup")) {
                      launch("https://t.me/DontWasteGroup");
                    } else {
                      showErrorSnackbar("unexpected_error".tr());
                    }
                    // if (await canLaunch("tel:+998982778877")) {
                    //   launch("tel:+998982778877");
                    // } else {
                    // showErrorSnackbar("unexpected_error".tr());
                    // }
                  }),
                  Divider(
                    height: 0,
                  ),
                  getBonusPrize(context, "bonus_cup".tr(), "350", () async {
                    if (await canLaunch("https://t.me/DontWasteGroup")) {
                      launch("https://t.me/DontWasteGroup");
                    } else {
                      showErrorSnackbar("unexpected_error".tr());
                    }
                  }),
                  Divider(
                    height: 0,
                  ),
                  getBonusPrize(
                      context, "bonus_shirt".tr(), "400", () async{
                    if (await canLaunch("https://t.me/DontWasteGroup")) {
                      launch("https://t.me/DontWasteGroup");
                    } else {
                      showErrorSnackbar("unexpected_error".tr());
                    }

                  }),

                ],
              ),
            )

      ],
    ),)
    ,
    );
  }
  Material getBonusPrize(BuildContext context, String name,
      String amount, void Function() onTap) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: yellow1,
          onTap: onTap,
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Container(
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle, color: Colors.green),
                      //   width: 10,
                      //   height: 10,
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(width: 5,),
                      Image.asset(
                        'assets/images/discount.png', width: 20, height: 20,)
                    ],
                  )
                ],
              )),
        ));
  }
}


