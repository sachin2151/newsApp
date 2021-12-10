
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_mvvm/screens/news_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';




class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
    navigateRoute: const NewsScreen(),
      duration: 5000,
      imageSize: 50,
      imageSrc: "assets/images/splash_logo.jpeg",
      text: "Top News Headlines",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w500,
      ),
      colors: const [
        Colors.black,
        Colors.yellow,
        Colors.black,
        Colors.yellow,
      ],
      backgroundColor: Colors.white,
    );

}}