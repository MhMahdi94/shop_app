class FavouritesModel {
  bool? status;
  //Null? message;
  Data? data;

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<FavouritesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  //Null? nextPageUrl;
  String? path;
  int? perPage;
  //Null? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavouritesData>[];
      json['data'].forEach((v) {
        data!.add(FavouritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    //nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    //prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavouritesData {
  int? id;
  FavouritesProduct? product;

  FavouritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? FavouritesProduct.fromJson(json['product'])
        : null;
  }
}

class FavouritesProduct {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  FavouritesProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
