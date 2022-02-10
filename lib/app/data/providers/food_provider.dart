import 'package:get/get.dart';

import '../models/food_model.dart';

class FoodProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Food.fromJson(map);
      if (map is List) return map.map((item) => Food.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Food?> getFood(int id) async {
    final response = await get('food/$id');
    return response.body;
  }

  Future<Response<Food>> postFood(Food food) async => await post('food', food);
  Future<Response> deleteFood(int id) async => await delete('food/$id');
}
