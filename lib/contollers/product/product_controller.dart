import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_nodejs_restapi/models/product/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  late final Dio _dio;
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  var productList = <ProductModel>[].obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio();
    fetchProduct();
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> fetchProduct() async {
    changeLoading();
    final response = await _dio.get("http://10.0.2.2:3000/products");

    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;

      if (_datas is List) {
        productList.value = _datas.map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    changeLoading();
  }

  Future<void> postProduct(ProductModel productModel) async {
    changeLoading();
    var _data = {
      'price': productModel.price,
      'name': productModel.name,
      'description': productModel.description,
      //'image': productModel.image,
    };

    await _dio.post("http://10.0.2.2:3000/products", data: _data);

    changeLoading();
  }


 
}
