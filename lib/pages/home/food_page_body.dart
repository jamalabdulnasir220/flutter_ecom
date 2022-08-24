
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/controller/recommended_product.dart';
import 'package:ecommerce/pages/food/popular_food_detail.dart';
import 'package:ecommerce/routes/route_helper.dart';
import 'package:ecommerce/widgets/big_text.dart';
import 'package:ecommerce/widgets/icon_and_text_widget.dart';
import 'package:ecommerce/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _scaleFactor = 0.8;
  double _height =Dimensions.pageViewContainer;
  var _currentPageValue = 0.0;
  // var _curScale = 0.8;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        // slider section
       GetBuilder<PopularProductController>(builder: (popularProducts){
         return  popularProducts.isLoaded?Container(
           //  color: Colors.redAccent,
           height: Dimensions.pageView,

             child: PageView.builder(
                 controller:pageController,
                 itemCount: popularProducts.popularProductList.length,
                 itemBuilder: (context, position){
                   return _buildPageItem(position, popularProducts.popularProductList[position]);
                 }),

         ):CircularProgressIndicator(
           color: AppColors.mainColor,
         );
       }),
    // dots
     GetBuilder<PopularProductController>(builder: (popularProducts){
      return  DotsIndicator(
        dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
        position: _currentPageValue,
        decorator: DotsDecorator(
          activeColor: AppColors.mainColor,
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      );
     }),

        // popular text
        SizedBox(height: Dimensions.height30,),

        Container(
          margin:EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              //  for the dot we put it in a container because we want to apply margin and scale to the top small
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing",),
              )
            ],
          ),
        ),

        // for displaying list of images and titles we use listview builder
        // every builder returns a function which returns a widget

          // height: 900,    is just here to help us to know the length of the items it was in a container together with the listview builder
        // recommended food
           GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
             return recommendedProduct.isLoaded?ListView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(), // making the whole page scrollable
                 itemCount: recommendedProduct.recommendedProductList.length,
                 itemBuilder: (context, index){
                   return GestureDetector(
                     onTap: (){
                       Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                     },
                     child: Container(
                       margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                       child: Row(
                         children: [
                           // image section
                           Container(
                             width:Dimensions.listViewImgSize,
                             height: Dimensions.listViewImgSize,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(Dimensions.radius20),
                                 color: Colors.white38,
                                 image: DecorationImage(
                                     fit: BoxFit.cover,
                                     image: NetworkImage(
                                         AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                     )
                                 )
                             ),
                           ),
                           // text container
                           // we wrap around expanded widget because we want the container to take all the available space
                           Expanded(
                             child: Container(
                               height: Dimensions.listViewTextContSize,
                               // width: 200,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(
                                   topRight: Radius.circular(Dimensions.radius20),
                                   bottomRight: Radius.circular(Dimensions.radius20),
                                 ),
                                 color: Colors.white,
                               ),
                               child: Padding(
                                 padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width5),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                     SizedBox(height: Dimensions.height10,),
                                     SmallText(text: "With chinese characteristics"),
                                     SizedBox(height: Dimensions.height10,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         IconAndTextWidget(icon: Icons.circle_sharp,
                                           text: "Normal",
                                           iconColor: AppColors.iconColor1,),
                                         SizedBox(width: Dimensions.width10,),
                                         IconAndTextWidget(icon: Icons.location_on,
                                             text: "1.7km",
                                             iconColor: AppColors.mainColor),
                                         SizedBox(width: Dimensions.width10,),
                                         IconAndTextWidget(icon: Icons.access_time_rounded,
                                             text: "32min",
                                             iconColor: AppColors.iconColor2)
                                       ],
                                     ),

                                   ],
                                 ),
                               ),
                             ),
                           )
                         ],
                       ),
                     ),
                   );
                 }
             ):CircularProgressIndicator(
               color: AppColors.mainColor,
             );
           }),

      ],
    );
  }
  Widget _buildPageItem(int index, popularProduct){
    Matrix4 matrix = Matrix4.identity(); // for scaling.. we use the matrix4 api
    if(index==_currentPageValue.floor()){
      var curScale = 1-(_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-curScale)/2;      // for changing the height
      matrix = Matrix4.diagonal3Values(1, curScale, 1)..setTranslationRaw(0, currTrans, 0); // the setTranslationRaw moves the container up and down

    } else if(index==_currentPageValue.floor()+1){
      var curScale = _scaleFactor+ (_currentPageValue-index+1)*(1 - _scaleFactor);
      var currTrans = _height*(1-curScale)/2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1);
      matrix = Matrix4.diagonal3Values(1, curScale, 1)..setTranslationRaw(0, currTrans, 0); // the setTranslationRaw moves the container up and down

    } else if(index==_currentPageValue.floor()-1){
      var curScale = 1-(_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-curScale)/2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1);
      matrix = Matrix4.diagonal3Values(1, curScale, 1)..setTranslationRaw(0, currTrans, 0); // the setTranslationRaw moves the container up and down
    }else {
      var curScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);
    }


    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven?  Color(0xFF69c5df): Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                         AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 0.5,
                      offset: Offset(0, 5)
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0)
                    )
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15),
                child: AppColumn(text: popularProduct.name!,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
