import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_nodejs_restapi/contollers/product/product_controller.dart';
import 'package:flutter_nodejs_restapi/contollers/product/product_image_controller.dart';
import 'package:flutter_nodejs_restapi/helpers/textstyle_helper.dart';
import 'package:flutter_nodejs_restapi/models/product/product_model.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({Key? key}) : super(key: key);

  final ProductController _controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductImageController());
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Ürün Ekle',
          style: TextStyle(fontSize: Get.width * 0.06),
        ),
      ),
      body: GetBuilder<ProductImageController>(
        builder: (imageController) {
          return SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: Get.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        imageController.pickedFile == null
                            ? const SizedBox()
                            : Image.file(
                                File(imageController.pickedFile!.path),
                                fit: BoxFit.cover,
                              ),
                        SizedBox(height: Get.width * 0.05),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width * 0.05), color: Colors.white),
                          child: IconButton(
                            onPressed: () {
                              imageController.pickImage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo_rounded,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _controller.productNameController,
                          style: TextStyleHelper.titleStyle,
                          decoration: const InputDecoration(labelText: "Ürün Adı"),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: _controller.descriptionController,
                          style: TextStyleHelper.titleStyle,
                          decoration: const InputDecoration(labelText: "Ürün Açıklaması"),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                        ),
                        TextFormField(
                          controller: _controller.priceController,
                          style: TextStyleHelper.titleStyle,
                          decoration: const InputDecoration(labelText: "Ürün Fiyatı"),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width * 0.05),
                    InkWell(
                      onTap: _controller.isLoading.value
                          ? () {
                              if (_controller.priceController.text.isNotEmpty &&
                                  _controller.descriptionController.text.isNotEmpty &&
                                  _controller.productNameController.text.isNotEmpty) {
                                final model = ProductModel(
                                  name: _controller.productNameController.text,
                                  price: int.parse(_controller.priceController.text),
                                  description: _controller.descriptionController.text,
                                );

                                _controller.priceController.clear();
                                _controller.descriptionController.clear();
                                _controller.productNameController.clear();
                                _controller.postProduct(model);
                                _controller.fetchProduct();
                                imageController.uploadImage();
                                Navigator.pop(context);
                              } else {
                                Get.snackbar("HATA", "Boş Alanları Doldurunuz");
                              }
                            }
                          : null,
                      child: Container(
                        padding: EdgeInsets.all(Get.width * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Get.width * 0.05),
                          color: Colors.indigo,
                        ),
                        child: Text(
                          'Ürünü Ekle',
                          style: TextStyleHelper.titleStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
