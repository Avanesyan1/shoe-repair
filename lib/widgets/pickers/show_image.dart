import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_repair/theme/app_colors.dart';
import 'package:shoe_repair/theme/app_icons.dart';
import 'package:shoe_repair/theme/app_styles.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    super.key,
    required this.imagePath
  });
  final String imagePath; 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: size.height * 0.12,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white245
      ),
      child: imagePath != ''
        ? ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
        )
        : Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            children: [
              SvgPicture.asset(AppIcons.addPhoto),
              const Text('Загрузите фотографию\n(необязательно)', style: AppStyles.f12w700Opacity01,)
            ],
          ),
        )
    );
  }
}