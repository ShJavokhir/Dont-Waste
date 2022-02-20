import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SingleFoodOrder extends StatelessWidget {
  final String title;
  final double price;
  final void Function() onPressed;
  SingleFoodOrder(
      {required this.onPressed, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black12, width: 1),
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)),
              child: Hero(
                tag: title + 'foodImageTag',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_1280.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                    tag: title + '_foodTitleTag',
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
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
                        'Tashkent',
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
                  Hero(
                    tag: title + '_floatingButton',
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text("Buy")),
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
