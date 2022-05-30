import 'package:dont_waste/app/core/utils/datetime_utility.dart';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class SingleFoodOrder extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String location;
  final String photo_url;
  final int? postedTimestamp;
  final bool isDonation;
  final bool isEatable;
  final bool isTop;

  final void Function() onPressed;
  SingleFoodOrder(
      {required this.id,
      required this.onPressed,
      required this.title,
      required this.price,
      required this.location,
        required this.isDonation,
        required this.photo_url,
        required this.postedTimestamp,
        required this.isEatable,
        required this.isTop
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            color: black4,
            borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)),
                    child: Hero(
                      tag: id + 'foodImageTag',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                        child: photo_url.contains("http")?Image.network(
                          photo_url,
                          fit: BoxFit.cover,
                          isAntiAlias: false,
                        ):Container(
                          //margin: EdgeInsets.all(50),
                            child: Image.asset('assets/images/default-photo.png', fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isEatable,
                    child: Positioned(
                      bottom: 15,
                      left: 15,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        //width: 50,
                        //height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning, color: Colors.white, size: 10.sp,),
                            SizedBox(width: 5,),
                            Text("expired".tr(), style: TextStyle(
                              fontSize: 9.sp,
                              color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),

                  ),
                  Visibility(
                    visible: isTop,
                    child: Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(8),
                        //width: 50,
                        //height: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(BORDER_RADIUS_1 * 1.0), bottomRight: Radius.circular(BORDER_RADIUS_1 * 1.0)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.flash_on_rounded, color: Colors.white, size: 10.sp),
                            SizedBox(width: 5,),
                            Text("top".tr(), style: TextStyle(
                                fontSize: 9.sp,
                                color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)),
                child: Column(

                  children: [
                    SizedBox(height: 10),
                    Hero(
                      tag: id + '_foodTitleTag',
                      child: Text(
                        title,

                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12.sp),
                        maxLines: 2,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Visibility(
                      visible: !isDonation,
                      child: Row(
                        children: [
                          Icon(
                            Icons.money_rounded,
                            size: 12.sp,
                            color: Colors.black87,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            price.toString() + " uzs",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isDonation,
                      child: Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            size: 13.sp,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "free".tr(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 9.sp,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          location,
                          style: TextStyle(
                              fontSize: 9.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 10.sp,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateTimeUtility.getReadableTime(postedTimestamp),
                          style: TextStyle(
                              fontSize: 9.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    !isDonation?Hero(
                      tag: id + '_floatingButton',
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: FittedBox(child: Text("buy_button".tr()))),
                        style: ElevatedButton.styleFrom(
                          //padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          //side: BorderSide(width: 1, color: Colors.green),
                          primary: yellow1, // <-- Button color
                          onPrimary: Colors.white, // <-- Splash color
                        ),
                      ),
                    ):Hero(
                      tag: id + '_floatingButton',
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: FittedBox(child: Text("get_donation".tr()))),
                        style: ElevatedButton.styleFrom(
                          //padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                          ),
                          //side: BorderSide(width: 1, color: Colors.green),
                          primary: Colors.redAccent, // <-- Button color
                          onPrimary: Colors.white, // <-- Splash color
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
    );
  }
}
