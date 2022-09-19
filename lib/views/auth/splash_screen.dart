import 'package:flutter/material.dart';
import 'package:flutter_nodejs_restapi/views/auth/login_screen.dart';
import 'package:flutter_nodejs_restapi/views/home/home_screen.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (box.read('token') != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
          child: Text(
            "Hoş Geldiniz...",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
