import 'package:flutter/material.dart';
import 'package:flutter_nodejs_restapi/contollers/product/product_controller.dart';
import 'package:flutter_nodejs_restapi/helpers/textstyle_helper.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final ProductController _controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.productList.length,
                itemBuilder: (context, index) {
                  return _productCard(index);
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Container _productCard(int index) {
    return Container(
      margin: EdgeInsets.all(Get.width * 0.02),
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(Get.width * 0.05),
      ),
      child: Padding(
        padding: EdgeInsets.all(Get.width * 0.04),
        child: Column(
          children: [
            _controller.productList[index].image == null
                ? const Placeholder()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(Get.width * 0.05),
                    child: Image.network(
                      _controller.productList[index].image!,
                      fit: BoxFit.cover,
                      scale: 4,
                    ),
                  ),
            SizedBox(height: Get.width * 0.03),
            Row(
              children: [
                Text(
                  "Ürün Adı : ",
                  style: TextStyleHelper.titleStyle,
                ),
                Text(
                  _controller.productList[index].name,
                  style: TextStyleHelper.subtitleStyle,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Ürün Açıklaması : ",
                  style: TextStyleHelper.titleStyle,
                ),
                Text(
                  _controller.productList[index].description,
                  style: TextStyleHelper.subtitleStyle,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Fiyat : ",
                  style: TextStyleHelper.titleStyle,
                ),
                Text(
                  _controller.productList[index].price.toString() + " TL",
                  style: TextStyleHelper.subtitleStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
