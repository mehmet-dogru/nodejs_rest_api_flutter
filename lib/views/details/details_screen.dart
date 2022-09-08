import 'package:flutter/material.dart';
import 'package:flutter_nodejs_restapi/contollers/product/product_controller.dart';
import 'package:flutter_nodejs_restapi/helpers/textstyle_helper.dart';
import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  int index;

  DetailsPage({Key? key, required this.index}) : super(key: key);

  final ProductController _controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(_controller.productList[index].name),
      ),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: index,
                child: Center(
                  child: _controller.isLoading.value
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(Get.width * 0.05),
                          child: Image.network(
                            _controller.productList[index].image.toString(),
                          ),
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(Get.width * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Get.width * 0.02),
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fiyat : " + _controller.productList[index].price.toString() + " TL",
                      style: TextStyleHelper.titleStyle,
                    ),
                    Text(
                      "Açıklama : " + _controller.productList[index].description,
                      style: TextStyleHelper.titleStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
