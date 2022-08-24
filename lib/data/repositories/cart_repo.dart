import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  void addToCartList(List<CartModel> cartList) {
    cart = [];
    /*
    converting objects to strings because sharedpreferences only accept strings
     */
    cartList.forEach((element) {
     return cart.add(jsonEncode(element));
    });
    
    sharedPreferences.setStringList("Cart-list", cart);
    sharedPreferences.getStringList("Cart-list");
  }

  
}