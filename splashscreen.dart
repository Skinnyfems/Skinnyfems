import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'Home.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/cat and dog2.jpeg'), // image assets
      title: Text(
        "Perbedaan Aku Dan Kamu",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Memuat..."),
      navigator: Home(),
      durationInSeconds: 15,
    ); // Easysplashscreen
  }
}
