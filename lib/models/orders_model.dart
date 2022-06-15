class OrdersModel {
  bool? status;
  String? message;
  OrdersData? data;

  OrdersModel({this.status, this.message, this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OrdersData.fromJson(json['data']) : null;
  }
}

class OrdersData {
  dynamic currentPage;
  List<OrdersItemData>? data;
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  //Null? nextPageUrl;
  String? path;
  dynamic perPage;
  //Null? prevPageUrl;
  dynamic to;
  dynamic total;

  OrdersData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <OrdersItemData>[];
      json['data'].forEach((v) {
        data!.add(OrdersItemData.fromJson(v));
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

class OrdersItemData {
  dynamic id;
  dynamic total;
  String? date;
  String? status;

  OrdersItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}
