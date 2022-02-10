import 'dart:ui';

import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/food_preview/views/food_preview_view.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../controllers/food_market_controller.dart';

class FoodMarketView extends GetView<FoodMarketController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Container(
            child: ClipRRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                        child: Text("Find food",
                            style: Theme.of(context).textTheme.bodyText1)),
                  ],
                ),
              ),
            )),
          ),
          centerTitle: false,
        ),
        body: Column(children: [
          Expanded(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(DEFAULT_PADDING * 1.0),
                child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SingleFoodOrder(
                      title: 'Delicious food3',
                      onPressed: () {
                        Get.to(FoodPreviewView());
                      },
                    ),
                    SingleFoodOrder(
                      title: 'Delicious food7',
                      onPressed: () {
                        Get.to(FoodPreviewView());
                      },
                    ),
                    SingleFoodOrder(
                      title: 'Delicious food',
                      onPressed: () {
                        Get.to(FoodPreviewView());
                      },
                    ),
                    SingleFoodOrder(
                      title: 'Delicious food4',
                      onPressed: () {
                        Get.to(FoodPreviewView());
                      },
                    ),
                  ],
                )),
          )
        ]),
      ),
    );
  }
}
