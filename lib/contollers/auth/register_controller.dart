import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/auth/login_model.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();

  var isLoading = true.obs;
  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio();
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> signUp(UserModel userModel) async {
    changeLoading();
    var _userData = {
      "name": userModel.name,
      "userName": userModel.userName,
      "email": userModel.email,
      "password": userModel.password,
    };

    var result = await _dio.post("http://10.0.2.2:3000/api/users", data: _userData);

    if (result.data['statusCode'] == 403) {
      Get.snackbar('Hata', result.data['message']);
    }

    print(result);
    changeLoading();
  }
}
