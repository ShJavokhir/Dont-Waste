import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/become_sponsor/bindings/become_sponsor_binding.dart';
import '../modules/become_sponsor/views/become_sponsor_view.dart';
import '../modules/choice_view/bindings/choice_view_binding.dart';
import '../modules/choice_view/views/choice_view_view.dart';
import '../modules/food_market/bindings/food_market_binding.dart';
import '../modules/food_market/views/food_market_view.dart';
import '../modules/food_preview/bindings/food_preview_binding.dart';
import '../modules/food_preview/views/food_preview_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CHOICE_VIEW;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHOICE_VIEW,
      page: () => ChoiceViewView(),
      binding: ChoiceViewBinding(),
    ),
    GetPage(
        name: _Paths.FOOD_MARKET,
        page: () => FoodMarketView(),
        binding: FoodMarketBinding(),
        transitionDuration: Duration(milliseconds: 400),
        //opaque: true,
        transition: Transition.leftToRight),
    GetPage(
        name: _Paths.FOOD_PREVIEW,
        page: () => FoodPreviewView(),
        binding: FoodPreviewBinding(),
        transitionDuration: Duration(milliseconds: 400),
        //showCupertinoParallax: true,
        //showCupertinoParallax: true,
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: _Paths.BECOME_SPONSOR,
        page: () => BecomeSponsorView(),
        binding: BecomeSponsorBinding(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 400)
        //transition: Transition.leftToRightWithFade
        ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
  ];
}
