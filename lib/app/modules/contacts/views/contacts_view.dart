import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/contacts_controller.dart';

class ContactsView extends GetView<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black4,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        title: Text('contacts_page_title'.tr(),
            style: Theme.of(Get.context!).textTheme.bodyText1),
        centerTitle: true,
      ),
      body: Container(
          // padding: EdgeInsets.all(DEFAULT_PADDING * 1.0),
          child: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
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
                getContactTile(
                    context, "Email:", "dontwasteapp@gmail.com", () async{
                  // if (await canLaunch("mailto:dontwasteapp@gmail.com")) {
                  // launch("mailto:dontwasteapp@gmail.com");
                  // } else {
                  // showErrorSnackbar("unexpected_error".tr());
                  // }
                }),
                Divider(
                  height: 0,
                ),
                getContactTile(context, "Tel:", "(998) 277-88-77", () async{
                  // if (await canLaunch("tel:+998982778877")) {
                  //   launch("tel:+998982778877");
                  // } else {
                  // showErrorSnackbar("unexpected_error".tr());
                  // }
                }),
                Divider(
                  height: 0,
                ),
                getContactTile(
                    context, "TG help group", "@DontWasteGroup", () async{
                  if (await canLaunch("https://t.me/DontWasteGroup")) {
                  launch("https://t.me/DontWasteGroup");
                  } else {
                  showErrorSnackbar("unexpected_error".tr());
                  }
                }),
                Divider(
                  height: 0,
                ),
                getContactTile(context, "Website:", "www.iwt.uz", () async {
                  if (await canLaunch("https://iwt.uz")) {
                    launch("https://iwt.uz");
                  } else {
                    showErrorSnackbar("Could not open website");
                  }
                }),
              ],
            ),
          )
        ],
      )),
    );
  }

  Material getContactTile(BuildContext context, String title,
      String description, void Function() onTap) {
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
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: yellow1),
                        width: 10,
                        height: 10,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              )),
        ));
  }
}
