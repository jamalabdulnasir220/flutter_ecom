
import 'package:ecommerce/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;


  CartModel(
      {this.id,
        this.name,
        this.quantity,
        this.price,
        this.isExist,
        this.img,
        this.time,
        this.product,
       });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    time = json['time'];
    img = json['img'];
    isExist = json['isExist'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
    "id": this.id,
    "name": this.name,
    "quantity": this.quantity,
    "price": this.price,
    "time": this.time,
    "img": this.img,
    "isExist": this.isExist,
      "product": this.product!.toJson(),
  };
  }

}