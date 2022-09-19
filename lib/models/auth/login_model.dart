import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.user,
    this.token,
    this.success,
  });

  UserModel? user;
  String? token;
  bool? success;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "token": token,
        "success": success,
      };
}

class UserModel {
  UserModel({
    this.id,
    required this.email,
    required this.password,
    this.isAdmin,
    this.name,
    this.userName,
  });

  String? id;
  String email;
  String password;
  bool? isAdmin;
  String? name;
  String? userName;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "isAdmin": isAdmin,
        "password": password,
      };
}
