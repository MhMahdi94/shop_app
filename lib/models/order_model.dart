class OrderModel {
  bool? status;
  String? message;
  OrderData? data;

  OrderModel({this.status, this.message, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OrderData.fromJson(json['data']) : null;
  }
}

class OrderData {
  String? paymentMethod;
  dynamic cost;
  dynamic vat;
  dynamic discount;
  dynamic points;
  dynamic total;
  dynamic id;

  OrderData.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    cost = json['cost'];
    vat = json['vat'];
    discount = json['discount'];
    points = json['points'];
    total = json['total'];
    id = json['id'];
  }
}
