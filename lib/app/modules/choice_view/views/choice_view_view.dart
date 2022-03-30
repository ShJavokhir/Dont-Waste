import 'package:dont_waste/app/modules/become_sponsor/bindings/become_sponsor_binding.dart';
import 'package:dont_waste/app/modules/become_sponsor/views/become_sponsor_view.dart';
import 'package:dont_waste/app/modules/food_market/bindings/food_market_binding.dart';
import 'package:dont_waste/app/modules/food_market/controllers/food_market_controller.dart';
import 'package:dont_waste/app/modules/food_market/views/food_market_view.dart';
import 'package:dont_waste/app/modules/frame/controllers/frame_controller.dart';
import 'package:dont_waste/app/modules/user_profile/bindings/user_profile_binding.dart';
import 'package:dont_waste/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:dont_waste/app/widgets/choice_card.dart';
import 'package:dont_waste/app/widgets/custom_loader_dialog.dart';
import 'package:dont_waste/app/widgets/divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import '../controllers/choice_view_controller.dart';

class ChoiceViewView extends GetView<ChoiceViewController> {
  @override
  Widget build(BuildContext context) {

    //print("locales-: " + Get.context.loca.currentLocale!.languageCode + " " );
    return Scaffold(

        appBar: AppBar(
          actions: [

            PopupMenuButton<String>(
                icon: Icon(Icons.language_sharp),
                onSelected: (String opt) {
                  if (opt == "UZ") {
                    final locale = Locale("uz", "UZ");
                    context.setLocale(locale);
                    EasyLocalization.of(context)!.setLocale(locale);
                    //EasyLocalization.of(context)!.currentLocale = locale;
                    Get.updateLocale(locale);
                  } else if (opt == "RU") {
                    final locale =(Locale("ru", "RU"));
                    context.setLocale(locale);
                    Get.updateLocale(locale);
                    EasyLocalization.of(context)!.setLocale(locale);
                  } else if (opt == "EN") {
                    final locale =(Locale("en", "EN"));
                    context.setLocale(locale);
                    Get.updateLocale(locale);
                    EasyLocalization.of(context)!.setLocale(locale);
                  }

                  //Get.offAndToNamed('/choice-view');

                },
                itemBuilder: (BuildContext context) {
                  return {'UZ', 'RU', 'EN'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: ListTile(
                        leading: Image.asset('assets/images/$choice.png', height: 30, width: 30,),
                        title: Text(choice),
                      ),
                    );
                  }).toList();
                },
              ),
          ],
          // leading: IconButton(
          //   icon: Icon(Icons.account_circle, size: 20.sp,), onPressed: ()async {
          //
          //   // showDialog(
          //   //   barrierDismissible: false,
          //   //   context: context,
          //   //   builder: (BuildContext context) {
          //   //     return CustomLoaderDialog();
          //   //     // return CustomComfirmationDialog(
          //   //     //   onCancel: () {},
          //   //     //   onConfirm: () {},
          //   //     //   text: "test",
          //   //     // );
          //   //   },
          //   // );
          //   //
          //   // await Future.delayed(Duration(milliseconds: 3500));
          //   // Get.back();
          //   // return;
          //
          //
          //   final auth = FirebaseAuth.instance;
          //   //auth.signOut();
          //   if (auth.currentUser != null) {
          //     // signed in
          //     UserProfileBinding().dependencies();
          //     await Get.find<UserProfileController>().setFoods();
          //     // Get.toNamed("/food-preview");
          //     Get.toNamed('/user-profile');
          //     //print("Signed");
          //   } else {
          //     print("Not signed in yet");
          //     Get.toNamed("/authentication");
          //   }
          //
          // },
          // ),
          title: Text("app_name".tr(),style: Theme.of(context).textTheme.bodyText1),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChoiceCard(
                text: "find_food".tr(),
                imageUrl: 'assets/images/burger.png',
                callback: () async{
                  // await FirebaseAuth.instance.verifyPhoneNumber(
                  //   phoneNumber: '+998901756001',
                  //   verificationCompleted: (PhoneAuthCredential credential) {},
                  //   verificationFailed: (FirebaseAuthException e) {},
                  //   codeSent: (String verificationId, int? resendToken) {},
                  //   codeAutoRetrievalTimeout: (String verificationId) {},
                  // );
                  //Get.to(() => FoodMarketView());
                  // FoodMarketBinding().dependencies();
                  // await Get.find<FoodMarketController>().setFoods();
                  //
                  // //await Future.delayed(Duration(seconds: 2));
                  // Get.toNamed("/food-market");
                  Get.find<FrameController>().changeTabIndex(1);
                },
              ),
              SizedBox(
                height: 40,
              ),
              CustomDivider(text: "or".tr()),
              SizedBox(
                height: 40,
              ),
              ChoiceCard(
                text: 'become_sponsor'.tr(),
                imageUrl: 'assets/images/lunch.png',
                callback: () {
                  //Get.to(() => BecomeSponsorView());
                  //Get.toNamed("/become-sponsor");
                  Get.find<FrameController>().changeTabIndex(2);
                },
              ),
              //ChoiceCard()
            ],
          ),
        ));
  }
}
