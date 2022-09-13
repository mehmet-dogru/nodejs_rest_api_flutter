import 'package:flutter/material.dart';
import '../../contollers/product/product_controller.dart';
import '../../helpers/textstyle_helper.dart';
import '../details/add_product_screen.dart';
import '../details/details_screen.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final ProductController _controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _controller.fetchProduct();
            },
            icon: Icon(
              Icons.refresh_rounded,
              size: Get.width * 0.08,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Ürünler',
          style: TextStyle(color: Colors.black, fontSize: Get.width * 0.06),
        ),
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _controller.productList.length,
                itemBuilder: (context, index) {
                  return _productCard(index, context);
                },
              )
            : const Center(child: CircularProgressIndicator.adaptive()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_circle_rounded,
          size: Get.width * 0.1,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
      ),
    );
  }

  InkWell _productCard(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(index: index),
          ),
        );
      },
      child: Container(
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
                  : Hero(
                      tag: index,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Get.width * 0.05),
                        child: Image.network(
                          "http://10.0.2.2:3000/upload/" + _controller.productList[index].image!,
                          fit: BoxFit.cover,
                          width: 800,
                        ),
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
                  Expanded(
                    child: Text(
                      _controller.productList[index].description,
                      style: TextStyleHelper.subtitleStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
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
      ),
    );
  }
}
