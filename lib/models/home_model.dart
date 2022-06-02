import 'package:shop_app/shared/constants.dart';

class HomeModel {
  bool? status;
  HomeProductDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeProductDataModel.fromjson(json['data']);
  }
}

class HomeProductDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  String? ad;

  HomeProductDataModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    //printFullText('products:${json['products'][0]}');
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
      //print(element['in_favorites']);
    });
    ad = json['ad'];
  }
}

class BannerModel {
  int? id;
  String? image;

/*
  {
                "id": 11,
                "image": "https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg",
                "category": null,
                "product": null
            },
 */
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

/*
  "id": 52,
                "price": 25000,
                "old_price": 25000,
                "discount": 0,
                "image": "https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg",
                "name": "ابل ايفون 12 برو ماكس - 256جيجابيت, ازرق",
               "in_favorites": false,
                "in_cart": false
 */
class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
