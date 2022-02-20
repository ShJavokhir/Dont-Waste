import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../controllers/food_preview_controller.dart';

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
              tag: 'Delicious food' + '_foodTitleTag',
              child: Text(
                "Delicious hamburger",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'Delicious food_floatingButton',
          onPressed: () {},
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
                    tag: 'Delicious food' + 'foodImageTag',
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                      child: Image.network(
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
                                          'Tashkent',
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
                                          '15000 SUM',
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
                                compassEnabled: false,
                                indoorViewEnabled: true,
                                zoomControlsEnabled: false,
                                //liteModeEnabled: true,
                                onTap: (LatLang) {
                                  //should show on map
                                  print("showing map");
                                },
                                //liteModeEnabled: true,
                                zoomGesturesEnabled: false,
                                rotateGesturesEnabled: false,
                                scrollGesturesEnabled: false,
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: const LatLng(45.521563, -122.677433),
                                  zoom: 11.0,
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
                            '+998 901234567',
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
                            '1.25 kg',
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
                      'Very delicious stake. It will expiry in 72 hours, please contact us before that time',
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
