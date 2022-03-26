import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/data/models/food_model.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/modules/food_preview/views/food_preview_view.dart';
import 'package:dont_waste/app/widgets/single_food_order.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../controllers/food_market_controller.dart';

class FoodMarketView extends GetView<FoodMarketController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            IconButton(icon: Icon(Icons.menu), onPressed: (){

            },),
          ],
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Get.back();
          },),
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
              child: Obx(
                () => ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ...controller.foods.value.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: SingleFoodOrder(
                          id: e.id,
                          title: e.title ?? "null",
                          price: e.price ?? 0,
                          location: e.city ?? "Uzbekistan",
                          photo_url: e.photo_url,
                          onPressed: () {
                            FoodPreviewBinding().dependencies();
                            Get.find<FoodPreviewController>().foodModel = e;
                            Get.toNamed("/food-preview");
                          },
                        ),
                      );
                    }).toList()
                  ],
                ),
              ),

              // ListView(
              //   physics: BouncingScrollPhysics(
              //       parent: AlwaysScrollableScrollPhysics()),
              //   children: [
              //     SizedBox(height: 10),

              //     ),
              //   ],
              // )
            ),
          )
        ]),
      ),
    );
  }
}
