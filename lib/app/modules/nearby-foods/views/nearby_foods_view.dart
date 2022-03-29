import 'dart:ui';

import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:dont_waste/app/modules/food_preview/bindings/food_preview_binding.dart';
import 'package:dont_waste/app/modules/food_preview/controllers/food_preview_controller.dart';
import 'package:dont_waste/app/widgets/onmap_single_food_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/nearby_foods_controller.dart';

class NearbyFoodsView extends GetView<NearbyFoodsController> {
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
              child: Text("Nearby foods",
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
                        zoom: 13.0,
                      ),
                    ),
              ),
              Positioned(

                child: (Container(
                  height: 200,
                  width: MediaQuery
                      .of(Get.context!)
                      .size
                      .width,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: Obx(
                    () => ListView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      //shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 10,),
                        Visibility(
                          visible: controller.foods.length==0,
                            child: Container(

                              //margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: red2,
                                borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                              width: MediaQuery.of(context).size.width - 20,
                              alignment: Alignment.center,
                              child: Text("There is no any foods near you", textAlign: TextAlign.center,),

                            )),
                        ...controller.foods.value.map((e) {
                          return OnMapSingleFoodOrder(id: e.id,
                              isDonation: e.isDonation ?? false,
                              location: e.city ?? "Tashkent",
                              onPressed: () {
                                FoodPreviewBinding().dependencies();
                                Get.find<FoodPreviewController>().foodModel = e;
                                Get.toNamed("/food-preview");
                              },
                              postedTimestamp: e.postedTimestamp,
                              price: e.price ?? 0.0,
                              title: e.title ?? "null");
                        }),

                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                  // ListView(
                  //
                  //   //scrollDirection: Axis.horizontal,
                  //   children: [
                  //     Text("salom")
                  //     //OnMapSingleFoodOrder(id: "test", isDonation: true, location: "Tashkent", onPressed: (){}, postedTimestamp: 180000000, price: 29.99, title: "Somsa"),
                  //   ],
                  // ),
                )
                ),
                bottom: 0,
                left: 0,
              )
            ],
          ),
        ));
  }
}
