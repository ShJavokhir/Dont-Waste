import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/ad_suggestion_on_notifications.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  var faqs = [
    {
      "title": "faqt1",
      "description": "faqd1"
    },
    {
      "title": "faqt2",
      "description": "faqd2"
    },
    {
      "title": "faqt3",
      "description": "faqd3"
    },
    {
      "title": "faqt4",
      "description": "faqd4"
    },
    {
      "title": "faqt5",
      "description": "faqd5"
    },
    {
      "title": "faqt6",
      "description": "faqd6"
    },
    {
      "title": "faqt7",
      "description": "faqd7"
    },
    {
      "title": "faqt8",
      "description": "faqd8"
    },
    {
      "title": "faqt9",
      "description": "faqd9"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.4,
          title: Text('faq'.tr(), style: Theme.of(Get.context!).textTheme.bodyText1),
          centerTitle: true,

        ),
        body: Container(
          width: double.infinity,
          child: ListView(
              physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              children: [
                SizedBox(height: 20,),
                ...faqs.map((e) {
                  return Padding(
                      padding: EdgeInsets.only(bottom: 20, right: DEFAULT_PADDING * 1.0, left: DEFAULT_PADDING * 1.0),
                      child: Card(
                        child: ExpansionTile(
                          title: Text(e["title"]!.tr(),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                          ),
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Divider(),
                                    Text(e["description"]!.tr(),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleSmall,
                                      maxLines: 20,),
                                  ],
                                )),
                          ],
                        ),
                      ));
                }).toList(),



              ],
            ),

        )
    );
  }
}
