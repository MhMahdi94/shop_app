class ProductDetailsModel {
  bool? status;
  //Null? message;
  ProductDetailsData? data;

  ProductDetailsModel({this.status, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    data =
        json['data'] != null ? ProductDetailsData.fromJson(json['data']) : null;
  }
}

class ProductDetailsData {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String>? images;

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images'].cast<String>();
  }
}
