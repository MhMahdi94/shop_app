class LoginModel {
  bool? status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> model) {
    print('model: ${model['data']}');
    status = model['status'];
    message = model['message'];
    data = model['data'] != null ? UserData.fromJson(model['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserData.fromJson(Map<String, dynamic> model) {
    id = model['id'];
    name = model['name'];
    email = model['email'];
    phone = model['phone'];
    image = model['image'];
    token = model['token'];
  }
}
