import 'package:get/get.dart';
class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  // 782/220 = 3.55 // where 782=the height of the screen and 220 the height of the container used.

  static double pageView = screenHeight/2.44; // Main page height is 320 so 782/320
  static double pageViewContainer = screenHeight/3.55;
  static double pageViewTextContainer = screenHeight/6.01; // height is 130 for the container staked on the bigger container

  // dynamic height padding and margin
  static double height10 = screenHeight/78.2;               // height 10 is 782/10 = 78.2
  static double height15 = screenHeight/52.1;
  static double height20 = screenHeight/39.1;        //    height 20 is 782/20 = 39.1
  static double height30 = screenHeight/26.0;
  static double height45 = screenHeight/17.3;
  // dynamic width padding and margin
  static double width10 = screenHeight/78.2;               // height 10 is 782/10 = 78.2
  static double width15 = screenHeight/52.1;
  static double width20 = screenHeight/39.1;
  static double width30 = screenHeight/26.0;
  static double width45 = screenHeight/17.3;
  static double width5 = screenHeight/156.4;
  static double width3 = screenHeight/260.6;
  // for the font size
  static double font16 = screenHeight/48.8;
  static double font20 = screenHeight/39.1;
  static double font26 = screenHeight/30.0;



  static double radius20 = screenHeight/39.1;
  static double radius30 = screenHeight/26.0;
  static double radius15 = screenHeight/52.1;

  // icon size
  static double iconsize24 = screenHeight/32.5;
  static double iconsize16 = screenHeight/48.8;

  // list view size
  static double listViewImgSize = screenHeight/6.5;
  static double listViewTextContSize = screenHeight/7.82;

  // popular food
  static double popularFoodImgSize = screenHeight/2.23;

  // bottom height

static double bottomHeightBar = screenHeight/6.5;

// splash screen dimensions

  static double splashImg = screenHeight/3.128;

}
