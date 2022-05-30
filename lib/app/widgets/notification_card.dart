import 'package:dont_waste/app/core/utils/datetime_utility.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationCard extends StatelessWidget {
  NotificationCard(
      {required this.title,
      required this.description,
      this.photo_url = "",
      required this.postedTimestamp,
      required this.onReadMore})
      : super();

  final String title;
  final String description;
  late final String photo_url;
  int postedTimestamp;
  final void Function() onReadMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING * 1.0),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
          Visibility(
            visible: photo_url.contains("http"),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3.0,
                      offset: new Offset(0.0, 3.0),
                    ),
                  ],
                //border: Border.all(color: Colors.black12, width: 1),
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 /2 )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 /2 ),
                child: photo_url.contains("http")?Image.network(
                  photo_url,
                  fit: BoxFit.cover,
                  isAntiAlias: false,
                ):Container(
                  //margin: EdgeInsets.all(50),

                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text(
            title,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    DateTimeUtility.getReadableTime(
                        postedTimestamp),
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onReadMore,
                child: Row(
                  children: [
                    Text(
                      "read_more".tr(),
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal),
                    ),
                    Icon(
                      Icons.arrow_right_rounded,
                      color: Colors.black54,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
