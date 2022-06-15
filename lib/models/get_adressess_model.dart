class GetAddressesModel {
  bool? status;
  //Null? message;
  AddressesData? data;

  GetAddressesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    data = json['data'] != null ? AddressesData.fromJson(json['data']) : null;
  }
}

class AddressesData {
  dynamic currentPage;
  List<AddressItemData>? data;
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

  AddressesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AddressItemData>[];
      json['data'].forEach((v) {
        data!.add(AddressItemData.fromJson(v));
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

class AddressItemData {
  dynamic id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;

  AddressItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
