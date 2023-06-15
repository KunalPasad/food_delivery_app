import 'dart:developer';
import 'package:get/get.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:food_delivery_app/data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      log('got products');
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }
    else{

    }
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