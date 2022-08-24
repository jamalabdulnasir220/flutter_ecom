// the init method.
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/popular_product_controller.dart';
import 'package:ecommerce/data/api/api_client.dart';
import 'package:ecommerce/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/recommended_product.dart';
import '../data/repositories/cart_repo.dart';
import '../data/repositories/popular_product_repo.dart';
import '../data/repositories/recommended_product_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences);
  // api client
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL));
  // repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

  // controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
