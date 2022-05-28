import 'package:dont_waste/app/core/utils/datetime_utility.dart';
import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';
class OnMapSingleFoodOrder extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String location;
  final int? postedTimestamp;
  final bool isDonation;
  final bool isEatable;
  final bool isTop;
  final void Function() onPressed;

  const OnMapSingleFoodOrder({
    required this.id,
    required this.onPressed,
    required this.title,
    required this.price,
    required this.location,
    required this.isDonation,
    required this.isEatable,
    required this.isTop,


    required this.postedTimestamp
}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 200,
      //width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
              offset: new Offset(0.0, 3.0),
            ),
          ],

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
              style: Theme.of(context).textTheme.bodyText2,
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
                  price.toString(),
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),

          ),
          SizedBox(height: 10),

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
                size: 9.sp,
                color: Colors.black54,
              ),
              SizedBox(
                width: 5,
              ),
              FittedBox(
                child: Text(
                  DateTimeUtility.getReadableTime(postedTimestamp),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.normal),
                ),
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
    );
  }
}
