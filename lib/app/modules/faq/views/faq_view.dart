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
      "title": "What kind of app is this?",
      "description": "This application helps you to not waste your additional foods. Instead you can sell them for money or just donate to hungry people"
    },
    {
      "title": "Is this app free?",
      "description": "Yes this app free to sell/donate your foods. You can post your foods without any fees. In case you want to sell/donate your foods faster, you can check out our paid plans"
    },
    {
      "title": "How can I see foods near to me?",
      "description": "On the home page you can see 'See nearby foods' button. Just click it and app shows you all foods near you on the map interactively"
    },
    {
      "title": "How to post food",
      "description": "Simply click 'Post food' icon on the bottom, fill required fields and you are ready to go"
    },
    {
      "title": "Can I sell/donate my foods faster?",
      "description": "We recommend you our paid plans, by using our paid plans, more users would reach your foods and it helps to sell/donate them faster"
    },
    {
      "title": "Can I edit/delete my post?",
      "description": "Yes of course, there is profile tab on the bottom bar, just click it and you can see your foods list with the management features"
    },
    {
      "title": "How to deposit money to my account?",
      "description": "Just go on profile page and click deposit or plus icon. Currently there is uzcard option. By the way current payments are being verified manually, in future it can be managed automatically"
    },
    {
      "title": "Can I sell/donate expired foods?",
      "description": "Yes of course, expired foods can be useful for animals and even for gardening. Just switch off 'Is eatable?' option when you are posting"
    },
    {
      "title": "What are benefits of paid plans?",
      "description": "With the help of paid plans, more viewers can reach your foods, so it may help you to sell/donate your foods faster"
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
                          title: Text(e["title"]!,
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
                                    Text(e["description"]!,
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
