class CategoryDetailsModel {
  bool? status;
  //Null? message;
  CategoryDetailData? data;

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //  message = json['message'];
    data = json['data'] != null
        ? new CategoryDetailData.fromJson(json['data'])
        : null;
  }
}

class CategoryDetailData {
  dynamic currentPage;
  List<CategoryDetailProductData>? data;
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  //Null? nextPageUrl;
  String? path;
  dynamic perPage;
  // Null? prevPageUrl;
  dynamic to;
  dynamic total;

  CategoryDetailData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CategoryDetailProductData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryDetailProductData.fromJson(v));
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

class CategoryDetailProductData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  CategoryDetailProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
