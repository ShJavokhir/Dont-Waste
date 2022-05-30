import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/become_sponsor/bindings/become_sponsor_binding.dart';
import '../modules/become_sponsor/views/become_sponsor_view.dart';
import '../modules/bonus_coins/bindings/bonus_coins_binding.dart';
import '../modules/bonus_coins/views/bonus_coins_view.dart';
import '../modules/choice_view/bindings/choice_view_binding.dart';
import '../modules/choice_view/views/choice_view_view.dart';
import '../modules/contacts/bindings/contacts_binding.dart';
import '../modules/contacts/views/contacts_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/faq/bindings/faq_binding.dart';
import '../modules/faq/views/faq_view.dart';
import '../modules/food_market/bindings/food_market_binding.dart';
import '../modules/food_market/views/food_market_view.dart';
import '../modules/food_preview/bindings/food_preview_binding.dart';
import '../modules/food_preview/views/food_preview_view.dart';
import '../modules/frame/bindings/frame_binding.dart';
import '../modules/frame/views/frame_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/nearby-foods/bindings/nearby_foods_binding.dart';
import '../modules/nearby-foods/views/nearby_foods_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/statistics/bindings/statistics_binding.dart';
import '../modules/statistics/views/statistics_view.dart';
import '../modules/update_food_preview/bindings/update_food_preview_binding.dart';
import '../modules/update_food_preview/views/update_food_preview_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/views/user_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.FRAME;

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
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_FOOD_PREVIEW,
      page: () => UpdateFoodPreviewView(),
      binding: UpdateFoodPreviewBinding(),
    ),
    GetPage(
      name: _Paths.NEARBY_FOODS,
      page: () => NearbyFoodsView(),
      binding: NearbyFoodsBinding(),
    ),
    GetPage(
      name: _Paths.FRAME,
      page: () => FrameView(),
      binding: FrameBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.STATISTICS,
      page: () => StatisticsView(),
      binding: StatisticsBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTS,
      page: () => ContactsView(),
      binding: ContactsBinding(),
    ),
    GetPage(
      name: _Paths.BONUS_COINS,
      page: () => BonusCoinsView(),
      binding: BonusCoinsBinding(),
    ),
  ];
}
