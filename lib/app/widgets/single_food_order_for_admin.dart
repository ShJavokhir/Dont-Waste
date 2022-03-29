import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';


class SingleFoodOrderForAdmin extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int views;
  final String location;
  final String photoUrl;
  final void Function() onView;
  final void Function() onEdit;
  final void Function() onDelete;

  SingleFoodOrderForAdmin(
      {required this.id,
        required this.onEdit,
        required this.onDelete,
        required this.onView,
        required this.title,
        required this.price,
        required this.location,
        required this.views,
        required this.photoUrl
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          color: black4,
          borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)),
      child: Column(
        children: [
          Expanded(
            flex: 2,
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
                      child: photoUrl.contains("http")?Image.network(
                        photoUrl,
                        fit: BoxFit.cover,
                      ):Image.asset('assets/images/default-photo.png',),
                    ),
                  ),
                ),
                Positioned(child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    
                    color: Colors.grey.withOpacity(0.8),


                    borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)
                  ),
                  child: Row(children: [
                    Icon(Icons.remove_red_eye, color: Colors.white, size: 12.sp,),
                    SizedBox(width: 5,),
                    Text("views".tr() + views.toString(), style: TextStyle(color: Colors.white, fontSize: 12.sp),),
                  ],),
                ), right:  20, top: 20,)
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Hero(
                    tag: id + '_foodTitleTag',
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 11.sp,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        location,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money_rounded,
                        size: 11.sp,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        price.toString(),
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onView,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("view".tr(), overflow: TextOverflow.ellipsis)),
                          style: ElevatedButton.styleFrom(
                            //padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                            ),
                            //side: BorderSide(width: 1, color: Colors.green),
                            primary: Colors.lightBlueAccent, // <-- Button color
                            onPrimary: Colors.white, // <-- Splash color
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onEdit,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("edit".tr(), overflow: TextOverflow.ellipsis, )),
                          style: ElevatedButton.styleFrom(
                            //padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                            ),
                            //side: BorderSide(width: 1, color: Colors.green),
                            primary: Colors.greenAccent, // <-- Button color
                            onPrimary: Colors.white, // <-- Splash color
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onDelete,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("delete".tr(), overflow: TextOverflow.ellipsis,)),
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
