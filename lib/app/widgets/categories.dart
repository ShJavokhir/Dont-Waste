import 'package:dont_waste/app/data/constants/colors.dart';
import 'package:dont_waste/app/data/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomCategories extends StatefulWidget {
  final Function(int) onCategorySelected;

  const CustomCategories({required this.onCategorySelected});

  @override
  State<CustomCategories> createState() => _CustomCategoriesState();
}

class _CustomCategoriesState extends State<CustomCategories> {
  final categories = Constants().categories;


  var selectedItem = 0;


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),

          itemCount: categories.length,
          itemBuilder: (ctx, cnt) {
            return cnt == selectedItem?GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = cnt;
                });
                widget.onCategorySelected(cnt);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10, left: cnt == 0?DEFAULT_PADDING * 1.0: 0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text(categories[cnt].tr(), style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold
                    ),)),
                  ),
                ),
              ),
            ):GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = cnt;
                });
                widget.onCategorySelected(cnt);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10,left: cnt == 0?DEFAULT_PADDING * 1.0: 0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),

                  decoration: BoxDecoration(
                    color: black4,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_1 * 1.0 / 2),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text(categories[cnt].tr(), style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500
                    ),)),
                  ),
                ),
              ),
            );
          }
      ),

    );
  }
}
