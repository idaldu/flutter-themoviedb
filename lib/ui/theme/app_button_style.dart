import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';

abstract class AppButtonStyle {
  static const textButton =
      TextStyle(fontSize: 15, color: AppColors.mainLigthBlue);
  static const elevatedButton = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.mainLigthBlue));
}
