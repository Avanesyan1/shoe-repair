import 'package:flutter/material.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_styles.dart';

Padding buildShowZone(String title, text){
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.f12w400black,),
        const SizedBox(height: 2),
        Text(text, style: AppStyles.f16w600black,),
        const Divider(
          color: AppColors.greyO03,
        )
      ],
    ),
  );
}