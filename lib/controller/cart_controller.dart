// import 'package:ecommerce/models/product_model.dart';
// import 'package:get/get.dart';
//
// import '../data/repositories/cart_repo.dart';
// import '../models/cart_model.dart';
//
// class CartController extends GetxController{
//   final CartRepo cartRepo;
//
//   CartController({required this.cartRepo});
//   Map<int,CartModel> _items = {};
//
//   Map<int, CartModel> get items=>_items;
//
//   void addItem(ProductModel product, int quantity){
//            if(_items.containsKey(product.id!)){
//              _items.update(product.id!, (value){
//                return  CartModel(
//                  id:value.id,
//                  name:value.name,
//                  quantity:value.quantity!+quantity,
//                  price:value.price,
//                  isExist:true,
//                  img:value.img,
//                  time:DateTime.now().toString(),
//                );
//              });
//            }
//            else {
//             if(quantity>0){
//               _items.putIfAbsent(product.id!, () {
//                 return CartModel(
//                   id:product.id,
//                   name:product.name,
//                   quantity:quantity,
//                   price:product.price,
//                   isExist:true,
//                   img:product.img,
//                   time:DateTime.now().toString(),
//                 );}
//               );
//             }
//             else {
//            }
//
//
//   }
//
//   bool existInCart(ProductModel product){
//     if(_items.containsKey(product.id)){
//       return true;
//     } else {
//       return false;
//     }
//
//   }
//
//   int getQuantity(ProductModel product){
//     var quantity=0;
//     if(_items.containsKey(product.id)){
//       _items.forEach((key, value) {
//         if(key==product.id){
//           quantity=value.quantity!;
//         }
//       });
//     }
//     return quantity;
//   }
// }

import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repositories/cart_repo.dart';
import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int,CartModel> _items = {};

  Map<int, CartModel> get items=>_items;
  /*
    only for storage and shared preferences
  */
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity){
    var totalQuantity=0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+totalQuantity;
        return CartModel(
          id:  value.id,
          name: value.name,
          quantity: value.quantity!+quantity,
          price: value.price,
          isExist: true,
          img: value.img,
          time: DateTime.now().toString(),
          product: product,
        );}
      );

      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    } else {
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            quantity: quantity,
            price: product.price,
            isExist: true,
            img: product.img,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      }
      else {
        Get.snackbar(
                "item count", "you should atleast add one item in the card!",
                backgroundColor: AppColors.mainColor,
                colorText: Colors.white,
              );
      }
    }
    cartRepo.addToCartList(getItems);
    update();

  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity=value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
   return  _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart=cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems=items;
    // print("length of cart items "+storageItems.length.toString());
    for(int i=0; i<storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items={};
    update();

  }


  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }



}