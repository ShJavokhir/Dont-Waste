import 'package:dont_waste/app/data/constants/constants.dart';

class CategoryUtility{
  static String getCategoryNameById(int catId){
    return Constants().categories[catId];
  }
}