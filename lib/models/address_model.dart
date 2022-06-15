class AddressModel {
  bool? status;
  String? message;
  AddressData? data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AddressData.fromJson(json['data']) : null;
  }
}

class AddressData {
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  String? latitude;
  String? longitude;
  int? id;

  AddressData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
  }
}
