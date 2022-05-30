import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/ad_suggestion_on_notifications.dart';
import 'package:dont_waste/app/widgets/notification_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        title: Text('notifications'.tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
        centerTitle: true,

      ),
      body: Container(
        width: double.infinity,
        child: Obx(
          () => ListView(
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                child: Visibility(visible: controller.isLoading.value , child: Container(
                  //padding: EdgeInsets.all(50),
                  //width: 85.w,
                  child: Container(
                      padding: EdgeInsets.all(15),
                      //width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: black4,
                        borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(
                              color: yellow1,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'loading'.tr(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                )),
              ),
              Visibility(visible: !controller.isLoading.value && controller.notifications.value.length == 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 80,),
                        Image.asset('assets/images/sad.gif', height: 150, width: 150,),
                        SizedBox(height: 30,),
                        Text("no_foods_found".tr(), textAlign: TextAlign.center,)
                      ],
                    ),
                  )
              ),
              // Padding(
              //     padding: EdgeInsets.only(bottom: 20),
              //     child: AdSuggestionOnNotifications()),
              ...controller.notifications.value.map((e) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: NotificationCard(
                    postedTimestamp: e.postedTimestamp ?? 0,
                    title: e.title ?? "null",
                    description: e.description ?? "null",
                    photo_url: e.photo_url ?? "",
                    onReadMore: () {
                      // FoodPreviewBinding().dependencies();
                      // Get.find<FoodPreviewController>().foodModel = e;
                      // Get.toNamed("/food-preview");
                    },
                  ),
                );
              }).toList()
            ],
          ),
        ),
      )
    );
  }
}
