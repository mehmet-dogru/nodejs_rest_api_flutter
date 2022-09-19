import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/product/product_model.dart';
import 'product_image_controller.dart';

class ProductController extends GetxController {
  late final d.Dio _dio;
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final ProductImageController _imageController = Get.put(ProductImageController());

  var productList = <ProductModel>[].obs;

  var isLoading = true.obs;

  final String baseUrl = "http://10.0.2.2:3000/products";

  final box = GetStorage();

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

    String token = await box.read('token');
    final response = await _dio.get(baseUrl, options: d.Options(headers: {"Authorization": "Bearer $token"}));

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
    String token = await box.read('token');
    var formData = d.FormData.fromMap({
      'image': await d.MultipartFile.fromFile(_imageController.pickedFile!.path),
      'price': productModel.price,
      'name': productModel.name,
      'description': productModel.description,
    });

    await _dio.post(baseUrl, data: formData, options: d.Options(headers: {"Authorization": "Bearer $token"}));

    changeLoading();
  }

  Future<void> deleteProduct(ProductModel productModel) async {
    String token = await box.read('token');
    var result = await _dio.delete("$baseUrl/${productModel.id}", options: d.Options(headers: {"Authorization": "Bearer $token"}));

    log(result.toString());
  }

  Future<void> updateProduct(ProductModel productModel) async {
    String token = await box.read('token');
    var formData = d.FormData.fromMap({
      'image': await d.MultipartFile.fromFile(_imageController.pickedFile!.path),
      'price': productModel.price,
      'name': productModel.name,
      'description': productModel.description,
    });
    await _dio.patch('$baseUrl/${productModel.id}', data: formData, options: d.Options(headers: {"Authorization": "Bearer $token"}));
  }
}
