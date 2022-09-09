import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductImageController extends GetxController {
  late final d.Dio _dio;
  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _dio = d.Dio();
  }

  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  uploadImage() async {
    var formData = d.FormData.fromMap({
      "image": await d.MultipartFile.fromFile(_pickedFile!.path),
    });

    var response = await _dio.post("http://10.0.2.2:3000/products/upload", data: formData);
    print(response.data);
  }
}
