import 'package:dont_waste/app/modules/become_sponsor/bindings/become_sponsor_binding.dart';
import 'package:dont_waste/app/modules/become_sponsor/views/become_sponsor_view.dart';
import 'package:dont_waste/app/modules/food_market/views/food_market_view.dart';
import 'package:dont_waste/app/widgets/choice_card.dart';
import 'package:dont_waste/app/widgets/divider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/choice_view_controller.dart';

class ChoiceViewView extends GetView<ChoiceViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FeedMe'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChoiceCard(
                text: 'Find food',
                imageUrl: 'assets/images/burger.png',
                callback: () {
                  //Get.to(() => FoodMarketView());
                  Get.toNamed("/food-market");
                },
              ),
              SizedBox(
                height: 50,
              ),
              CustomDivider(text: "OR"),
              SizedBox(
                height: 50,
              ),
              ChoiceCard(
                text: 'Become a sponsor',
                imageUrl: 'assets/images/lunch.png',
                callback: () {
                  //Get.to(() => BecomeSponsorView());
                  Get.toNamed("/become-sponsor");
                },
              ),
              //ChoiceCard()
            ],
          ),
        ));
  }
}
