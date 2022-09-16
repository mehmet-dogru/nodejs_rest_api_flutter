import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contollers/auth/register_controller.dart';
import '../../models/auth/user_model.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final RegisterController _controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _signUpPageAppBar('Kayıt Ol'),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: Get.width * 0.85,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.width * 0.01),
                  child: TextFormField(
                    controller: _controller.nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Örn: Mehmet Doğru',
                      labelText: 'Ad Soyad',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[900]!, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.05),
                        borderSide: BorderSide(color: Colors.blue[200]!, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.width * 0.01),
                  child: TextFormField(
                    controller: _controller.userNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person_outline_rounded),
                      hintText: 'Örn: mehmtdgru',
                      labelText: 'Kullanıcı Adı',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[900]!, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.05),
                        borderSide: BorderSide(color: Colors.blue[200]!, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.width * 0.01),
                  child: TextFormField(
                    controller: _controller.emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email_rounded),
                      hintText: 'Örn: örnek@gmail.com',
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[900]!, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.05),
                        borderSide: BorderSide(color: Colors.blue[200]!, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.width * 0.01),
                  child: TextFormField(
                    controller: _controller.passwordController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.visibility),
                      labelText: 'Şifre',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[900]!, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.05),
                        borderSide: BorderSide(color: Colors.blue[200]!, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.width * 0.01),
                  child: TextFormField(
                    controller: _controller.passwordAgainController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.visibility),
                      labelText: 'Şifre Tekrar',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[900]!, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Get.width * 0.05),
                        borderSide: BorderSide(color: Colors.blue[200]!, width: 1.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.width * 0.05),
                _signUpBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _signUpBtn() {
    return ElevatedButton(
      onPressed: () {
        if (_controller.nameController.text.isNotEmpty &&
            _controller.userNameController.text.isNotEmpty &&
            _controller.emailController.text.isNotEmpty &&
            _controller.passwordAgainController.text.isNotEmpty &&
            _controller.passwordController.text.isNotEmpty) {
          if (_controller.passwordController.text == _controller.passwordAgainController.text) {
            final user = UserModel(
              email: _controller.emailController.text,
              password: _controller.passwordController.text,
              name: _controller.nameController.text,
              userName: _controller.userNameController.text,
            );

            _controller.signUp(user);
          } else {
            Get.snackbar('HATA', "Girilen şifreler aynı değil");
          }
        } else {
          Get.snackbar('HATA', 'Boş alan bırakılmaz');
        }
      },
      child: Text(
        'Kayıt Ol',
        style: TextStyle(
          fontSize: Get.width * 0.05,
        ),
      ),
    );
  }

  AppBar _signUpPageAppBar(String title) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: Get.width * 0.05,
        ),
      ),
      foregroundColor: Colors.black,
    );
  }
}
