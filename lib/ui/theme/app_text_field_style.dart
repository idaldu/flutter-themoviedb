import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';

abstract class AppTextFieldStyle {
  static const mainTextField = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
    isCollapsed: true,
  );
  static const InputDecoration searchTextField = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
    isCollapsed: true,
    filled: true,
    fillColor: AppColors.mainWhite,
    labelText: 'Search',
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}
