import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contollers/product/product_controller.dart';
import '../../helpers/textstyle_helper.dart';
import 'update_product_screen.dart';

class DetailsPage extends StatelessWidget {
  int index;

  DetailsPage({Key? key, required this.index}) : super(key: key);

  final ProductController _controller = Get.put(ProductController());

  final String defaultImagePath = "http://10.0.2.2:3000/upload/";

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
                  child: _controller.productList[index].image == null
                      ? const Placeholder()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(Get.width * 0.05),
                          child: Image.network(
                            defaultImagePath + _controller.productList[index].image.toString(),
                            width: 800,
                          ),
                        ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'deleteBtn',
                    backgroundColor: Colors.red,
                    onPressed: () {
                      _controller.deleteProduct(_controller.productList[index]);
                      _controller.fetchProduct();
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.delete_rounded,
                      size: Get.width * 0.08,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'updateBtn',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProductPage(model: _controller.productList[index]),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit_note_rounded,
                      size: Get.width * 0.08,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
