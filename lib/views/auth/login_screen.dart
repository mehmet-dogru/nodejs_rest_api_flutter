import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contollers/auth/login_controller.dart';
import '../../models/auth/login_model.dart';
import 'register_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _loginPageAppBar('Giriş Yap'),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: Get.width * 0.85,
            height: Get.height,
            child: Column(
              children: [
                FlutterLogo(size: Get.width * 0.5),
                SizedBox(height: Get.width * 0.1),
                _emailTextFormField(),
                SizedBox(height: Get.width * 0.05),
                _passwordTextFormField(),
                SizedBox(height: Get.width * 0.1),
                _loginBtn(context),
                SizedBox(height: Get.width * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hesabın yok mu?',
                      style: TextStyle(
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Kayıt Ol!',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontStyle: FontStyle.italic,
                          fontSize: Get.width * 0.04,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _emailTextFormField() {
    return TextFormField(
      controller: _controller.emailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: const Icon(Icons.email_rounded),
        hintText: 'örnek@gmail.com',
        labelText: 'Email',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[900]!, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Get.width * 0.05),
          borderSide: BorderSide(color: Colors.blue[200]!, width: 1.0),
        ),
      ),
    );
  }

  TextFormField _passwordTextFormField() {
    return TextFormField(
      controller: _controller.passwordController,
      obscureText: true,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        icon: const Icon(Icons.visibility_rounded),
        labelText: 'Şifre',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[900]!, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Get.width * 0.05),
          borderSide: BorderSide(color: Colors.blue[200]!, width: 1.0),
        ),
      ),
    );
  }

  ElevatedButton _loginBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_controller.emailController.text.isNotEmpty && _controller.passwordController.text.isNotEmpty) {
          final user = UserModel(
            email: _controller.emailController.text,
            password: _controller.passwordController.text,
          );
          _controller.signIn(user, context);
        } else {
          Get.snackbar(
            'Giriş Yapılamadı',
            'Boş alan bırakılamaz',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      child: Text(
        'Giriş Yap',
        style: TextStyle(
          fontSize: Get.width * 0.05,
        ),
      ),
    );
  }

  AppBar _loginPageAppBar(String title) {
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
    );
  }
}
