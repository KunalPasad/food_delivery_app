import 'dart:developer';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }
    else{

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    }
    else{
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if((_inCartItems + quantity) < 0){
      Get.snackbar(
        "Item count", "You can't reduce more!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
      );
      if(_inCartItems > 0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }
    else if((_inCartItems + quantity) > 20){
      Get.snackbar(
        "Item count", "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }
    else{
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existsInCart(product);
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    print("The quantity int the cart is $_inCartItems");
  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The id is ${value.id}");
      print("The quantity is ${value.quantity}");
    });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}


// void main() {
//
//   var myMap = {
//     'name' : 'Kunal',
//     'age' : 19,
//     'city' : 'Mumbai',
//     'address' : [{
//       'country' : 'India',
//       'city' : 'Mumbai',
//     },
//       {
//         'country' : 'France',
//         'city' : 'Paris',
//       }
//     ]
//   };
//
//   var obj = Person.fromJson(myMap);
//   var myAddress = obj.address;
//   myAddress!.map((e){
//     print(e.city);
//   }).toList();
// }
//
// class Person{
//   String? name;
//   String? city;
//   int? age;
//   List<Address>? address;
//
//   Person({this.name, this.city, this.age, this.address});
//
//   Person.fromJson(Map<String, dynamic> json){
//     name = json['name'];
//     age = json['age'];
//     city = json['city'];
//     if(json['address'] != null){
//       address = <Address>[];
//       (json['address'] as List).forEach((e){
//         address!.add(Address.fromJson(e));
//       });
//     }
//   }
// }
//
// class Address{
//   String? country;
//   String? city;
//   Address({this.country, this.city});
//
//   Address.fromJson(Map<String, dynamic> json){
//     country = json['country'];
//     city = json['city'];
//   }
// }