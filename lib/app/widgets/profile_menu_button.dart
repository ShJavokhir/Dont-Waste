import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class ProfileMenuButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String title;

  const ProfileMenuButton({
    required this.onTap,
    required this.iconData,
    required this.title
}) : super();


  @override
  Widget build(BuildContext context) {
    return Container(

      width: 100,
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors. black26,
              blurRadius: 3.0,
              offset: new Offset(0.5, 0.5),
            ),
          ],
          color: Colors.orange,
          borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0)
      ),
      child: Material(

        color: Colors.transparent,
        child: InkWell(
          //customBorder: new CircleBorder(),

          onTap: onTap,
          splashColor: Colors.white,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                  
                Icon(iconData, color: Colors.white, size: 25.sp,),
                Text(title, textAlign: TextAlign.center, maxLines: 2, style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,

                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
