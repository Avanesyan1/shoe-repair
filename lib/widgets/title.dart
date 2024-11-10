import 'package:flutter/material.dart';
import 'package:shoe_repair/theme/app_styles.dart';

Padding buildTitle(String title){
  return Padding(
    padding: const EdgeInsets.only(bottom: 12, top: 8),
    child: Text(title, style: AppStyles.f16w600black,),
  );
}