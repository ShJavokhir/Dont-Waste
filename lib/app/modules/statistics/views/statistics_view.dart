import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

import '../controllers/statistics_controller.dart';

class StatisticsView extends GetView<StatisticsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.4,
          title: Text('statistics_page_title'.tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
          centerTitle: true,

        ),
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0.4,
        //   title: Text('about_page_title'.tr()),
        //   centerTitle: true,
        // ),
        body: Obx(
            ()=> Container(
            padding: EdgeInsets.fromLTRB(DEFAULT_PADDING * 1.0, 0, DEFAULT_PADDING * 1.0, 0),
            child: !controller.isLoading.value?ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  SizedBox(height: 30,),
                  Align(
                    //alignment: Alignment.center,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                            color: black4,
                            borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("total_users".tr(), style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal
                              ),),
                              SizedBox(height: 10,),
                              Text(controller.totalUsers.value.toString(), style: TextStyle(
                                  fontSize: 20.sp,
                                fontWeight: FontWeight.bold
                              ),)
                            ],
                          )
                        ),
                        Positioned(child: Image.asset('assets/images/customer-review.png', width: 200), top: -5, bottom: -5, left: -60,),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Align(
                    //alignment: Alignment.center,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                              color: black4,
                              borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("total_foods".tr(), style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal
                                ),),
                                SizedBox(height: 10,),
                                Text(controller.totalFoods.value.toString(), style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            )
                        ),
                        Positioned(child: Image.asset('assets/images/chat.png', width: 200), top: -5, bottom: -5, right: -60,),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),




                ]):Container(
              margin: EdgeInsets.all(DEFAULT_PADDING * 1.0),
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
          ),
        )
    );
  }
}
