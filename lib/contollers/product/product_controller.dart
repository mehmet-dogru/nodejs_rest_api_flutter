import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'product_image_controller.dart';
import 'package:flutter_nodejs_restapi/models/product/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  late final d.Dio _dio;
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final ProductImageController _imageController = Get.put(ProductImageController());

  var productList = <ProductModel>[].obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _dio = d.Dio();
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
    var formData = d.FormData.fromMap({
      'image': await d.MultipartFile.fromFile(_imageController.pickedFile!.path),
      'price': productModel.price,
      'name': productModel.name,
      'description': productModel.description,
    });

    await _dio.post("http://10.0.2.2:3000/products", data: formData);

    changeLoading();
  }

  Future<void> deleteProduct(ProductModel productModel) async {
    var result = await _dio.delete("http://10.0.2.2:3000/products/${productModel.id}");

    log(result.toString());
  }

  Future<void> updateProduct(ProductModel productModel) async {
    var formData = d.FormData.fromMap({
      'image': await d.MultipartFile.fromFile(_imageController.pickedFile!.path),
      'price': productModel.price,
      'name': productModel.name,
      'description': productModel.description,
    });
    await _dio.patch('http://10.0.2.2:3000/products/${productModel.id}', data: formData);
  }
}
