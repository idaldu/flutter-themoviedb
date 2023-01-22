import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';

abstract class AppTextStyle {
  static const mainText = TextStyle(
    color: AppColors.mainBlack,
    fontSize: 15,
  );

  static const boldText = TextStyle(
    color: AppColors.mainBlack,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static const greyText = TextStyle(
    color: AppColors.mainGrey,
    fontSize: 15,
  );

  static const errorText = TextStyle(
    color: Color.fromRGBO(244, 67, 54, 1),
    fontSize: 15,
  );
}
