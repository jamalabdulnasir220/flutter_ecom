
import 'package:ecommerce/pages/cart/cart_page.dart';
import 'package:ecommerce/pages/food/popular_food_detail.dart';
import 'package:ecommerce/pages/home/main_food_page.dart';
import 'package:ecommerce/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/food/recommended_food_detail.dart';
import '../pages/home/home_page.dart';

class RouteHelper {
  static const String splashPage="/splash-page";
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-page";

  static String getSplashPage()=>"$splashPage";
  static String getInitial()=>"$initial";
  static String getPopularFood(int pageId, String page)=>"$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page)=>"$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage()=>"$cartPage";

  static List<GetPage> routes = [
    GetPage(name: splashPage, page:()=>SplashScreen()),
    GetPage(name: initial, page: ()=>HomePage()),

    GetPage(name: popularFood, page: (){
      var page = Get.parameters["page"];
      var pageId = Get.parameters["pageId"];
     return PopularFoodDetail(pageId: int.parse(pageId!),page: page!);
  },
      transition: Transition.fadeIn
  ),

    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters["pageId"];
      var page = Get.parameters["page"];
      return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
    },
        transition: Transition.fadeIn
    ),
    
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
      transition: Transition.fadeIn
    )
  ];

}