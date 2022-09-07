import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_nodejs_restapi/models/product/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productList = <ProductModel>[].obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> fetchProduct() async {
    changeLoading();
    final response = await Dio().get("http://10.0.2.2:3000/products");

    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;

      if (_datas is List) {
        productList.value = _datas.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    changeLoading();
  }
}
