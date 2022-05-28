import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class AdSuggestionOnNotifications extends StatelessWidget {
  const AdSuggestionOnNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),


      //height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        //color: Colors.redAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 / 2),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
            offset: new Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 / 2),
              color: Colors.redAccent
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, color: Colors.white, size: 10.sp, ),
                SizedBox(width: 5,),
                Text(
                  "suggestion".tr(),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontSize: 10.sp),

                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("add_suggestion".tr(args: ["Bread", "5"]),
            textAlign: TextAlign.left,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall//?.copyWith(color: Colors.white),
          ),
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,

            width: double.infinity,
            decoration: BoxDecoration(
              color: yellow1,
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3.0,
                  offset: new Offset(0.0, 3.0),
                ),
              ],
              borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 / 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Advertise now", style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white),
                ),
                //SizedBox(width: 5,),
                Icon(Icons.arrow_right_rounded, color: Colors.white, size: 30.sp,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
