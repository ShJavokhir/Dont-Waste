import 'dart:ui';

import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/donation-locations/controllers/donation_locations_controller.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/widgets/onmap_single_food_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';



import 'package:sizer/sizer.dart';
class DonationLocationsView extends GetView<DonationLocationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          //backgroundColor: Colors.white,
          elevation: 0.4,

          title: Container(
            child: Container(
              child: Text("donation_locations".tr(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1),
            ),
          ),

          centerTitle: true,
        ),
        body: Container(
          child: Stack(
            children: [
              Obx(
                    () =>
                    GoogleMap(

                      markers: Set<Marker>.of(controller.markers.values),
                      onMapCreated: (GoogleMapController controller) {
                        rootBundle
                            .loadString('assets/google-maps-style.json')
                            .then((String mapStyle) {
                          controller.setMapStyle(mapStyle);
                          this.controller.controller = controller;
                        });
                      },

                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      trafficEnabled: false,
                      mapType: MapType.normal,
                      rotateGesturesEnabled: false,
                      onCameraMove: (onCameraMove) {
                        // print("hello 1");
                        // //print("moved 22");
                        // controller
                        //     .longitude.value =
                        //     onCameraMove
                        //         .target.longitude;
                        // controller
                        //     .latitude.value =
                        //     onCameraMove
                        //         .target.latitude;
                        // // print(onCameraMove.target.latitude.toString());
                        // // print(onCameraMove.target.longitude.toString());
                      },
                      padding: EdgeInsets.all(10),
                      mapToolbarEnabled: false,
                      buildingsEnabled: false,
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      indoorViewEnabled: false,
                      initialCameraPosition:
                      CameraPosition(
                        target: controller.usersLocation!=null?LatLng(controller.usersLocation!.latitude ,controller.usersLocation!.longitude): LatLng(41.300027952448836, 69.24277207425287),
                        zoom: 11.5,
                      ),
                    ),
              ),
            ],
          ),
        ));
  }
}
