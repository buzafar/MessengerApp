import 'package:flutter/material.dart';



class SizeConfig {

  static late double screenWidth;
  static late double screenHeight;

  SizeConfig.init(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
  }

  static double w(double width) {
    double percentage = (width/screenWidth)*100;
    return screenWidth * (percentage/100);
  }

  static double h(double height) {
    double percentage = (height/screenHeight)*100;
    return screenHeight * (percentage/100);
  }

}