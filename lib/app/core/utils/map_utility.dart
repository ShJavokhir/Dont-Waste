import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await launch(googleUrl)) {
    } else {
      throw 'could_not_open_map';
    }
  }
}