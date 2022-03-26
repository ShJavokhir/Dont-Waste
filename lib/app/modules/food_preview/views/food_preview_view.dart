import 'package:dont_waste/app/core/utils/map_utility.dart';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../controllers/food_preview_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodPreviewView extends GetView<FoodPreviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          title: Container(
            width: double.infinity,
            child: Hero(
              tag: controller.foodModel.id + '_foodTitleTag',
              child: Text(
                controller.foodModel.title ?? "null",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: controller.foodModel.id + '_floatingButton',
          onPressed: () {

            launch('tel://${controller.foodModel.phone_number!.replaceFirst("+", "")}');
          },
          backgroundColor: yellow1,
          splashColor: Colors.white,
          child: Icon(Icons.call),
        ),
        body: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(18),
                  child: Hero(
                    tag: controller.foodModel.id + 'foodImageTag',
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                      child: Image.network(
                        controller.foodModel.photo_url ??
                            'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_1280.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                  height: 15.h,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: yellow1,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 17.sp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.foodModel.city!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            //fontSize: 11.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: yellow1,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.attach_money_rounded,
                                        size: 17.sp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.foodModel.price
                                                  .toString() +
                                              ' SUM',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            //fontSize: 11.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          // onTap: () {
                          //   print("hello");
                          // },
                          child: Container(
                            decoration: BoxDecoration(
                                //color: yellow1,
                                borderRadius: BorderRadius.circular(24)),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                              child: GoogleMap(
                                mapToolbarEnabled: false,
                                tiltGesturesEnabled: false,
    liteModeEnabled: true,
                                markers: {
                                  Marker(
                                    consumeTapEvents: false,
                                      flat: false,
                                      alpha: 0.8,
                                      onTap: (){},
                                      position: (LatLng(
                                          controller.foodModel.location!.latitude,
                                          controller.foodModel.location!.longitude)),
                                      markerId: MarkerId("Location")
                                  )
                                },
                                compassEnabled: false,
                                indoorViewEnabled: false,
                                zoomControlsEnabled: false,
                                //liteModeEnabled: true,
                                onTap: (LatLang) {
                                  //should show on map
                                  print("showing map");
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text(
                                              "Food location",
                                              style: TextStyle(fontSize: 18.sp),
                                              textAlign: TextAlign.center,
                                            ),
                                            insetPadding: EdgeInsets.zero,
                                            contentPadding: EdgeInsets.all(15),
                                            actionsPadding: EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 5),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(BORDER_RADIUS_1 * 1.0))),
                                            content: Builder(
                                              builder: (context) {
                                                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                var height =
                                                    MediaQuery.of(context).size.height;
                                                var width = MediaQuery.of(context).size.width;

                                                return Container(
                                                  //padding: EdgeInsets.all(50),
                                                  //height: 50.h,
                                                  width: 85.w,
                                                  height: 40.h,
                                                  child: Expanded(child: LayoutBuilder(
                                                      builder: (BuildContext context,
                                                          BoxConstraints constraints) {
                                                        return Stack(
                                                            alignment: Alignment(0.0, 0.0),
                                                            children: <Widget>[
                                                              Container(
                                                                  padding: EdgeInsets.all(15),
                                                                  width: double.infinity,
                                                                  //height: 100,
                                                                  decoration: BoxDecoration(
                                                                    color: black4,
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        BORDER_RADIUS_1 *
                                                                            1.0),
                                                                  ),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        BORDER_RADIUS_1 *
                                                                            1.0),
                                                                    child: GoogleMap(
                                                                      markers: {
                                                                        Marker(
                                                                            position: (LatLng(
                                                                            controller.foodModel.location!.latitude,
                                                                            controller.foodModel.location!.longitude)),
                                                                          markerId: MarkerId("Location")
                                                                        )
                                                                      },
                                                                      myLocationButtonEnabled:
                                                                      true,
                                                                      myLocationEnabled: true,

                                                                      initialCameraPosition:
                                                                      CameraPosition(
                                                                        target: LatLng(
                                                                            controller.foodModel.location!.latitude,
                                                                            controller.foodModel.location!.longitude),
                                                                        zoom: 13.0,
                                                                      ),
                                                                    ),
                                                                  )),

                                                            ]);
                                                      })),
                                                );
                                              },
                                            ),
                                            actions: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                      onPressed: () async{
                                                        // controller.isLocationSelected.value =
                                                        // true;
                                                        // controller.moveCamera();
                                                        // //print(controller.longitude.value.toString());
                                                        Navigator.of(context).pop();
                                                        //controller.foodModel.location.latitude
                                                        MapUtils.openMap(controller.foodModel.location!.latitude, controller.foodModel.location!.longitude).catchError((onError)  {
                                                          print(onError.toString());
                                                          Get.snackbar("Error", onError.toString());
                                                        });

                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets.all(15),
                                                          //width: double.infinity,
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            "Show directions",
                                                            style: TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: 15.sp),
                                                          )),
                                                      style: ElevatedButton.styleFrom(
                                                        //padding: EdgeInsets.all(20),

                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(
                                                              BORDER_RADIUS_1 * 1.0),
                                                        ),
                                                        shadowColor: Colors.transparent,
                                                        //side: BorderSide(width: 1, color: Colors.green),
                                                        primary: green2,
                                                        // <-- Button color
                                                        onPrimary:
                                                        Colors.white, // <-- Splash color
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]);
                                      });

                                },
                                //liteModeEnabled: true,
                                zoomGesturesEnabled: false,
                                rotateGesturesEnabled: false,
                                scrollGesturesEnabled: false,
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      controller.foodModel.location!.latitude,
                                      controller.foodModel.location!.longitude),
                                  zoom: 13.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: black4,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Phone number:',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius:
                                BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          child: Text(
                            controller.foodModel.phone_number!,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: black4,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Quantity:',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius:
                                BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          child: Text(
                            controller.foodModel.quantity!.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
                  height: 150,
                  //alignment: Alignment.centerLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: black4,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    //alignment: Alignment.center,
                    height: double.infinity,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius:
                          BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                    ),
                    child: Text(
                      controller.foodModel.description!.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
